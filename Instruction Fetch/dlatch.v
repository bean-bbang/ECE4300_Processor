`timescale 1ns / 1ps
module d_latch #(parameter WIDTH = 32)(
    input  wire D,
    input  wire CLK,
    output reg [WIDTH-1:0] Q
);
initial Q = {WIDTH{1'b0}};

    always @(*) begin
        if (CLK) Q = D;
    end
endmodule
