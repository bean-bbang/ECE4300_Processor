`timescale 1ns / 1ps

module data_memory(
    input wire clk,
    input wire [31:0] alu_result, // previous: ALUResult Memory Address
    input wire [31:0] readdata2, // previous: write_data Memory Address Contents
    input wire memread, memwrite, // NEW STUFF refer to Lab 2-2 Figure 2.2
    output reg [31:0] read_data // Output of Memory Address Contents
);
    
// Register Declaration
   reg [31:0] DMEM[0:255];  // 256 (2^8) words of 32-bit memory
   integer i;

initial begin
    read_data <= 32'h0;                 //  Initialize DMEM[0-5] from data.txt
    $readmemb("data.txt",DMEM);     //  This is testing the MIPS datapath (lab 6)

    $display("From Data Memory (data.txt):");  //Display DMEM[0-5]
    for (i = 0; i < 6; i = i + 1) begin
        $display("\tDMEM[%0d] = %0b", i, DMEM[i]);
    end
    
    for (i = 6; i < 256; i = i + 1) begin    //Initialize DMEM[6-255] to 6-255  (this is for lab 4 memory stage)
        DMEM[i] = i;
    end
    
        $display("From Data Memory (initial):");
        
        for (i = 6; i < 10; i = i + 1) begin          //Display DMEM[6-9]
            $display("\tDMEM[%0d] = %0d", i, DMEM[i]);
        end
            $display("\t...");
            $display("\tDMEM[%0d] = %0d", 255, DMEM[255]);      //Display DMEM[255]
        
    end

   always@(posedge clk) begin    
       if (memwrite) begin // store
            DMEM[alu_result] <= readdata2; //writes data to address specified by addr wire
       end
end

    always @(*) begin
        if (memread) begin// load
            read_data = DMEM[alu_result]; //grabs data at the address specified by the addr wire 
        end
        
        else begin
            read_data = 32'h0;
        end
end
    
endmodule
