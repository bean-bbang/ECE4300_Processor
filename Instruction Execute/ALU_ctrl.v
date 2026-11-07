`timescale 1ns / 1ps

module ALU_ctrl(
    input [5:0] fcunt,
    input [1:0] ALUOp;
    output reg [2:0] ALU_ctrl
);

    localparam ALU_AND = 3'b000, 
                ALU_OR = 3'b001, 
                ALU_ADD = 3'b010, 
                ALU_SUB = 3'b110, 
                ALU_SLT = 3'b111, 
                ALU_X = 3'b011;

    
    always @(*) begin
        case (ALUOp)
            2'b00: ALU_ctrl = ALU_ADD;
            2'b01: ALU_ctrl = ALU_SUB;
            2'b10: begin
                case (funct)
                    6'b100000: ALU_ctrl = ALU_ADD;
                    6'b100010: ALU_ctrl = ALU_SUB;
                    6'b100100: ALU_ctrl = ALU_AND;
                    6'b100101: ALU_ctrl = ALU_OR;
                    6'b101010: ALU_ctrl = ALU_SLT;

                    default: ALU_ctrl = ALU_X;
                endcase
            end
        default: ALU_ctrl = ALU_X;

    endcase
    end
    
endmodule