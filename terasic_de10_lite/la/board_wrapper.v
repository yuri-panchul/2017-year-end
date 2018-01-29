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

    reg [29:0] counter;

    always @(posedge clk or negedge rst_n)
    begin
        if (!rst_n)
            counter <= 30'b0;
        else
            counter <= counter + 30'b1;
    end

    assign GPIO [35:0] = { clk, rst_n, 4'b0, counter };

    display_driver i_digit_5 (counter [29:26], HEX5);
    display_driver i_digit_4 (counter [25:22], HEX4);
    display_driver i_digit_3 (counter [21:18], HEX3);
    display_driver i_digit_2 (counter [17:14], HEX2);
    display_driver i_digit_1 (counter [13:10], HEX1);
    display_driver i_digit_0 (counter [ 9: 6], HEX0);

    assign LEDR [9:0] = counter [29:20];

endmodule
