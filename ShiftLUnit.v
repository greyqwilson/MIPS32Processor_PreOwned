module ShiftLUnit(address_in, address_out);

input [31:0] address_in;
output [31:0] address_out;

assign address_out = address_in << 2;

endmodule