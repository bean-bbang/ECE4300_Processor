module data_memory (
    input clk,
    input [31:0] alu_result,
    input [31:0] write_data,
    input memread, memwrite,
    output [31:0] read_data
);
    reg [31:0] dmem [0:255];
    integer i;

    initial begin
        for (i = 0; i < 256; i = i + 1) dmem[i] = 32'b0;
        $readmemb("data.txt", dmem);
    end

    assign read_data = memread ? dmem[alu_result[9:2]] : 32'b0;

    always @(posedge clk)
        if (memwrite) dmem[alu_result[9:2]] <= write_data;
endmodule
