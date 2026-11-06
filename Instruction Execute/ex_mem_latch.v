`timescale 1ns / 1ps

/*

ForwardB = 10

*/

module ex_mem_latch(
    input clk,
    input rst,    
    input [1:0] wb_in,  //write back in
    input [2:0] m_in,   //memory data in
    
    output reg [1:0]  wb_out,
    output reg [2:0]  m_out,
    output reg [31:0] add_result,
    output reg [31:0] alu_result,
    output reg [31:0] readdata2,
    output reg [4:0]  mux_5b_out
     
);

    initial begin
        wb_out      = 0;
        m_out       = 0;
        add_result  = 0;
        alu_result  = 0;
        readdata2   = 0;
        mux_5b_out  = 0;
    end   
    
    always @(posedge clk) begin
        if (rst) begin
            wb_out      <= 0;
            m_out       <= 0;
            add_result  <= 0;
            alu_result  <= 0;
            readdata2   <= 0;
            mux_5b_out  <= 0;
        end
        
        else begin
            wb_out <= wb_in;
            m_out <= m_in;
        end
    end

endmodule
