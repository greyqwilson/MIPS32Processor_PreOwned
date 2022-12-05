# MIPS32Processor_PreOwned
This is a MIPS32 processor based on the work of electrobinary.blogspot.com and the simple single cycle design introduced in Computer Organization and Design (Patterson &amp; Hennessy).


Greyson’s learning experience:

I began by drawing the processor symbolically just as in the book and then figuring out the major modules I would need to make. These were the registers, memory, the ALU, instruction memory, and the program counter. The ALU would need to be modified to accommodate load word and store word instructions.

I initially attempted to code the registers files as it seemed straightforward enough. Unfortunately, my implementation was a bit off of what other sources on the web had implemented. Using ElectroBinary as my guide, I had the correct variables, but didn’t implement register assignment in a proper way. Additionally, I forgot the clock, having only previously worked with combinational logic in Verilog.

After using the ElectroBinary code as a framework, the rest of the code was filled in to fit our specific design. Our design differed in that our Control Unit takes in the opcode, and ElectroBinary’s takes in additional inputs like wires or subsets of the instruction. 
The output for both is still the same, however. This is because we used two different designs from the same book by Patterson and Hennessy, Computer Organization and Design, where both differed only in control unit use. The wires were all labeled to as to be clearer for our own understanding, but generally fill the same purpose. 
There is one redundant wire connecting to nothing, ctrl_alu_op, which would normally be connected to the ALU control unit but is not due to the control unit being contained withing the ALU Top module. The only consequence of this is that the function field is determined in the ALU itself and not the control unit.

One difficult part in this was implementing custom instructions to the processor. Everything in this implementation causes instructions to be in the memory file one byte per line, and all the instructions be ordered in reverse order. This was a fairly superficial difficultly. Translating MIPS instructions into machine code was additionally difficult but was made way easier by using an online calculator. The calculator not only made the process quicker, but helped me verify my work, of which I had made a few errors initially. 
Checking whether the instructions I made worked or not proved much more difficult due to the 10s of waveforms to check to verify that each component was functioning as they should and giving me the correct input given the instruction. The data memory unit in particular was fixed this way.

As for becoming more familiar with Verilog, I would somewhat agree I’ve learned more than the last time I used Verilog. It certainly becomes much easier to code and add things when you understand the project or circuit. 


Resouces and Sites used:

Computer Organization and Design (David A. Patterson & John L. Hennessy)

Processor verilog implementation guide -- https://electrobinary.blogspot.com/2021/02/mips-processor-design-using-verilog-part1.html

MIPS Assembly code -> Machine code -- https://www.eg.bucknell.edu/~csci320/mips_web/



Ryley's Learning Experience:

Attempting to understand more about verilog, understanding the design of the control unit and then the rest of the documentation were what I went into firsthand. When talking with Greyson initially, sharing websites with documentation based around the MIPS32 processor and its implementation were extremely helpful.

For the project, the two of us had decided to somehow split the workload with our own searching and coming together to discuss the final output of the project. Using the 16 bit implementation, it functions very similarily to the 32 bit implementation besides the obvious difference of division. The documentation also provided some of the instruction set architecture for this side of the project with additional modules that would take over the final functions required for the project. 

An issue that did come from using this implementation was the time required to finish the vcd file required to generate the GTKWAVE. Having the internal clock on the program created an infite loop.

Implementation of the basic functions had to follow the path of control from OP Field Code to the Control module which we could then again use as the ALUOP Code, which would then go towards the ALU Control Module so that then the ALUOP Code and the INstruction Function Field would be used together to reach the ALU Control Module = ALU_Control Code.

Net sources for the implmentaion

https://www.fpga4student.com/2017/01/verilog-code-for-single-cycle-MIPS-processor.html

https://www.fpga4student.com/2017/01/basic-digital-blocks-in-verilog.html
