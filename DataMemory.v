module DataMemory(address, write_data, read_enable, write_enable, clk, read_data);

input [31:0] address;
input [31:0] write_data; //Pairs with mem_write
input read_enable; //Can only read or write at any given moment. Not both at once
input write_enable;
input clk;
//output reg [31:0] read_data; //Hates to compile here
output wire [31:0] read_data;

reg [7:0] memArr [31:0]; //of memory

initial begin
    $readmemh("data_memory2.mem", memArr);
end

always @(posedge clk)
begin
    memArr[address] <= write_enable ? write_data[7:0] : memArr[address];
    memArr[address+1] <= write_enable ? write_data[15:8] : memArr[address+1];
    memArr[address+2] <= write_enable ? write_data[23:16] : memArr[address+2];
    memArr[address+3] <= write_enable ? write_data[31:24] : memArr[address+3];    

    
    // read_data <= read_enable ? {memArr[address+3],memArr[address+2], memArr[address+1],memArr[address]} 
    //                          : {32{read_enable}}; //ElectroBinary has these assigned as bytes, not words.
end

assign read_data = {memArr[address+3],memArr[address+2],
                        memArr[address+1],memArr[address]}; //ElectroBinary has these assigned as bytes, not words.

endmodule
