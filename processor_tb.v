`timescale 1ns / 1ps
//~~Compile
// iverilog -o testbench.vvp testbench.v
// vvp testbench.vvp

//fpga4student.com: FPGA projects, Verilog projects, VHDL projects
// Verilog project: Verilog code for 16-bit MIPS Processor
// Testbench Verilog code for 16 bit single cycle MIPS CPU  

`include "processor_module.v"

module tb_mips16;  
	// Inputs  
	reg clk;  
	reg reset;  
	// Outputs  
	wire [15:0] pc_out;  
	wire [15:0] alu_result;//,reg3,reg4;  
	// Instantiate the Unit Under Test (UUT)  

	wire [15:0] reg2;
	wire [15:0] reg3;
	wire [15:0] reg1;
	mips_16 uut (  
		.clk(clk),   
		.reset(reset),   
		.pc_out(pc_out),   
		.alu_result(alu_result),  
		.reg2(reg2),  
		.reg3(reg3),
		.reg1(reg1)  
	);  
	initial begin  

		clk = 0;  
		forever #10 clk = ~clk;  
	end  
	initial begin  
		$dumpfile("dump.vcd");
		$dumpvars(0, tb_mips16);
		// Initialize Inputs  
		$monitor ("register 2=%d, register 3=%d, register 1=%d", reg2,reg3,reg1);  
		reset = 1;  
		// Wait 100 ns for global reset to finish  
		#100;  
		reset = 0;  
		// Add stimulus here  
	end  
endmodule  