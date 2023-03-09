module InstructionMemory(
input [31:0] A,
output wire [31:0] instr);

reg [31:0] memory [63:0];
assign instr=memory[A[31:2]];

initial begin
$readmemh("text",memory);
end

endmodule
