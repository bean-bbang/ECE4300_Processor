`timescale 1ns/1ps
module tb_fetch();
    reg clk;
    reg rst_n;
    reg [31:0] EX_MEM_PCSrc;
    reg [31:0] EX_MEM_NPC;
    wire [31:0] IF_ID_instr;
    wire [31:0] IF_ID_npc;
    integer i;      //Declared for the loop in second block
top_ifetch DUT(

        .clk(clk),
        .rst_n(rst_n),
        .IF_ID_instr(IF_ID_instr),
        .IF_ID_npc(IF_ID_npc),
        .EX_MEM_PCSrc(EX_MEM_PCSrc),
        .EX_MEM_NPC(EX_MEM_NPC)
);

//Clock 
initial begin
    clk = 0;
    forever #1 
    clk = ~clk;
end

/*First Initial Begin Block - Tests all 10 words in instruction memory

To demo: uncomment the lines below this until the next initial begin
*/
initial begin

  rst_n = 0;    //reset ACTIVE HIGH
   EX_MEM_PCSrc = 0;
   EX_MEM_NPC = 32'h0;

   #10;
   rst_n = 1;
   #30
  $finish;
end

////uncomment until here to test First Block 

///* Second Initial Begin Block - Branch Testing*/
//initial begin

//    rst_n = 0;    //reset ACTIVE HIGH
//    EX_MEM_PCSrc = 0;
//    EX_MEM_NPC = 32'h0;
    
//    #10;
//    rst_n = 1;
    
//    for (i = 0; i < 10; i = i+1) begin
//       @(negedge clk);
       
//       if (i == 3) begin            //Can test at any other case to see a branch jump instead of increments of 1 in the PC
//            EX_MEM_PCSrc = 1'b1;
//            EX_MEM_NPC = 32'h7;
//       end
       
//       else begin
//            EX_MEM_PCSrc = 1'b0;
//       end
       
//      end
//    $finish;
//  end
  
endmodule
