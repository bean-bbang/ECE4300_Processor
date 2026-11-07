`timescale 1ns/1ps

/*

The execute stage has two functions: Read instruction and capture result

*/

module top_instrn_execute(
    input clk,
    input rst,
    input [31:0]  NPC,           //holds next instruction addr
    input [31:0]  readdata1,     //contains base address from register (rs), used by ALU to calculate effective mem addr
    input [31:0]  readdata2,     //contains data from register (rt), to be written out to data mem
    input [31:0]  sign_extend,   //from 16'b -> 32'b
    input [20:16] instr_2016,    //Register Target for I-type instructions (lw, addi)
    input [15:11] instr_1511,    //Register Destination for R-type instrns (add, sub, and)
    input         RegDst,
    input [1:0] wb_in,
    input [2:0] m_in,
    input [1:0] ALU_Op,
    input ALU_Src,

    output [1:0] wb_out,
    output [2:0] m_out,
    output [31:0] npc_out,
    output [31:0] alu_result,
    output zero,
    output [31:0] readdata2_ex_mem,
    output [4:0]  mux_5b_out
);


wire [4:0] mux5_out;
wire [2:0] ctrlALU_out;
wire [31:0] mux_to_alu;
wire alu_zero;
wire [31:0] adder_out;
wire [31:0] alu_out;


    adder_32b addr(
        .NPC(NPC),
        .sign_extend(sign_extend),
        .adder_out(adder_out)   //add_result
    );

    mux2x1 #(.WIDTH(32)) mux(
        .a(readdata2),
        .b(sign_extend),
        .sel(ALU_Src),         
        .mux_out(mux_to_alu)
    );    
    
    ALU_ctrl alu_ctrl(
        .funct(sign_extend[5:0]),
        .ALUOp(ALU_Op),
        .ALU_ctrl(ctrlALU_out)
);

    ALU ALU(
        .a(readdata1),
        .b(mux_to_alu),
        .sel(ctrlALU_out),        //from ALU_ctrl's 3bit output signal
        .mux_out(alu_out),
        .zero(alu_zero)
   );
    
    mux2x1 #(.WIDTH(5)) instr_X_mux(
        .a(instr_2016),
        .b(instr_1511),
        .sel(RegDst),
        .mux_out(mux5_out)
    );

    ex_mem_latch latch(
        .clk(clk),
        .rst(rst),
        .wb_in(wb_in),
        .m_in(m_in),
        .add_result_in(adder_out),
        .alu_result_in(alu_out),
        .readdata2_in(readdata2),
        .mux_5b_in(mux5_out),
        .zero_in(alu_zero),
        .zero(zero),
        .wb_out(wb_out),
        .m_out(m_out),
        .add_result(npc_out),
        .alu_result(alu_result),
        .readdata2(readdata2_ex_mem),
        .mux_5b_out(mux_5b_out)
    );
endmodule
