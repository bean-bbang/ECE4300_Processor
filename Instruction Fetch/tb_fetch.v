`timescale 1ns/1ps
module tb_fetch();
    reg clk;
    reg rst_n;
    reg [31:0] EX_MEM_PCSrc;
    reg [31:0] EX_MEM_NPC;
    wire [31:0] IF_ID_instr;
    wire [31:0] IF_ID_npc;
    integer i;      //Declared for the loop
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
//initial begin

//  rst_n = 0;    //reset ACTIVE HIGH
//   EX_MEM_PCSrc = 0;
//   EX_MEM_NPC = 32'h0;

//   #10;
//   rst_n = 1;

////Testing to see if all 10 memory words are present   
//   $display("Cycle | Time | PC Current | IF_ID_npc | IF_ID_instr");

//   for (i = 0; i < 11; i = i + 1) begin
//        @(posedge clk);
//        #0.1;

//        $display("%5d | %4t | %h | %h | %h",    //Writes to Log the the PC, the NPC, and Instruction
//                 i + 1,
//                 $time,
//                 DUT.pc_current,
//                 IF_ID_npc,
//                 IF_ID_instr);
//        end
//  $finish;
//end

//uncomment for testing First Blcok
 
/* Second Initial Begin Block - Tests branching */
initial begin

    rst_n = 0;    //reset ACTIVE HIGH
    EX_MEM_PCSrc = 0;
    EX_MEM_NPC = 32'h0;
    
    #10;
    rst_n = 1;
    
    $display("Cycle | Time | PC Current | IF_ID_npc | IF_ID_instr");
    for (i = 0; i < 10; i = i+1) begin
       @(negedge clk);
       
       if (i == 3) begin            //Can test at any other case to see a branch jump instead of increments of 1 in the PC
            EX_MEM_PCSrc = 1'b1;
            EX_MEM_NPC = 32'h7;
       end
       
       else begin
            EX_MEM_PCSrc = 1'b0;
       end
       
       @(posedge clk);
       #0.1;
       
       $display("%5d | %h | %h | %b | %h | %h",
                 i + 1,
                 DUT.pc_current,
                 DUT.pc_next,
                 EX_MEM_PCSrc,
                 EX_MEM_NPC,
                 IF_ID_instr);
    end
       
    $finish;
  end

endmodule