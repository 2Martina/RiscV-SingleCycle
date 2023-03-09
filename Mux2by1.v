module Mux2by1(
input [31:0] in1,in2,
input sel ,
output reg [31:0] out);

always@(*) begin
case(sel)
	1'b0: out=in1;
	1'b1: out=in2;
	default: out=32'b0;
endcase
end

endmodule
