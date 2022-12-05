module ControlUnit(opcode, reg_dest, branch, mem_read, mem_to_reg, alu_op, mem_write, alu_src, reg_write);

input [5:0] opcode; //31:26

output wire reg_dest;
output wire branch;
output wire mem_read;
output wire mem_to_reg;
output wire [1:0] alu_op;
output wire mem_write;
output wire alu_src;
output wire reg_write;

assign reg_dest = (opcode == 6'h00); //LW
assign branch = (opcode == 6'h04); //beq
assign mem_read = (opcode == 6'h23); //LW opcode
assign mem_to_reg = (opcode == 6'h23); //LW
assign alu_op = {{(opcode == 6'h00)}, {(opcode == 6'h04)}};
assign mem_write = (opcode == 6'h2B);
assign alu_src = (opcode == 6'h23) || (opcode == 6'h2B); //Only on lw or sw
assign reg_write = (opcode == 6'h00) || (opcode == 6'h23); //Only on r-type or lw

endmodule
