module NextPClogic(NextPC, CurrentPC, SignExtImm64, Branch, ALUZero, Uncondbranch); 
   input [63:0] CurrentPC, SignExtImm64; 
   input 	Branch, ALUZero, Uncondbranch; 
   output reg [63:0] NextPC; 

   always @(*) begin
       if(Uncondbranch) begin
           NextPC = CurrentPC + (SignExtImm64 << 2);
       end else if(Branch && ALUZero) begin
           NextPC = CurrentPC + (SignExtImm64 << 2);
       end else begin
           NextPC = CurrentPC + 4;
       end
   end
endmodule
