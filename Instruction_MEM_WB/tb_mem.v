`timescale 1ns / 1ps

module tb_mem();

    reg clk;
    reg [31:0] alu_result, WriteData;   //changed all ALUResult -> alu_result
    reg [4:0] WriteReg;
    reg [1:0] WBControl;
    reg MemWrite, MemRead, Branch, Zero;
    wire [31:0] ReadData, alu_result_out;
    wire [4:0] WriteReg_out;
    wire [1:0] WBControl_out;
    wire PCSrc;

    mem_stage uut (
        .clk(clk),
        .alu_result(alu_result),
        .WriteData(WriteData),
        .WriteReg(WriteReg),
        .WBControl(WBControl),
        .MemWrite(MemWrite),
        .MemRead(MemRead),
        .Branch(Branch),
        .Zero(Zero),
        .ReadData(ReadData),
        .alu_result_out(alu_result_out),
        .WriteReg_out(WriteReg_out),
        .WBControl_out(WBControl_out),
        .PCSrc(PCSrc)
    );
    initial begin
        clk = 0;
        forever #5 
        clk = ~clk;
    end
    
    initial begin
     // Mem Read
        alu_result = 32'h00000004;
        WriteData = 32'h12345678;
        WriteReg = 5'h02;
        WBControl = 2'b01;
        MemWrite = 0;
        MemRead = 1;
        Branch = 0;
        Zero = 0;

    #10
    
     // Mem Write
        MemWrite = 1;
        MemRead = 0;
        #10; // Allow write to occur
        MemWrite = 0;
        MemRead = 1;
        #10; // Verify write by reading back

    // Branch
        Branch = 1;
        Zero = 1;
        #10; // Check PCSrc
    
    $finish;
end
endmodule

