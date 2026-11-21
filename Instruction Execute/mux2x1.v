`timescale 1ns / 1ps

module mux2x1 #(
    parameter WIDTH = 32
)(
    input  [WIDTH-1:0] a,
    input  [WIDTH-1:0] b,
    input sel,
    output reg [WIDTH-1:0] mux_out
);
    
assign mux_out = sel ? b : a;
    
endmodule
