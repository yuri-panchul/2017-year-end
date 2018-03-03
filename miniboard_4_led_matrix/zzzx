module timer
# ( parameter timer_divider = 24 )
(
    input  clock_50_mhz,
    input  reset_n,
    output strobe
);

    reg [timer_divider - 1:0] counter;

    always @ (posedge clock_50_mhz or negedge reset_n)
    begin
        if (! reset_n)
            counter <= { timer_divider { 1'b0 } };
        else
            counter <= counter + { { timer_divider - 1 { 1'b0 } }, 1'b1 };
    end

    assign strobe
        = (counter [timer_divider - 1:0] == { timer_divider { 1'b0 } } );

endmodule

//----------------------------------------------------------------------------

module shift
# ( parameter width = 10 )
(
    input                     clock,
    input                     reset_n,
    input                     shift_enable,
    input                     button,
    output reg [width - 1:0]  shift_reg
);

    reg [width - 1:0] counter;

    always @ (posedge clock or negedge reset_n)
    begin
        if (! reset_n)
            shift_reg <= { width { 1'b0 } };
        else if (shift_enable)
            shift_reg <= { button, shift_reg [width - 1:1] };
    end

endmodule

//----------------------------------------------------------------------------

module top
(
    input        clock,
    input        reset_n,
    input        key,
    inout [15:0] j1
);

    wire [ 7:0] rows, cols;

    assign j1 =
    {
        ~ rows [0], ~ rows [1],   cols [1], ~ rows [7],
          cols [3], ~ rows [2],   cols [0], ~ rows [4],
          cols [4],   cols [6], ~ rows [6], ~ rows [5],
          cols [7], ~ rows [3],   cols [5],   cols [2]
    };

    //------------------------------------------------------------------------

    wire button = ~ key [0];
    wire enable_rows, enable_cols;

    timer
    # ( .timer_divider ( 24 ))
    timer_rows_i
    (
        .clock_50_mhz ( clock       ),
        .reset_n      ( reset_n     ),
        .strobe       ( enable_rows )
    );

    shift 
    # ( .width ( 8 ))
    shift_rows_i
    (
        .clock        ( clock       ),
        .reset_n      ( reset_n     ),
        .shift_enable ( enable_rows ),
        .button       ( button      ),
        .shift_reg    ( rows        )
    );

    //------------------------------------------------------------------------

    timer
    # ( .timer_divider ( 24 ))
    timer_cols_i
    (
        .clock_50_mhz ( clock       ),
        .reset_n      ( reset_n     ),
        .strobe       ( enable_cols )
    );

    shift 
    # ( .width ( 8 ))
    shift_cols_i
    (
        .clock        ( clock       ),
        .reset_n      ( reset_n     ),
        .shift_enable ( enable_cols ),
        .button       ( button      ),
        .shift_reg    ( cols        )
    );

endmodule
