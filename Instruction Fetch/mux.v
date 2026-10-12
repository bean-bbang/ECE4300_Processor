//2x1 mux
`timescale 1ns / 1ps
module mux(
    input [31:0] a, b,
    input sel,
    output mux_out

);

wire nsel, a1, b1;

not (nsel, sel);
and (a1, a, nsel);
and (b1, b, sel);
or (y, a1, b1);

endmodule

