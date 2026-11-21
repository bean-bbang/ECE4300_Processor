`timescale 1ns/1ps

module top_pipelineFull(
    input wire clk,
    input wire rst,
    output wire [4:0]  wb_write_reg_addr,
    output wire [31:0] wb_write_data,
    output wire wb_reg_write_out

);

// IF -> ID wires
wire [31:0] if_id_instr_w;
wire [31:0] if_id_npc_w;

// ID -> EX wires
wire [1:0] id_ex_wb_w;
wire [2:0] id_ex_mem_w;
wire [3:0]  id_ex_execute_w;
wire [31:0] id_ex_npc_w;
wire [31:0] id_ex_readdat1_w;
wire [31:0] id_ex_readdat2_w;
wire [31:0]  id_ex_sign_ext_w;
wire [4:0] id_ex_instr_bits_20_16_w;
wire [4:0] id_ex_instr_bits_15_11_w;

wire [4:0]  wb_write_reg_location_w;

// EX -> MEM wires
wire [1:0] ex_mem_wb_w;
wire [2:0] ex_mem_m_w;
wire [31:0] ex_mem_npc_w;
wire [31:0] ex_mem_alu_result_w;
wire        ex_mem_zero_w;
wire [31:0] ex_mem_readdata2_w;
wire [4:0] ex_mem_mux_5b_w;
wire       ex_mem_pcsrc_w;

// MEM -> WB wires
wire        mem_wb_reg_write_w;
wire        mem_wb_mem_to_reg_w;
wire [31:0] mem_wb_read_data_w;
wire [31:0] mem_wb_alu_result_w;
wire [4:0]  mem_wb_write_reg_location_w;
//wire [31:0] wb_final_data_w;

// WB -> ID feedback
wire [31:0] mem_wb_write_data_w;

wire [4:0]  mux_5b_out_w;
wire [31:0] alu_result_w, readdata2_ex_mem_w;
wire zero_w;


top_ifetch u_ifetch(
    .clk(clk),
    .rst(rst),
    .EX_MEM_PCSrc(ex_mem_pcsrc_w),
    .EX_MEM_NPC(ex_mem_npc_w),  //Execute Memory Next PC
    .IF_ID_instr(if_id_instr_w), 
    .IF_ID_npc(if_id_npc_w)
);

decode u_decode(
    .clk(clk),
    .rst(rst),
    .wb_reg_write(mem_wb_reg_write_w),
    .wb_write_reg_location(mem_wb_write_reg_location_w),
    .mem_wb_write_data(mem_wb_write_data),
    .if_id_instr(if_id_instr_w),
    .if_id_npc(if_id_npc_w),
    .id_ex_wb(id_ex_wb_w),
    .id_ex_mem(id_ex_mem_w),
    .id_ex_execute(id_ex_execute_w),
    .id_ex_npc(id_ex_npc_w),
    .id_ex_readdat1(id_ex_readdat1_w),
    .id_ex_readdat2(id_ex_readdat2_w),
    .id_ex_sign_ext(id_ex_sign_ext_w),
    .id_ex_instr_bits_20_16(id_ex_instr_bits_20_16_w),
    .id_ex_instr_bits_15_11(id_ex_instr_bits_15_11_w)
);

//[31:26] broken into [1:0] [2:3]

top_instrn_execute EXECUTE(
    .clk(clk),
    .rst(rst),
     .NPC(id_ex_npc_w),           
    .readdata1(id_ex_readdata1_w),
    .readdata2(id_ex_readdata2_w),
    .sign_extend(id_ex_sign_ext_w),
    .instr_2016(id_ex_instr_bits_20_16_w),   
    .instr_1511(id_ex_instr_bits_15_11_w),   
    .RegDst(id_ex_execute_w[0]),
    .ALU_Src(id_ex_execute_w[1]),
    .ALU_Op(id_ex_execute_w[3:2]),
    .wb_in(id_ex_wb_w),
    .m_in(id_ex_mem_w),
    .wb_out(ex_mem_wb_w),
    .m_out(ex_mem_m_w),
    .npc_out(ex_mem_npc_w),
    .alu_result(ex_mem_alu_result_w),
    .zero(ex_mem_zero_w),
    .readdata2_ex_mem(ex_mem_readdata2_w),
    .mux_5b_out(ex_mem_mux_5b_w)

);

MEMORY u_memory(
    .clk(clk),
    .wb_ctlout(ex_mem_wb_w),
    .branch(ex_mem_m_w[2]), 
    .memread(ex_mem_m_w[1]),
    .memwrite(ex_mem_m_w[0]),
    .zero(ex_mem_zero_w),
    .alu_result(ex_mem_alu_result_w),
    .rdata2out(ex_mem_readdata2_w),
    .five_bit_muxout(ex_mem_mux_5b_w),
    .MEM_PCSrc(ex_mem_pcsrc_w), //from AND gate
    .MEM_WB_regwrite(mem_wb_reg_write_w), 
    .MEM_WB_memtoreg(mem_wb_mem_to_reg_w),
    .read_data(mem_wb_read_data_w),
    .mem_alu_result(mem_wb_alu_result_w),
    .mem_write_reg(mem_wb_write_reg_location_w)

);

mux2x1 #(.WIDTH(32)) WB_MUX (
        .a       (wb_alu_result),
        .b       (wb_read_data),
        .sel     (wb_memtoreg),
        .mux_out (wb_write_data)
    );

assign mem_wb_write_data_w = mem_wb_mem_to_reg_w ? mem_wb_read_data_w : mem_wb_alu_result_w;

    assign wb_reg_write_out = mem_wb_reg_write_w;
    assign wb_write_reg_addr = mem_wb_write_reg_location_w;
    assign wb_write_data_out = mem_wb_write_data_w;

endmodule