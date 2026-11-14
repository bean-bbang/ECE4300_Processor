`timescale 1ns / 1ps

module tb_mem();

    reg clk;
    reg [31:0] alu_result, WriteData;
    reg [4:0] WriteReg;
    reg [1:0] WBControl;
    reg MemWrite, MemRead, Branch, Zero;
    wire [31:0] ReadData, alu_result_out;
    wire [4:0] WriteReg_out;
    wire MEM_WB_regwrite;
    wire MEM_WB_memtoreg;
    wire MEM_PCSrc;

    MEMORY uut (
        .clk(clk),
        .wb_ctlout(WBControl),
        .branch(Branch),
        .memread(MemRead),
        .memwrite(MemWrite),
        .zero(Zero),
        .alu_result(alu_result),
        .rdata2out(WriteData),
        .five_bit_muxout(WriteReg),
        .MEM_PCSrc(MEM_PCSrc),
        .MEM_WB_regwrite(MEM_WB_regwrite),
        .MEM_WB_memtoreg(MEM_WB_memtoreg),
        .read_data(ReadData),
        .mem_alu_result(alu_result_out),
        .mem_write_reg(WriteReg_out)
    );
    initial begin
        clk = 0;
        forever #5 
        clk = ~clk;
    end
    
    initial begin
        alu_result = 32'h0;
        WriteData = 32'h0;
        WriteReg = 5'h0;
        WBControl = 2'b0;
        MemWrite = 0;
        MemRead = 0;
        Branch = 0;
        Zero = 0;

    #10
        /* START OF MEMORY module test*/
    
    //Preload test from data.txt
    alu_result = 32'h00000004;
    MemRead   = 1'b1;
    MemWrite  = 1'b0;
    
    #10
     // Write Data test via Memory
    alu_result = 32'h00000010;
    WriteData  = 32'h0000BEEF;
    WriteReg = 5'h05;
    WBControl  = 2'b11;
    MemWrite   = 1'b1;
    MemRead    = 1'b0;
    
    @(posedge clk)
    #10; // Verify write by reading back

    MemWrite = 1'b0;
    MemRead  = 1'b1;
    #10
    
    Branch = 1;
    Zero   = 1;
    #10; // Check PCSrc

    $finish;
end
endmodule

