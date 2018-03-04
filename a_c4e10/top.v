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

    wire rst_n = key [3];

    wire [3:0] key_db;
    wire [7:0] sw_db;

    sync_and_debounce # (.w (4)) i_sync_and_debounce_key
        (clk, ~ key, key_db);
    
    sync_and_debounce # (.w (8)) i_sync_and_debounce_sw
        (clk, ~ sw, sw_db);

    wire seven_segment_strobe;

    strobe_gen # (.w (10)) i_seven_segment_strobe
        (clk, rst_n, seven_segment_strobe);

    seven_segment #(.w (32)) i_seven_segment
    (
        .clk     ( clk                            ),
        .rst_n   ( rst_n                          ),
        .en      ( seven_segment_strobe           ),
        .num     ( { sw_db, sw_db, sw_db, sw_db } ),
        .dots    ( sw_db                          ),
        .abcdefg ( abcdefgh [7:1]                 ),
        .dot     ( abcdefgh [0]                   ),
        .anodes  ( digit                          )
    );

    wire shift_register_strobe;

    strobe_gen # (.w (23)) i_shift_register_strobe
        (clk, rst_n, shift_register_strobe);

    wire [11:0] out_reg;

    shift_register # (.w (12)) i_shift_reg
    (
        .clk     ( clk                   ),
        .rst_n   ( rst_n                 ),
        .en      ( shift_register_strobe ),
        .in      ( key_db [1]            ),
        .out_reg ( out_reg               )
    );

    assign led    = ~ out_reg;
    assign buzzer = ~ key_db [0];

endmodule
