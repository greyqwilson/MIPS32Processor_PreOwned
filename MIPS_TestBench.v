module MIPS_Test();
reg clk;
reg reset;

MIPS32_Processor processor (.clk (clk),
                            .reset (reset));

always #5 clk = ~clk;

initial begin
    $dumpfile("mips_processor.vcd");
    $dumpvars;

    clk = 1'b1;
    reset = 1'b0;
    #30
    reset = 1'b1;
    #70
    $finish;
end

endmodule