`timescale 1ns / 1ps

module ALU_ctrl(
    input clk,
    input rst,
    input [31:0] sign_extend,
    input sel,
    output reg CtrlALU_out
);


    always @(posedge clk) begin
        if (!rst) begin
            CtrlALU_out <= 6'b0;
        end
        else
            CtrlALU_out <= sign_extend[5:0];     //register contains sign extend first 6 bits
            
    end
    
endmodule