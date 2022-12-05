module instr_mem          // a synthesisable rom implementation  
(  
	input     [15:0]     pc,  
	output wire     [15:0]          instruction  
);  
	wire [3 : 0] rom_addr = pc[4 : 1];  //take 3 bits after the least significant bit because we expect a word address not a byte address  
	/* lw     $3, 0($0) --   
		Loop:     slti $1, $3, 50  
		beq $1, $0, Skip  
		add $4, $4, $3   
		addi $3, $3, 1   
		beq $0, $0, Loop--  
		Skip  
*/  
	reg [15:0] rom[15:0];  
	initial  
	begin  
			rom[0] = 16'b0000010110010000; //0590 add $1 + $3 => $1
			rom[1] = 16'b1000000110110010; //2CB2 LW into $3 <= address of $0 offset by 50 
			//  rom[1] = 16'b0000010100110000; //add together reg 1 to register 2 into register 3 (expected result: 4+1 = 5 based on reg initial vals)
			rom[2] = 16'b0100000000001000; //jumps to the PC address held in register $0... since $0 is the zero register, it will start at beginning (first) instruction
			//  rom[2] = 16'b1101110001100111; //DC67 11001110 + 0000110 = 11010100 (212)= PCbranch target address -> way out of scope from here, so "skip"
			rom[3] = 16'b1101110111011001; //DDD9
			rom[4] = 16'b1111110110110001;  
			rom[5] = 16'b1100000001111011; 
			rom[6] = 16'b0000000000000000;  
			rom[7] = 16'b0000000000000000;  
			rom[8] = 16'b0000000000000000;  
			rom[9] = 16'b0000000000000000;  
			rom[10] = 16'b0000000000000000;  
			rom[11] = 16'b0000000000000000;  
			rom[12] = 16'b0000000000000000;  
			rom[13] = 16'b0000000000000000;  
			rom[14] = 16'b0000000000000000;  
			rom[15] = 16'b0000000000000000;  
	end  
	assign instruction = (pc[15:0] < 32 )? rom[rom_addr[3:0]]: 16'd0;  
endmodule