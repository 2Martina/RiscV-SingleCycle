
module CU(
input zero,sign,
input[31:0] instr,
output reg rsltSrc,MemWrite,RegWrite,PCsrc,
output reg AluSrc,
output reg [2:0] AluControl, 
output reg [1:0] ImmSrc);

reg [1:0] AluOp;
wire [6:0] op;
wire [2:0] funct3;
wire funct7;
reg branch;
assign op=instr[6:0];
assign funct3=instr[14:12];
assign funct7=instr[30];

always@(*) begin
case(op)
7'b000_0011: {RegWrite,ImmSrc,AluSrc,MemWrite,rsltSrc,branch,AluOp}=9'b100101000;
7'b010_0011: {RegWrite,ImmSrc,AluSrc,MemWrite,rsltSrc,branch,AluOp}=9'b00111X000;
7'b011_0011: {RegWrite,ImmSrc,AluSrc,MemWrite,rsltSrc,branch,AluOp}=9'b1XX000010;
7'b001_0011: {RegWrite,ImmSrc,AluSrc,MemWrite,rsltSrc,branch,AluOp}=9'b100100010;
7'b1100011:  {RegWrite,ImmSrc,AluSrc,MemWrite,rsltSrc,branch,AluOp}=9'b01000X101;
default: {RegWrite,ImmSrc,AluSrc,MemWrite,rsltSrc,branch,AluOp}=9'b000000000;
endcase

case(funct3)
3'b000:  PCsrc=zero&branch;
3'b001:  PCsrc=(~zero)&branch;
3'b100:  PCsrc=sign&branch;
default: PCsrc=1'b0;
endcase


case(AluOp)
2'b00: AluControl=3'b000;
2'b01: begin
	if(funct3==3'b000 || funct3==3'b100 || funct3==3'b001)
	  AluControl=3'b010;
       end 
2'b10: begin
	if (funct3==3'b000)
	begin 
	if ({op[5],funct7}==0&0 || {op[5]&funct7}==0&1 || {op[5]&funct7}==1&0)
	  AluControl=3'b000;
	else if ({op[5]&funct7}==1&1) AluControl<=3'b010;
	end
else if (funct3==3'b001)   AluControl=3'b001;
else if (funct3==3'b100)   AluControl=3'b100;
else if (funct3==3'b101)   AluControl=3'b101;
else if (funct3==3'b110)   AluControl=3'b110;
else if (funct3==3'b111)   AluControl<=3'b111;
	end
default: AluControl=3'b000;
endcase

end
endmodule