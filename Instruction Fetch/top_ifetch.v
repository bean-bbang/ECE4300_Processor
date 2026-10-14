`timescale 1ns/1ps

module top_ifetch(
    input wire clk,
    input wire rst_n,
    input wire EX_MEM_PCSrc,
    input wire [31:0] EX_MEM_NPC,  //Execute Memory Next PC
    output wire [31:0] IF_ID_instr,
    output wire [31:0] IF_ID_npc
    
);

wire [31:0] pc_current;     //current Program Counter addr
wire [31:0] pc_plus1;       //pc_current+1
wire [31:0] pc_next;        //outputs either adder or PC from EXMem 
wire [31:0] instruction;    //word from instrn_mem

adder pc_adder(     //increments by 1
    .pc_in(pc_current),
    .pc_next(pc_plus1)
);

mux PC_MUX(
    .a(pc_plus1),
    .b(EX_MEM_NPC),
    .sel(EX_MEM_PCSrc),
    .mux_out(pc_next)
);

program_counter PC(
    .clk(clk),
    .rst_n(rst_n),
    .mux(pc_next),
    .pc_out(pc_current)

);

//Instruction fetch
instruction_memory I_MEM(
    .address(pc_current),
    .instruction(instruction)
);

d_latch INSTR_LATCH(
    .CLK(clk),
    .D(instruction),
    .Q(IF_ID_instr)
    
);

d_latch NPC_LATCH(
    .CLK(clk),
    .D(pc_plus1),
    .Q(IF_ID_npc)
    
);
endmodule