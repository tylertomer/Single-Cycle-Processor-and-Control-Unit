module singlecycle(
    input resetl,
    input [63:0] startpc,
    output reg [63:0] currentpc,
    output [63:0] dmemout,
    input CLK
);

    // Next PC connections
    wire [63:0] nextpc;       // The next PC, to be updated on clock cycle

    // Instruction Memory connections
    wire [31:0] instruction;  // The current instruction

    // Parts of instruction
    wire [4:0] rd;            // The destination register
    wire [4:0] rm;            // Operand 1
    wire [4:0] rn;            // Operand 2
    wire [10:0] opcode;

    // Control wires
    wire reg2loc;
    wire alusrc;
    wire mem2reg;
    wire regwrite;
    wire memread;
    wire memwrite;
    wire branch;
    wire uncond_branch;
    wire [3:0] aluctrl;
    wire [2:0] signop;

    // Register file connections
    wire [63:0] regoutA;     // Output A
    wire [63:0] regoutB;     // Output B

    // ALU connections
    wire [63:0] aluout;
    wire zero;

    // Sign Extender connections
    wire [63:0] extimm;

    // PC update logic
    always @(negedge CLK)
    begin
        if (resetl)
            currentpc <= nextpc;
        else
            currentpc <= startpc;
    end

    // Parts of instruction
    assign rd = instruction[4:0];
    assign rm = instruction[9:5];
    assign rn = reg2loc ? instruction[4:0] : instruction[20:16];
    assign opcode = instruction[31:21];

    InstructionMemory imem(
        .Data(instruction),
        .Address(currentpc)
    );

    control Control(
        .reg2loc(reg2loc),
        .alusrc(alusrc),
        .mem2reg(mem2reg),
        .regwrite(regwrite),
        .memread(memread),
        .memwrite(memwrite),
        .branch(branch),
        .uncond_branch(uncond_branch),
        .aluop(aluctrl),
        .signop(signop),
        .opcode(opcode)
    );

    // Data Memory
    DataMemory dmem(
        .ReadData(dmemout),
        .Address(aluout),
        .WriteData(regoutB),
        .MemoryRead(memread),
        .MemoryWrite(memwrite),
        .Clock(CLK)
    );

    wire [63:0] Writedata;  
    assign Writedata = mem2reg ? dmemout : aluout; // mux that selects between aluout and memory out 

    RegisterFile registerfile(
        .RA(rm),
        .RB(rn),
        .RW(rd),
        .BusW(Writedata),
        .RegWr(regwrite),
        .BusA(regoutA),
        .BusB(regoutB),
        .Clk(CLK)
    );

    SignExtender signext(
        .Imm16(instruction[31:0]),
        .Ctrl(signop),
        .actualOut(extimm)
    );

    wire [63:0] ALUBusB;
    assign ALUBusB = alusrc ? extimm : regoutB; //mux that selects between sign extend and the reg output

    ALU alu(
        .BusA(regoutA),
        .BusB(ALUBusB),
        .ALUCtrl(aluctrl),
        .Zero(zero),
        .BusW(aluout)
    );

    NextPClogic nextpclogic(
        .NextPC(nextpc),
        .CurrentPC(currentpc),
        .SignExtImm64(extimm),
        .Branch(branch),
        .ALUZero(zero),
        .Uncondbranch(uncond_branch)
    );



endmodule

