`timescale 1ns / 1ps

module tb_instrn_execute;

    reg clk = 0, rst = 1;
    
    
execute DUT(
    .clk(clk),
    .rst(rst),
    .NPC(NPC),           
    .readdata1(readdata1),     
    .readdata2(readdata2),      
    .sign_extend(sign_extend),   
    .instr_2016(instr_2016),     
    .instr_1511(instr_1511),     
    .npc_out(adder_out),
    .alu_result(alu_result),
    .readdata2_ex_mem(readdata2_ex_mem),
    .mux_5b_out(mux_5b_out)
    
);

    initial begin
        clk = 0;
        forever #5
        clk = ~clk;
    end
    
    initial begin
        rst = 1;
    
    #4
    
        rst = 0;
        
    
    $finish;
  end
   
endmodule
