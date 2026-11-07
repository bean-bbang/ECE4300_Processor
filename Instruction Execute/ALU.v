`timescale 1ns / 1ps

module ALU(
    input  [31:0] a, b,
    input [2:0] sel,
    output reg mux_out,
    output zero
);

    always @ (*) begin

        case (control)
            3'b010: result = a + b;
            3'b110: result = a - b;
            3'b000: result = a & b;
            3'b001: result = a | b;
            3'b111: result = ($signed(a) < $signed(b)) ? 32'd1 : 32'd0;
            default: result = 32'd0;
        endcase

    end
    
assign zero = (result == 32'd0);

endmodule