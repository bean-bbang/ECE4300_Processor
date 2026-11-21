`timescale 1ns/1ps

module reg_file(
    input wire clk,
               rst,
               regwrite,
    input wire [4:0] rs,
                     rt,
                     rd,
    input wire [31:0] writedata,
    
    output wire [31:0] A_readdat1,
                      B_readdat2

);

reg [31:0] REG [0:31];
assign A_readdat1 = REG[rs];
assign B_readdat2 = REG[rt];
integer i; //to reset values
    initial begin
        for (i = 0; i < 10; i = i + 1) //resets all reg values to 0
        REG[i] = 32'b0;
        
    end
    
always @(posedge clk) begin
    if (rst)
        for (i = 0; i < 32; i = i + 1) REG[i] <= 32'b0;
            else if (regwrite && rd != 0) REG[rd] <= writedata;
end
endmodule