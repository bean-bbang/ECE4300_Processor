`timescale 1ns / 1ps
    
module tb_instrn_execute;
    
    reg clk = 0;
    reg rst = 1;
    reg [31:0] NPC;
    reg [31:0] readdata1;
    reg [31:0] readdata2;
    reg [31:0] sign_extend;
    
    reg [20:16] instr_2016;
    reg [15:11] instr_1511;
    
    reg RegDst;
    reg [1:0] wb_in;
    reg [2:0] m_in;
    reg [1:0] ALU_Op;
    reg ALU_Src;
    
    wire [1:0] wb_out;
    wire [2:0] m_out;
    wire [31:0] npc_out;
    wire [31:0] alu_result;
    wire zero;
    wire [31:0] readdata2_ex_mem;
    wire [4:0] mux_5b_out;

top_instrn_execute DUT (

        .clk(clk),
        .rst(rst),

        .NPC(NPC),
        .readdata1(readdata1),
        .readdata2(readdata2),
        .sign_extend(sign_extend),

        .instr_2016(instr_2016),
        .instr_1511(instr_1511),

        .RegDst(RegDst),
        .wb_in(wb_in),
        .m_in(m_in),
        .ALU_Op(ALU_Op),
        .ALU_Src(ALU_Src),

        .wb_out(wb_out),
        .m_out(m_out),
        .npc_out(npc_out),
        .alu_result(alu_result),
        .zero(zero),
        .readdata2_ex_mem(readdata2_ex_mem),
        .mux_5b_out(mux_5b_out)

    );

    initial begin
        clk = 0;
        forever #1
        clk = ~clk;
    end
    
    initial begin
    
    rst = 1;
    
    NPC = 32'd100;
    readdata1 = 32'd10;
    readdata2 = 32'd5;
    sign_extend = 32'd5;
    
    instr_2016 = 5'd8;
    instr_1511 = 5'd10;

    RegDst = 0;
    wb_in = 2'b00;
    m_in = 3'b000;
    ALU_Op = 2'b00;
    ALU_Src = 0;
    
    #15
    rst = 0;
    
    @(posedge clk);
    #1;
    
    $display("NPC output: %h", npc_out);
    $display("ALU result: %h", alu_result);
    $display("Zero flag: %b", zero);
    $display("Register data: %h", readdata2_ex_mem);
    $display("Destination register: %h", mux_5b_out);
    
    #15;
    
    $finish;
  end
   
endmodule
