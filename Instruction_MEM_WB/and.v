`timescale 1ns/1ps
module AND_gate(
    input wire membranch, zero,
    output wire PCSrc
);

assign PCSrc = membranch & zero;
endmodule