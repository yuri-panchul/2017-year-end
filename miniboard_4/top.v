module top
(
    input        clk,
    input  [1:0] key,
    output [7:0] led
);

    wire rst_n = key [0];
    wire en    = key [1];

    reg [31:0] cnt;
    
    always @ (posedge clk or negedge rst_n)
        if (! rst_n)
            cnt <= 0;
        else if (en)
            cnt <= cnt + 1;

    assign led = cnt [29:22];

endmodule
