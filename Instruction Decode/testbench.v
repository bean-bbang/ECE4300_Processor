`timescale 1ns / 1ps

module testbench;

    reg  clk = 0, rst = 1, wb_reg_write = 0;
    reg  [4:0]  wb_write_reg_location = 5'd0;
    reg  [31:0] mem_wb_write_data = 32'd0, if_id_instr = 32'd0, if_id_npc = 32'd0;

    wire [1:0]  id_ex_wb;
    wire [2:0]  id_ex_mem;
    wire [3:0]  id_ex_execute;
    wire [31:0] id_ex_npc, id_ex_readdat1, id_ex_readdat2, id_ex_sign_ext;
    wire [4:0]  id_ex_instr_bits_20_16, id_ex_instr_bits_15_11;

    reg [8*16-1:0] instr_name;
 
    decode dut(
        .clk(clk), .rst(rst), .wb_reg_write(wb_reg_write),
        .wb_write_reg_location(wb_write_reg_location),
        .mem_wb_write_data(mem_wb_write_data),
        .if_id_instr(if_id_instr), .if_id_npc(if_id_npc),
        .id_ex_wb(id_ex_wb), .id_ex_mem(id_ex_mem), .id_ex_execute(id_ex_execute),
        .id_ex_npc(id_ex_npc), .id_ex_readdat1(id_ex_readdat1),
        .id_ex_readdat2(id_ex_readdat2), .id_ex_sign_ext(id_ex_sign_ext),
        .id_ex_instr_bits_20_16(id_ex_instr_bits_20_16),
        .id_ex_instr_bits_15_11(id_ex_instr_bits_15_11)
    );
 
    always #1 clk = ~clk;
 
    initial begin
        $dumpfile("decode_timing.vcd");
        $dumpvars(0, testbench);

        rst = 1;
        wb_reg_write = 0;
        wb_write_reg_location = 5'd2; //$v0
        mem_wb_write_data = 32'h64;
        if_id_npc = 32'h0000001;

        instr_name = "ADD $v0,$a1";
        if_id_instr = 32'h00a41020;
        
        #4
        
        rst = 0;
        
        #6
        
        if_id_npc = 32'h0000002;
        instr_name = "BEQ $0,$0,8";
        if_id_instr = 32'h10000008;
        
        #6
 
        if_id_npc = 32'h0000003;
        instr_name = "LW $v0,2($a0)";
        if_id_instr = 32'h8c820002;
        
        #6
 
        if_id_npc = 32'h0000004;
        instr_name = "SW $v0,2($a0)";
        if_id_instr = 32'hac820002;
        
        #6

        instr_name = "WRITE $v0";
        wb_reg_write = 1;
        
        #2
        
        wb_reg_write = 0;
        
        #4
        
        if_id_npc = 32'h0000005;
        instr_name = "ADD $v1,$v0";
        if_id_instr = 32'h00441820;
        
        #6
        
        instr_name = "DONE";
        $finish;
    end
endmodule
