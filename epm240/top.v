module top
(
    input  clk,
    output led
);

    reg [31:0] cnt;
    
    always @ (posedge clk)
        cnt <= cnt + 1;

    assign led = cnt [24];

endmodule
