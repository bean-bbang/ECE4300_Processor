`timescale 1ns/1ps

module tb_pipelineFull;
    reg         clk;
    reg         rst;
    wire [4:0]  wb_write_reg_addr;
    wire [31:0] wb_write_data;
    wire        wb_reg_write_out;

    integer cycle;
    integer wb_write_count;

    top_pipelineFull dut (
        .clk(clk),
        .rst(rst),
        .wb_write_reg_addr(wb_write_reg_addr),
        .wb_write_data(wb_write_data),
        .wb_reg_write_out(wb_reg_write_out)
    );

    // 100 MHz clock (10 ns period)
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
        cycle          = 0;
        wb_write_count = 0;
        rst            = 1'b1;

        // Assert reset for 2 full clock cycles
        @(posedge clk);
        @(posedge clk);
        #1;
        rst = 0;

        // Step through 24 cycles so instructions move through IF -> ID -> EX -> MEM -> WB
        repeat (24) begin
            @(posedge clk);
            #1;
            cycle = cycle + 1;

            if (wb_reg_write_out === 1'b1)
                wb_write_count = wb_write_count + 1;

            $display("Cycle %02d | rst=%b | WB_we=%b | WB_reg=%0d (0x%02h) | WB_data=0x%08h (%0d)",
                     cycle,
                     rst,
                     wb_reg_write_out,
                     wb_write_reg_addr,
                     wb_write_reg_addr,
                     wb_write_data,
                     $signed(wb_write_data));
        end

        $display("--- Simulation Summary ---");
        $display("Total observed WB register writes: %0d", wb_write_count);
        $display("Final cycle state -> WB_we=%b, WB_reg=%0d, WB_data=0x%08h",
                 wb_reg_write_out, wb_write_reg_addr, wb_write_data);

        $finish;
    end
endmodule