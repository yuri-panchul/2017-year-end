module strobe_gen
# (
    parameter w = 24
)
(
    input  clk,
    input  rst_n,
    output strobe
);

    wire [w - 1:0] count; 

    counter # (w) i_counter (clk, rst_n, en, count);
    assign strobe = (count == { w { 1'b0 } } );

endmodule
