`timescale 1ns / 1ps
module d_latch #(parameter WIDTH = 32, parameter RESET_VAL=0)(
    input  wire [WIDTH-1:0] D,
    input  wire CLK,
    input wire rst,
    output reg [WIDTH-1:0] Q
);
initial Q = RESET_VAL;
    always @(posedge CLK) 
        if (rst) 
            Q <= RESET_VAL;
        else 
    Q <= D;
endmodule
