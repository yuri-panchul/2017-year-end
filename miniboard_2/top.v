module top
(
    input        clk,
    input        rst_n,
    output [2:0] led
);

    reg [31:0] cnt;
    
    always @ (posedge clk or negedge rst_n)
        if (! rst_n)
            cnt <= 0;
        else
            cnt <= cnt + 1;

    assign led = ~ cnt [27:24];

endmodule
