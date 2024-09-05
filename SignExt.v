module SignExtender(
    output reg [63:0] actualOut, 
    input [31:0] Imm16, 
    input [2:0] Ctrl
);

    always @(*) begin
        case(Ctrl)
            3'b000: begin // 12-bit zero extended to 64-bit (ADD, SUB) I-type
                actualOut = {52'b0, Imm16[21:10]};
            end
            3'b001: begin // 9-bit zero extended to 64-bit D-type
                actualOut = {55'b0, Imm16[20:12]};
            end
            3'b010: begin // 26-bit sign extended to 64-bit B-type
                actualOut = {{38{Imm16[25]}}, Imm16[25:0]};
            end
            3'b011: begin // 19-bit sign extended to 64-bit CB-type
                actualOut = {{45{Imm16[23]}}, Imm16[23:5]};
            end
            3'b100: begin // 16-bit zero extended to 64-bit IW-type (MOVZ)
                if (Imm16[22:21] == 2'b00) begin
                    actualOut = {{48{1'b0}}, Imm16[20:5]}; // no shift
                end else if (Imm16[22:21] == 2'b01) begin
                    actualOut = {{32{1'b0}}, Imm16[20:5], {16{1'b0}}}; // shift by 16 
                end else if (Imm16[22:21] == 2'b10) begin
                    actualOut = {{16{1'b0}}, Imm16[20:5], {32{1'b0}}}; // shift by 32
                end else begin // 2'b11
                    actualOut = {Imm16[20:5], {48{1'b0}}}; // shift by 48
                end
            end
            default: begin
                actualOut = 64'b0;
            end
        endcase
    end

endmodule
