`timescale 1ns / 1ps

module adder_32b(
    input  [31:0] NPC,
    input  [31:0] sign_extend,
    output [31:0] adder_out

);

    assign adder_out = NPC + sign_extend;
        
        
endmodule
