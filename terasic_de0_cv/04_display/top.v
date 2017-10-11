//----------------------------------------------------------------------------
//
//  Exercise   4. Combinational design
//
//  Упражнение 4. Combinational design
//
//----------------------------------------------------------------------------

//----------------------------------------------------------------------------
//
//  Exercise 4.1. Display either 'Astana' or 'Almaty' depending on buttons 0 and 1.
//
//  Упражнение 4.1. Выводим 'Astana' or 'Almaty' в зависимости от кнопок 0 или 1. 
//
//----------------------------------------------------------------------------

module top
(
    input  [0:0] key,  // Buttons // Кнопки
    output [6:0] hex0, // Seven-segment display // индикатор
    output [6:0] hex1,
    output [6:0] hex2,
    output [6:0] hex3,
    output [6:0] hex4,
    output [6:0] hex5
);


    parameter [6:0] A = 7'b0001000,
                    L = 7'b1000111,
                    M = 7'b1101010,
                    N = 7'b0101011,
                    S = 7'b0010010,
                    T = 7'b0000111,
                    Y = 7'b0010001;

    wire sel = key [0];

    assign hex5 =       A;
    assign hex4 = sel ? L : S;
    assign hex3 = sel ? M : T;
    assign hex2 =       A;
    assign hex1 = sel ? T : N;
    assign hex0 = sel ? Y : A;

    // Alternative way
    
    // assign { hex5, hex4, hex3, hex2, hex1, hex0 } =
    //    sel ? { A, L, M, A, T, Y } : { A, S, T, A, N, A };

endmodule
