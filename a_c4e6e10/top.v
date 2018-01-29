module top
(
    input         clk,
    input         rst_n,
    input         extra_key,
    input  [ 1:0] key,
    input  [ 7:0] sw,
    output [11:0] led,
    output [ 7:0] abcdefgh,
    output [ 7:0] digit,
    output        buzzer
);
/*
    reg [31:0] cnt;
    
    always @ (posedge clk or negedge rst_n)
        if (! rst_n)
            cnt <= 0;
        else if (en)
            cnt <= cnt + 1;

    // assign led = cnt [29:22];
*/
    assign led      = { rst_n, extra_key, key, sw };
    assign abcdefgh = sw;
    output digit    = sw;
    output buzzer   = key [0];

endmodule
