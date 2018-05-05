module combinational_cloud
(
    input            a,
    input      [1:0] state,
    output reg [1:0] next_state
);
    always @*
        case (state)
        0:
            if (a)
                next_state = 0;
            else
                next_state = 1;
        1:
            if (a)
                next_state = 2;
            else
                next_state = 1;
        2:
            if (a)
                next_state = 0;
            else
                next_state = 1;
        3:
            next_state = 0;
        endcase
endmodule

module state_register
(
    input            clock,
    input            reset,
    input      [1:0] next_state,
    output reg [1:0] state
);
    always @ (posedge clock)
        if (reset)
            state <= 0;
        else
            state <= next_state;
endmodule

module finite_state_machine_1
(
    input  clock,
    input  reset,
    input  a,
    output y
);
    wire [1:0] state, next_state;

    combinational_cloud i_cc
    (
        .a          ( a          ),
        .state      ( state      ),
        .next_state ( next_state )
    );

    state_register i_sr
    (
        .clock      ( clock      ),
        .reset      ( reset      ),
        .state      ( state      ),
        .next_state ( next_state )
    );

    assign y = (state == 2);

endmodule

module finite_state_machine
(
    input  clock,
    input  reset,
    input  a,
    output y
);
    reg [1:0] state, next_state;

    always @ (posedge clock)
        if (reset)
            state <= 0;
        else
            state <= next_state;

    always @ (a, state)
        case (state)
        0:
            if (a)
                next_state = 0;
            else
                next_state = 1;
        1:
            if (a)
                next_state = 2;
            else
                next_state = 1;
        2:
            if (a)
                next_state = 0;
            else
                next_state = 1;
        3:
            next_state = 0;

        endcase

    assign y = (state == 2);

endmodule
