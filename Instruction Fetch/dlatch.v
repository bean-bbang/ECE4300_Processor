`timescale 1ns / 1ps
module d_latch (
    input  wire D,
    input  wire CLK,
    output reg  Q
);
    always @(*) begin
        if (CLK) Q = D;
    end
endmodule
