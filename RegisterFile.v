module RegisterFile(BusA, BusB, BusW, RA, RB, RW, RegWr, Clk);
   	output [63:0] BusA;
   	output [63:0] BusB;
	input [63:0] BusW;
    	input [4:0] RW, RA, RB;
   	input RegWr;
    	input Clk;
    	reg [63:0] registers [31:0];

	
	assign #2 BusA = (RA == 5'b11111) ? 64'h0000000000000000 : registers[RA]; // muxes that chose between register data and 0 for XZR
    	assign #2 BusB = (RB == 5'b11111) ? 64'h0000000000000000 : registers[RB];

	
	always @(negedge Clk) begin //writes back on negative edge checks for reg write enable and if the register is XZR
        	if (RegWr && (RW != 5'b11111)) begin
            		registers[RW] <= #3 BusW;
		end
        end
endmodule