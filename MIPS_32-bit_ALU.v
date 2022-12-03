module ALU_Control(opcode, func_field, alu_control);

input [5:0] opcode;
input [5:0] func_field;
output reg [2:0] alu_control;
reg [2:0] func_code;

//Implements
// opcode   func_field  Operation  --Output (sends this number to alu_core)
// h00      h20         ADD        --(alu_control 0)
// h00      h22         SUB        --(alu_control 1)
// h00      h24         AND        --(alu_control 2)
// h00      h25         OR         --(alu_control 3)
// h00      h27         NOR        --(alu_control 4)
// h00      h2A         SLT        --(alu_control 5)
// h23      ---         LW         --(alu_control 0)
// h2B      ---         SW         --(alu_control 0)
// h04      ---         BEQ        --(alu_control 1)

always @ (*) //Always at any change, evaluate everything
begin
    case (func_field)
    6'h20: func_code = 3'h0; //6'h20 here means take input of 6 bit number declared as hex number 20, aka 18 in decimal or 010010 in binary
    6'h22: func_code = 3'h1; //the 3'h1 part means assign func_code to be the 3 bit number declared as hex 1, aka decimal 1, or 000001 in binary
    6'h24: func_code = 3'h2;
    6'h25: func_code = 3'h3;
    6'h27: func_code = 3'h4;
    6'h2A: func_code = 3'h5;
    default: func_code = 3'h0;
    endcase

    case (opcode)
    6'h00: alu_control = func_code; //Copy whatever the func_code was assigned
    6'h04: alu_control = 3'h1;      //Function code is subtract, operation is brance on equal to
    6'h23: alu_control = 3'h0;      //Function code is add. Operation is load word
    6'h2B: alu_control = 3'h0;      //Function code is add. Operation is store word
    default: alu_control = 3'h0;
    endcase
end

endmodule

module ALU_Core(alu_control, A, B, result, zero);
//Supports AND, OR, ADD, SUB, SLT, NOR, LW, SW, BEQ
input [2:0] alu_control;
input [31:0] A;
input [31:0] B;
output reg [31:0] result;
output wire zero;

assign zero = !(|result); //Reduce our 32-bit result to a single expression
                          //so we OR our entire result. AKA when expression is NOT zero, it is 1
                          //We then logical NOT the expression. This assures we will have zero whenever we get a number that is not zero

always @ (*)
begin
    case(alu_control)
    3'h0: result = A + B;       //Addition
    3'h1: result = A - B;       //Subtraction
    3'h2: result = A & B;       //AND
    3'h3: result = A | B;       //OR
    3'h4: result = ~(A | B);    //NOR
    3'h5: result = (A < B);     //SLT
    default: result = A + B;    //Addition
    endcase
end
endmodule

module ALU_Top(opcode, func_field, A, B, result, zero);

input [5:0] opcode;
input [5:0] func_field;
input [31:0] A;
input [31:0] B;
output [31:0] result;
output zero;

wire [2:0] alu_control;

ALU_Control aluctrl_inst (.opcode (opcode), 
                          .func_field (func_field),
                          .alu_control (alu_control));
ALU_Core alucore_inst (.A (A),
                       .B (B),
                       .alu_control (alu_control),
                       .result (result),
                       .zero (zero));
endmodule
