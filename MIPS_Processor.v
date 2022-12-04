
module MIPS32_Processor(clk, reset);
input clk;
input reset;

wire [31:0] PC_out;
wire [31:0] instruction;
wire [31:0] PC_in;
wire [31:0] address_plus_4;
wire [31:0] shifted_address;
wire [31:0] reg1_out;
wire [31:0] reg2_out;
wire [31:0] mem_out;
wire [31:0] mem_to_reg;
wire [31:0] alu_result;
wire [31:0] sign_ext_out;
wire [31:0] alu_src_out;
wire [31:0] jump_branch_add_out;
wire [5:0] alu_ctrl_out;
wire ctrl_reg_dest;
wire ctrl_branch;
wire ctrl_mem_read;
wire ctrl_mem_to_reg;
wire [1:0] ctrl_alu_op;
wire ctrl_mem_write;
wire ctrl_alu_src;
wire ctrl_reg_write;
wire [4:0]writeRegNbr;
wire zero_out;

ProgramCounter PC (.clk (clk), 
                   .reset (reset),
                   .address_in (PC_in),
                   .address_out (PC_out));

InstructionMemory IMem (.address (PC_out), 
                        .instruction (instruction));

Registers32 regFile (.reg1_address (instruction[25:21]), 
                     .reg2_address (instruction[20:16]),
                     .write_enable (ctrl_reg_write), 
                     .write_data (mem_to_reg),
                     .write_register (writeRegNbr),
                     .clk (clk), 
                     .reset (reset), 
                     .reg1_read (reg1_out), 
                     .reg2_read (reg2_out));

DataMemory DMem (.address (alu_result),
                 .write_data (reg2_out),
                 .read_data (mem_out),
                 .clk (clk),
                 .read_enable (ctrl_mem_read),
                 .write_enable (ctrl_mem_write));

SignExtensionUnity SEUnit (.bits_in (instruction[15:0]),
                           .bits_out (sign_ext_out));

ShiftLUnit SLUnit (.address_in (sign_ext_out),
                   .address_out (shifted_address));

ALU_Top ALU (.opcode (instruction[31:26]),
             .func_field (instruction[5:0]),
             .A (reg1_out),
             .B (alu_src_out),
             .result (alu_result),
             .zero (zero_out));

ControlUnit control (.opcode (instruction[31:26]),
                     .reg_dest (ctrl_reg_dest),
                     .branch (ctrl_branch),
                     .mem_read (ctrl_mem_read),
                     .mem_to_reg (ctrl_mem_to_reg),
                     .alu_op (ctrl_alu_op),
                     .mem_write (ctrl_mem_write),
                     .alu_src (ctrl_alu_src),
                     .reg_write (ctrl_reg_write));

//Multiplexer connections

//Register Destination
assign writeRegNbr = ctrl_reg_dest ? instruction[15:11] : instruction[20:16];

//ALU Source
assign alu_src_out = ctrl_alu_src ? sign_ext_out : reg2_out;

//Memory To Register
assign mem_to_reg = ctrl_mem_to_reg ? mem_out : alu_result;

//Branch or Address + 4
assign PC_in = (ctrl_branch && zero_out) ? jump_branch_add_out : address_plus_4;

//Adders
SimpleAdder32 address_increment_adder (.a (4),
                                       .b (PC_out),
                                       .sum (address_plus_4));

SimpleAdder32 jump_offset_adder (.a (address_plus_4),
                                 .b (shifted_address),
                                 .sum (jump_branch_add_out));


endmodule

module SimpleAdder32 (a, b, sum);

input [31:0] a;
input [31:0] b;
output wire [31:0] sum;

assign sum = a + b;

endmodule
