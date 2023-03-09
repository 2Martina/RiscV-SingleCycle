module RiscV(
input clk,areset);


wire [31:0] PC,instr,WD3,RD1,RD2,SrcB,AluResult,RD,ImmExt;
wire zero,sign,MemWrite,ResultSrc,RegWrite,PCsrc,AluSrc,load;
wire [2:0] AluControl;
wire [1:0] ImmSrc;


PC U1 (.clk(clk),.areset(areset),.load(load),.PCsrc(PCsrc),
.ImmExt(ImmExt),.PC(PC)); 

InstructionMemory U2 (.A(PC),.instr(instr));
//
RegFile U3 (.clk(clk),.reset(areset), .WE3(RegWrite),.A1(instr[19:15]),
.A2(instr[24:20]),.A3(instr[11:7]),.WD3(WD3),.RD1(RD1),.RD2(RD2));

Extend U4 (.ImmSrc(ImmSrc) ,.Instr(instr[31:7]) ,.ImmExt(ImmExt));

Mux2by1 U5 ( .in1(RD2),.in2(ImmExt),.sel(AluSrc) ,.out(SrcB));

ALU U6 (.a(RD1),.b(SrcB),.result(AluResult),.sel(AluControl) ,.CF(),.ZF(zero),.SF(sign));
//
DataMemory U7(.clk(clk),.WE(MemWrite), .A(AluResult),.WD(RD2), .RD(RD));
//
Mux2by1 U8 (.in1(AluResult),.in2(RD),.sel(ResultSrc) ,.out(WD3));

CU U9(.zero(zero),.sign(sign),.instr(instr),.rsltSrc(ResultSrc),.MemWrite(MemWrite),.RegWrite(RegWrite),
.PCsrc(PCsrc),.AluSrc(AluSrc), .AluControl(AluControl),.ImmSrc(ImmSrc));

endmodule