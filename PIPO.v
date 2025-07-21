`timescale 1ns / 1ps
module PIPO(out,in,ld,clk);
input ld,clk;
input [15:0] in;
output reg [15:0]out;
always@(posedge clk)
    if(ld)
        out<=in;
endmodule
