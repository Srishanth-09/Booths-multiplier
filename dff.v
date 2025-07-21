`timescale 1ns / 1ps
module dff(d,q,clk,clr);
input d,clk,clr;
output reg q;
always@(posedge clk)begin
    if(clr)
        q<=0;
    else
        q<=d;end
endmodule
