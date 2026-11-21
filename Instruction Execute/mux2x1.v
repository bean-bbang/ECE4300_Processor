`timescale 1ns / 1ps

module mux2x1 #(
    parameter WIDTH = 32
)(
    input  [WIDTH-1:0] a,
    input  [WIDTH-1:0] b,
    input sel,
    output reg [WIDTH-1:0] mux_out
);
    
    always @ (*) begin
    
        if(sel == 0)
        mux_out <= a;
        
        else
        mux_out <= b;
    
    end
    
endmodule
