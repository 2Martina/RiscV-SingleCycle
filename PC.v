module PC(
input clk,areset,load,PCsrc,
input [31:0] ImmExt,
output reg [31:0] PC);

wire [31:0] PC_next;
reg [31:0] PCplus4,PCtarget;
always@(posedge clk or negedge areset) begin
if (!areset)
	PC <= 32'b0;
else if (load==1)
	 PC<=PC_next;
end

always@(*)begin
PCplus4<=PC+4;
PCtarget<=PC+ImmExt;
end
Mux2by1 UUT(.in1(PCplus4),.in2(PCtarget),.sel(PCsrc),.out(PC_next));
endmodule
