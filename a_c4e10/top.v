module top
(
    input         clk,
    input  [ 3:0] key,
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
    assign led      = { sw, key };
    assign abcdefgh = sw;
    assign digit    = sw;
    assign buzzer   = key [0];

endmodule
