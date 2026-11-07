`timescale 1ns / 1ps

module ALU(
    input  [31:0] a, b,
    input [2:0] sel,
    output reg [31:0] mux_out,
    output zero
);

    always @ (*) begin

        case (sel)
            3'b010: mux_out = a + b;
            3'b110: mux_out = a - b;
            3'b000: mux_out = a & b;
            3'b001: mux_out = a | b;
            3'b111: mux_out = ($signed(a) < $signed(b)) ? 32'd1 : 32'd0;
            default: mux_out = 32'd0;
        endcase

    end
    
assign zero = (mux_out == 32'd0);

endmodule