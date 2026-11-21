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

integer i; //to reset values
    initial begin
        for (i = 0; i < 10; i = i + 1) //resets all reg values to 0
        REG[i] = 32'b0;
        
    end
    
always @(posedge clk) begin
    if (rst) begin
        for (i = 0; i < 32; i = i + 1) REG[i] <= 32'b0;
    end
    
    else begin
        if (regwrite) begin
            //Overwrite the value location rd within REG with writedata
            REG[rd] <= writedata;
        end
        else begin
            A_readdat1 <= REG[rs];
            B_readdat2 <= REG[rt];
        end
    end
end
endmodule