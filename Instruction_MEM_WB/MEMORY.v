module MEMORY (
    input clk,
    input [1:0] wb_ctlout,
    input branch, memread, memwrite, zero,
    input [31:0] alu_result, rdata2out,
    input [4:0] five_bit_muxout,
    output MEM_PCSrc,
    output MEM_WB_regwrite, MEM_WB_memtoreg,
    output [31:0] read_data, mem_alu_result,
    output [4:0] mem_write_reg
);
    wire [31:0] read_data_in;

    AND AND_4 (.membranch(branch), .zero(zero), .PCSrc(MEM_PCSrc));

    data_memory data_memory4 (
        .clk(clk), .addr(alu_result), .write_data(rdata2out),
        .memwrite(memwrite), .memread(memread), .read_data(read_data_in)
    );

    mem_wb mem_wb4 (
        .clk(clk), .control_wb_in(wb_ctlout),
        .read_data_in(read_data_in), .alu_result_in(alu_result),
        .write_reg_in(five_bit_muxout),
        .regwrite(MEM_WB_regwrite), .memtoreg(MEM_WB_memtoreg),
        .read_data(read_data), .mem_alu_result(mem_alu_result),
        .mem_write_reg(mem_write_reg)
    );
endmodule