module board_wrapper
(
    input         ADC_CLK_10,
    input         MAX10_CLK1_50,
    input         MAX10_CLK2_50,

    input  [ 1:0] KEY,
    input  [ 9:0] SW,

    output [ 9:0] LEDR,

    output [ 7:0] HEX0,
    output [ 7:0] HEX1,
    output [ 7:0] HEX2,
    output [ 7:0] HEX3,
    output [ 7:0] HEX4,
    output [ 7:0] HEX5,

    inout  [35:0] GPIO
);

    wire clk   = MAX10_CLK1_50;
    wire rst_n = ~ SW [9];

    wire hc_sr04_vcc = 1;
    wire hc_sr04_trig;
    wire hc_sr04_echo;
    wire hc_sr04_gnd = 0;

    assign GPIO [29]    = hc_sr04_vcc;
    assign GPIO [31]    = hc_sr04_trig;
    assign hc_sr04_echo = GPIO [33];
    assign GPIO [35]    = hc_sr04_gnd;

    wire [7:0] relative_distance;

    hc_sr04_receiver i_hc_sr04_receiver
    (
        .clk                ( clk               ),
        .rst_n              ( rst_n             ),
        .trig               ( hc_sr04_trig      ),
        .echo               ( hc_sr04_echo      ),
        .relative_distance  ( relative_distance )
    );

    display_driver i_digit_1 (relative_distance [ 7: 4], HEX1);
    display_driver i_digit_0 (relative_distance [ 3: 0], HEX0);

    assign LEDR = ~ 0 << relative_distance;

endmodule
