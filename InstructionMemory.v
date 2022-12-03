module InstructionMemory(address, instruction);

input [31:0] address;
output wire [31:0] instruction;

reg [7:0] memArr [31:0]; //Read as hex digits

initial begin
    $readmemh("instruction_memory.mem", memArr);
end

assign instruction = {memArr[address+3], memArr[address+2], memArr[address+1], memArr[address]};

endmodule