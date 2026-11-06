`timescale 1ns / 1ps

module ALU(
    input  [31:0] a, b,
    input sel,
    output reg mux_out
);

    always @ (*) begin
    
        if(sel == 0)
        mux_out <= a;
        
        else
        mux_out <= b;
    
    end
    

endmodule