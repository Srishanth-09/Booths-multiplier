`timescale 1ns / 1ps
module counter(out,decr,ldcnt,clk);
input decr,ldcnt,clk;
output reg [4:0] out;
always@(posedge clk)
begin
    if(ldcnt) out<=5'b10000;
    else if(decr) out<=out-1;
end
endmodule
