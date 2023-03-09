module ALU(input[31:0] a,b,
output reg[31:0] result,
input[2:0] sel , 
output reg CF, 
output ZF,SF);

assign ZF=~|result;
assign SF=result[31];
always@(*)
begin
  case(sel)
    3'b000: {CF,result}=a+b;
    3'b001: {CF,result}=a<<b;
    //3'b010: {CF,result}=b;
    3'b010: {CF,result}=a-b;
    3'b100: {CF,result}=a^b;
    3'b101: {CF,result}=a>>b;
    3'b110: {CF,result}=a|b;
    3'b111: {CF,result}=a&b;
    default: {CF,result}=32'b0;
  endcase
    
end 

endmodule