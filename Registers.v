module Registers32(reg1_address, reg2_address, write_enable, write_register, write_data, clk, reset, reg1_read, reg2_read);

input [4:0] reg1_address;
input [4:0] reg2_address;
input write_enable;
input [4:0] write_register;
input [31:0] write_data;
input clk;
input reset;

output [31:0] reg1_read;
output [31:0] reg2_read;

reg [31:0] registerArr [0:31]; //Registers 0 thru 31

initial begin
    $readmemh("reg_memory.mem", registerArr);
end

assign reg1_read = registerArr[reg1_address];
assign reg2_read = registerArr[reg2_address];

always @(posedge clk or negedge reset) //Read every cycle
begin
    if (!reset) //On website this is rst_n. I believe this is to keep data alive??
    begin
        registerArr[write_register] <= registerArr[write_register];
    end

    else
    begin
        registerArr[write_register] <= write_enable ? write_data : registerArr[write_register];
    end
end

endmodule;