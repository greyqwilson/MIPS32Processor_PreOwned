module ProgramCounter(address_in, clk, reset, address_out);
input [31:0] address_in;
input clk;
input reset;
output reg [31:0] address_out;

always @(posedge clk or negedge reset)
begin
    if (!reset)
    begin
        address_out <= 32'd0;
    end
   
    else
    begin
        address_out <= address_in;
    end
end
endmodule