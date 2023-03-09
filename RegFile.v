module RegFile(
input clk,reset,
input WE3,
input [4:0] A1,A2,A3,
input [31:0] WD3,
output wire [31:0] RD1,RD2);

reg [31:0] reg_arr [31:0];
always@(posedge clk , negedge reset) begin
if (!reset)
	begin
	 reg_arr[A1]<= 32'b0;
	 reg_arr[A2]<= 32'b0;
	end
else if (WE3)
	    begin
	     reg_arr[A3] <= WD3;
             end
end

assign RD1=reg_arr[A1];
assign RD2=reg_arr[A2];

endmodule
