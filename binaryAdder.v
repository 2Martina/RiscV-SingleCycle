module binaryAdder(
input [31:0] a,b,
output reg [31:0] sum);

always@(*) begin
sum=a+b;
end
endmodule
