`timescale 1ns / 1ps
module decode(
    input wire          clk,
                        rst,
                        wb_reg_write,
    input wire [4:0]    wb_write_reg_location,
    input wire [31:0]   mem_wb_write_data,
                        if_id_instr,
                        if_id_npc,
    output wire [1:0]   id_ex_wb,
    output wire [2:0]   id_ex_mem,
    output wire [3:0]   id_ex_execute,
    output wire [31:0]  id_ex_npc,
                        id_ex_readdat1,
                        id_ex_readdat2,
                        id_ex_sign_ext,
    output wire [4:0]   id_ex_instr_bits_20_16,
                        id_ex_instr_bits_15_11
);
    wire [31:0] sign_ext_internal, readdat1_internal, readdat2_internal;
    wire [1:0] wb_internal;
    wire [2:0] mem_internal;
    wire [3:0] ex_internal;
 
    sign_extend sE0(
        .immediate(if_id_instr[15:0]),
        .extended(sign_ext_internal));
        
    reg_file rf0(
        .clk(clk), .rst(rst), .regwrite(wb_reg_write),
        .rs(if_id_instr[25:21]), .rt(if_id_instr[20:16]),
        .rd(wb_write_reg_location), .writedata(mem_wb_write_data),
        .A_readdat1(readdat1_internal), .B_readdat2(readdat2_internal));
        
    ALU_ctrl c0(
        .clk(clk), .rst(rst), .opcode(if_id_instr[31:26]),
        .wb(wb_internal), .mem(mem_internal), .ex(ex_internal));
        
    idex_latch iEL0(
        .clk(clk), .rst(rst),
        .wb_in(wb_internal), .m_in(mem_internal), .ex_in(ex_internal),
        .npc_in(if_id_npc), .read1_in(readdat1_internal), .read2_in(readdat2_internal),
        .signext_in(sign_ext_internal),
        .instr20_16_in(if_id_instr[20:16]), .instr15_11_in(if_id_instr[15:11]),
        .wb_out(id_ex_wb), .m_out(id_ex_mem), .ex_out(id_ex_execute),
        .npc_out(id_ex_npc), .read1_out(id_ex_readdat1), .read2_out(id_ex_readdat2),
        .signext_out(id_ex_sign_ext),
        .instr20_16_out(id_ex_instr_bits_20_16), .instr15_11_out(id_ex_instr_bits_15_11));
        
endmodule