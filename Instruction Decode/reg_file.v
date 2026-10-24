`timescale 1ns/1ps

module reg_file(
    input wire clk,
               rst,
               regwrite,
    input wire [4:0] rs,
                     rt,
                     rd,
    input wire [31:0] writedata,
    
    output reg [31:0] A_readdat1,
                      B_readdat2

);

reg [31:0] REG [0:9];

    initial begin
        REG[0] = 'h002300AA;
        REG[1] = 'h10654321;
        REG[2] = 'h00100022;
        REG[3] = 'h8C123456;
        REG[4] = 'h8F123456;
        REG[5] = 'hAD654321;
        REG[6] = 'hABCDEF12;    //unique hex value to test change in code
        REG[7] = 'h13012345;
        REG[8] = 'hAC654321;
        REG[9] = 'h12012345;
        
    end
    
always @(posedge clk) begin
    if (rst) begin
        A_readdat1 = {32{1'b0}};
        B_readdat2 = {32{1'b0}};
    end
    
    else begin
        if (regwrite) begin
            //Overwrite the value location rd within REG with writedata
            REG[rd] = writedata;
        end
        else begin
            REG[rs] = A_readdat1;
            REG[rt] = B_readdat2;
        end
endmodule
