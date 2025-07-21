`timescale 1ns / 1ps
module shiftreg(out,in,s_in,clk,ld,clr,sft);
input s_in,clk,ld,clr,sft;
input [15:0]in;
output reg [15:0]out;
always@(posedge clk)
begin
    if(clr) out<=16'b0;
    else if(ld)
        out<=in;
    else if(sft)
        out<={s_in,out[15:1]};
end
endmodule
