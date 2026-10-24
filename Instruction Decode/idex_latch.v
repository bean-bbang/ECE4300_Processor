`timescale 1ns / 1ps

module idex_latch(

input clk, rst,
input [1:0] wb_in,
input [2:0] m_in,
input [3:0] ex_in,
input [31:0] npc_in, read1_in, read2_in, signext_in,
input [4:0] instr20_16_in, instr15_11_in,
output reg [1:0] wb_out,
output reg [2:0] m_out,
output reg [3:0] ex_out,
output reg [31:0] npc_out, read1_out, read2_out, signext_out,
output reg [4:0] instr20_16_out, instr15_11_out
);

    initial begin
        wb_out = 0;
        m_out = 0;
        ex_out = 0;
        npc_out = 0;
        read1_out = 0;
        
        read2_out = 0;
        signext_out = 0;
        instr20_16_out = 0;
        instr15_11_out = 0;
    end
    always @(posedge clk) begin
    
    if (rst) begin // resets out values
        wb_out <= 0;
        m_out <= 0;
        ex_out <= 0;
        npc_out <= 0;
        read1_out <= 0;
        read2_out <= 0;
        signext_out <= 0;
        instr20_16_out <= 0;
        instr15_11_out <= 0;
    end
    else begin //loads in values
        wb_out <= wb_in;
        m_out <= m_in;
        ex_out <= ex_in;
        npc_out <= npc_in;
        read1_out <= read1_in;
        read2_out <= read2_in;
        signext_out <= signext_in;
        instr20_16_out <= instr20_16_in;
        instr15_11_out <= instr15_11_in;
    end
end  
endmodule
