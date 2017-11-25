module top
(
    input        clk,
    input        key,
    output [3:0] led
);

    wire rst_n = key [0];

    reg [31:0] cnt;
    
    always @ (posedge clk or negedge rst_n)
        if (! rst_n)
            cnt <= 0;
        else
            cnt <= cnt + 1;

    assign led = cnt [29:22];

endmodule
