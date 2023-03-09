module DataMemory(
input clk,
input WE, 
input [31:0] A,
input [31:0] WD,
output wire [31:0] RD);

reg [31:0] reg_arr [63:0];
always@(posedge clk) begin
if (WE)
reg_arr[A[31:2]] <= WD;
end

assign RD=reg_arr[A];

endmodule