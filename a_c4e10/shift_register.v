`include "config.vh"

`ifdef  USE_STRUCTURAL_IMPLEMENTATION

module shift_register
# (
    parameter w = 1
) 
(
    input            clk,
    input            rst_n,
    input            en,
    input            in,
    output [w - 1:0] out
);

    wire [w - 1:0] q;
    wire [w - 1:0] d = { in, q [w - 1 : 1] };

    register i_reg (clk, rst_n, en, d, q);
    
    assign out = q;

endmodule

`else

module shift_register
# (
    parameter w = 1
) 
(
    input                clk,
    input                rst_n,
    input                en,
    input                in,
    output reg [w - 1:0] out
);

    always @ (posedge clk or negedge rst_n)
        if (! rst_n)
            out <= { w { 1'b0 } };
        else if (en)
            out <= { in, out [w - 1 : 1] };

endmodule

`endif
