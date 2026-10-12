`timescale 1ns / 1ps

module program_counter(
    input clk,
    input rst_n,
    input [31:0] mux,
    output reg [31:0] pc_out

);


always @ (posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        pc_out <= 32'b0;
    end
    else begin
        pc_out <= mux;
        
    end
end
endmodule
