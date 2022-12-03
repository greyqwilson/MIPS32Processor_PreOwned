module SignExtensionUnity(bits_in, bits_out);
input [15:0] bits_in;
output [31:0] bits_out;

assign bits_out = {{16{bits_in[15]}}, bits_in[15:0]}; //Number is sign extended by concatenating bit 15

endmodule