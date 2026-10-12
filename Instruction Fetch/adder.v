`timescale 1ns/1ps

module adder(
    input [31:0] pc_in,
    output [31:0] pc_next
    
);

assign pc_next = pc_in + 32'd1;
endmodule