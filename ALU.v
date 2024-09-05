`define AND 4'b0000
`define OR 4'b0001
`define ADD 4'b0010
`define SUB 4'b0110
`define PASSB 4'b0111
`define MOVZ 4'b1000

module ALU(BusW, BusA, BusB, ALUCtrl, Zero);
	parameter n = 64;
	
	output [n-1:0] BusW;
	input [n-1:0] BusA, BusB;
	input [3:0] ALUCtrl;
	output Zero;

	reg [n-1:0] BusW;

	always @(ALUCtrl or BusA or BusB) begin
		case(ALUCtrl)
			`AND: begin //AND operation
				BusW <= (BusA & BusB); //BusW output of ALU
			end

			`OR: begin //OR operation
				BusW <= (BusA | BusB);
			end

			`ADD: begin //ADD operation
				BusW <= (BusA + BusB);
			end

			`SUB: begin //SUB operation
				BusW <= (BusA - BusB);
			end

			`MOVZ: begin // MOVZ operation
    				BusW <= {48'b0, BusB[15:0]};
			end

			`PASSB: BusW <= BusB;// pass B mean just give value og B to W
			endcase
	end
	assign Zero = (BusW == 0) ? 1:0; //if BusW = 0, Zero = 1
endmodule