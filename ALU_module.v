module ALUControl( ALU_Control, ALUOp, Function);  
output reg[2:0] ALU_Control;  
input [1:0] ALUOp;  
input [3:0] Function;  
wire [5:0] ALUControlIn;  
assign ALUControlIn = {ALUOp,Function};  
always @(ALUControlIn)  
casex (ALUControlIn)  
	6'b11xxxx: ALU_Control=3'b000;  
	6'b10xxxx: ALU_Control=3'b100;  
	6'b01xxxx: ALU_Control=3'b001;  
	6'b000000: ALU_Control=3'b000;  
	6'b000001: ALU_Control=3'b001;  
	6'b000010: ALU_Control=3'b010;  
	6'b000011: ALU_Control=3'b011;  
	6'b000100: ALU_Control=3'b100;  
	default: ALU_Control=3'b000;  
	endcase  
endmodule  




//performs operation on some input data 
module alu(       
	input          [15:0]     a,          //src1  
	input          [15:0]     b,          //src2  
	input          [2:0]     alu_control, //function sel  
	output     reg     [15:0]     result, //result       
	output zero  
   );  
always @(*)
begin   
	case(alu_control)  
	3'b000: result = a + b; // add  
	3'b001: result = a - b; // sub  
	3'b010: result = a & b; // and  
	3'b011: result = a | b; // or  
	3'b100: begin if (a<b) result = 16'd1;  
				  else result = 16'd0;  
			end  
	default:result = a + b; // add  
	endcase  
end  
assign zero = (result==16'd0) ? 1'b1: 1'b0;  
endmodule 