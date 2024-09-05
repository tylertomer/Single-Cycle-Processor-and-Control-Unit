`define OPCODE_ANDREG 11'b?0001010???
`define OPCODE_ORRREG 11'b?0101010???
`define OPCODE_ADDREG 11'b?0?01011???
`define OPCODE_SUBREG 11'b?1?01011???

`define OPCODE_ADDIMM 11'b?0?10001???
`define OPCODE_SUBIMM 11'b?1?10001???

`define OPCODE_MOVZ   11'b110100101??

`define OPCODE_B      11'b?00101?????
`define OPCODE_CBZ    11'b?011010????

`define OPCODE_LDUR   11'b??111000010
`define OPCODE_STUR   11'b??111000000

module control(
    output reg reg2loc,
    output reg alusrc,
    output reg mem2reg,
    output reg regwrite,
    output reg memread,
    output reg memwrite,
    output reg branch,
    output reg uncond_branch,
    output reg [3:0] aluop,
    output reg [2:0] signop,
    input [10:0] opcode
);

always @(*)
begin
    casez (opcode)

        /* Add cases here for each instruction your processor supports */
	
	`OPCODE_LDUR: begin
            reg2loc       <= 1'bx; //from Pre-Lab Reg2Loc is X
            alusrc        <= 1'b1; //ALUSrc is 1
            mem2reg       <= 1'b1; //MemtoReg is 1
            regwrite      <= 1'b1; //RegWrite is 1
            memread       <= 1'b1; //MemRead is 1
            memwrite      <= 1'b0; //MemWrite is 0
            branch        <= 1'b0; //Branch is 0
            uncond_branch <= 1'b0; //Unconditional Branch is 0
            aluop         <= 4'b0010; //ALUop is 0010 (ADD)
            signop        <= 3'b001; //D-Type
        end

	`OPCODE_STUR: begin
            reg2loc       <= 1'b1; //from Pre-Lab Reg2Loc is 1
            alusrc        <= 1'b1; //ALUSrc is 1
            mem2reg       <= 1'bX; //MemtoReg is X
            regwrite      <= 1'b0; //RegWrite is 0
            memread       <= 1'b0; //MemRead is 0
            memwrite      <= 1'b1; //MemWrite is 1
            branch        <= 1'b0; //Branch is 0
            uncond_branch <= 1'b0; //Unconditional Branch is 0 
            aluop         <= 4'b0010; //ALUop is 0010 (ADD)
            signop        <= 3'b001; //D-Type
        end

	`OPCODE_ADDREG: begin
            reg2loc       <= 1'b0; //from Pre-Lab Reg2Loc is 0
            alusrc        <= 1'b0; //ALUSrc is 0
            mem2reg       <= 1'b0; //MemtoReg is 0
            regwrite      <= 1'b1; //RegWrite is 1
            memread       <= 1'b0; //MemRead is 0
            memwrite      <= 1'b0; //MemWrite is 0
            branch        <= 1'b0; //Branch is 0
            uncond_branch <= 1'b0; //Unconditional Branch is 0 
            aluop         <= 4'b0010; //ALUop is 0010 (ADD)
            signop        <= 3'bXXX; //R-Type is X
        end

	`OPCODE_ADDIMM: begin
            reg2loc       <= 1'bX; //from Pre-Lab Reg2Loc is X
            alusrc        <= 1'b1; //ALUSrc is 1
            mem2reg       <= 1'b0; //MemtoReg is 0
            regwrite      <= 1'b1; //RegWrite is 1
            memread       <= 1'b0; //MemRead is 0
            memwrite      <= 1'b0; //MemWrite is 0
            branch        <= 1'b0; //Branch is 0
            uncond_branch <= 1'b0; //Unconditional Branch is 0 
            aluop         <= 4'b0010; //ALUop is 0010 (ADD)
            signop        <= 3'b000; //ADD immediate -> I-Type is 00
        end

	`OPCODE_SUBREG: begin
            reg2loc       <= 1'b0; //from Pre-Lab Reg2Loc is 0
            alusrc        <= 1'b0; //ALUSrc is 0
            mem2reg       <= 1'b0; //MemtoReg is 0
            regwrite      <= 1'b1; //RegWrite is 1
            memread       <= 1'b0; //MemRead is 0
            memwrite      <= 1'b0; //MemWrite is 0
            branch        <= 1'b0; //Branch is 0
            uncond_branch <= 1'b0; //Unconditional Branch is 0 
            aluop         <= 4'b0110; //ALUop is 0110 (SUB)
            signop        <= 3'bXXX; //R-Type is X
        end

	`OPCODE_SUBIMM: begin
            reg2loc       <= 1'bX; //from Pre-Lab Reg2Loc is X
            alusrc        <= 1'b1; //ALUSrc is 0
            mem2reg       <= 1'b0; //MemtoReg is 0
            regwrite      <= 1'b1; //RegWrite is 1
            memread       <= 1'b0; //MemRead is 0
            memwrite      <= 1'b0; //MemWrite is 0
            branch        <= 1'b0; //Branch is 0
            uncond_branch <= 1'b0; //Unconditional Branch is 0 
            aluop         <= 4'b0110; //ALUop is 0010 (ADD)
            signop        <= 3'b000; //ADD immediate -> I-Type is 00
        end

	`OPCODE_ANDREG: begin
            reg2loc       <= 1'b0; //from Pre-Lab Reg2Loc is 0
            alusrc        <= 1'b0; //ALUSrc is 0
            mem2reg       <= 1'b0; //MemtoReg is 0
            regwrite      <= 1'b1; //RegWrite is 1
            memread       <= 1'b0; //MemRead is 0
            memwrite      <= 1'b0; //MemWrite is 0
            branch        <= 1'b0; //Branch is 0
            uncond_branch <= 1'b0; //Unconditional Branch is 0 
            aluop         <= 4'b0000; //ALUop is 0000 (AND)
            signop        <= 3'bXXX; //R-Type is XX
        end

	`OPCODE_ORRREG: begin
            reg2loc       <= 1'b0; //from Pre-Lab Reg2Loc is 0
            alusrc        <= 1'b0; //ALUSrc is 0
            mem2reg       <= 1'b0; //MemtoReg is 0
            regwrite      <= 1'b1; //RegWrite is 1
            memread       <= 1'b0; //MemRead is 0
            memwrite      <= 1'b0; //MemWrite is 0
            branch        <= 1'b0; //Branch is 0
            uncond_branch <= 1'b0; //Unconditional Branch is 0 
            aluop         <= 4'b0001; //ALUop is 0001 (ORR)
            signop        <= 3'bXXX; //R-Type is XX
        end

	`OPCODE_CBZ: begin
            reg2loc       <= 1'b1; //from Pre-Lab Reg2Loc is 1
            alusrc        <= 1'b0; //ALUSrc is 0
            mem2reg       <= 1'bX; //MemtoReg is X
            regwrite      <= 1'b0; //RegWrite is 0
            memread       <= 1'b0; //MemRead is 0
            memwrite      <= 1'b0; //MemWrite is 0
            branch        <= 1'b1; //Branch is 1
            uncond_branch <= 1'b0; //Unconditional Branch is 0 
            aluop         <= 4'b0111; //ALUop is 0111 (CBZ -> pass b)
            signop        <= 3'b011; //CB-Tpye is 11
        end

	`OPCODE_B: begin
            reg2loc       <= 1'bX; //from Pre-Lab Reg2Loc is X
            alusrc        <= 1'bX; //ALUSrc is X
            mem2reg       <= 1'bX; //MemtoReg is X
            regwrite      <= 1'b0; //RegWrite is 0
            memread       <= 1'b0; //MemRead is 0
            memwrite      <= 1'b0; //MemWrite is 0
            branch        <= 1'bX; //Branch is X
            uncond_branch <= 1'b1; //Unconditional Branch is 1 
            aluop         <= 4'bXXXX; //ALUop is XXXX for B
            signop        <= 3'b010; //B-Tpye is 10
        end

	`OPCODE_MOVZ: begin
		reg2loc       <= 1'bx; //MOVEZ does not require 2nd register
		alusrc        <= 1'b1; //immediate value source for MOVEZ
		mem2reg       <= 1'b0; //no data from memory
		regwrite      <= 1'b1; //we write result to register
		memread       <= 1'b0; //dont use memory
		memwrite      <= 1'b0; // ^
		branch        <= 1'b0; //no branching
		uncond_branch <= 1'b0; // ^
		aluop         <= 4'b0111; //ALUop is 1000 for MOVEZ
		signop        <= 3'b100; //IM-Type is 100
	end

        default:
        begin
            reg2loc       <= 1'bx;
            alusrc        <= 1'bx;
            mem2reg       <= 1'bx;
            regwrite      <= 1'b0;
            memread       <= 1'b0;
            memwrite      <= 1'b0;
            branch        <= 1'b0;
            uncond_branch <= 1'b0;
            aluop         <= 4'bxxxx;
            signop        <= 3'bxxx;
        end
    endcase
end

endmodule

