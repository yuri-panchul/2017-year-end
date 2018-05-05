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

    finite_state_machine i_fsm
    (
        .clock (   clk     ),
        .reset ( ~ key [0] ),
        .a     (   key [1] ),
        .y     (   led [0] )
    );

endmodule
