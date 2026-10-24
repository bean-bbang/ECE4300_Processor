`timescale 1ns / 1ps

module sign_extend(
    input  wire [15:0] immediate,
    output wire [31:0] extended
    );
    
//Sign extend by replicating MSB of immediate
assign extended = {{16{immediate[15]}}, immediate};


endmodule
