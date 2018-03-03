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

    wire rst_n = ~ key [3];

    wire seven_segment_strobe;

    strobe_gen # (.w (20)) i_seven_segment_strobe
        (clk, rst_n, seven_segment_strobe);

    seven_segment #(.w ( 32)) i_seven_segment
    (
        .clk     ( clk                  ),
        .rst_n   ( rst_n                ),
        .en      ( seven_segment_strobe ),
        .num     ( { sw, sw, sw, sw }   ),
        .dots    ( sw                   ),
        .abcdefg ( abcdefgh [7:1]       ),
        .dot     ( abcdefgh [0]         ),
        .anodes  ( digit                )
    );

    assign led      = { sw, key };
    assign buzzer   = key [0];

endmodule
