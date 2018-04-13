module adder_1
(
    input  a,
    input  b,
    input  carry_in,
    output sum,
    output carry_out
);

    wire p = a ^ b;
    wire q = a & b;

    assign sum       = p ^ carry_in;
    assign carry_out = q | (p & carry_in);

endmodule

module adder_4_ripple_carry
(
    input  [3:0] a,
    input  [3:0] b,
    output [3:0] sum
);

    wire [2:0] carry;

    adder_1 inst_0 (a [0], b [0], 1'b0,      sum [0], carry [0]);
    adder_1 inst_1 (a [1], b [1], carry [0], sum [1], carry [1]);
    adder_1 inst_2 (a [2], b [2], carry [1], sum [2], carry [2]);
    adder_1 inst_3 (a [3], b [3], carry [2], sum [3],          );

endmodule

module adder_4_plus
(
    input  [3:0] a,
    input  [3:0] b,
    output [3:0] sum
);

    assign sum = a + b;

endmodule

module top
(
    input  [3:0] key,
    output [9:0] led
);

    adder_4_ripple_carry inst_0 (key, key, led [3:0]);
    adder_4_plus         inst_1 (key, key, led [7:4]);
    
    assign led [9] = 1'b0;

endmodule
