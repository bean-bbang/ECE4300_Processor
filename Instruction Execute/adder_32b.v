`timescale 1ns / 1ps

module adder_32b(
    input clk,
    input rst,
    input  [31:0] NPC,
    input  [31:0] sign_extend,
    output reg [31:0] adder_out

);

    always @ (posedge clk or negedge rst) begin
        if(!rst) begin
            adder_out <= 31'b0;
        end
        
        else begin
            adder_out <= NPC + sign_extend;
        end
        
    end
        
endmodule
