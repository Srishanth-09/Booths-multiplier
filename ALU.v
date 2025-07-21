`timescale 1ns / 1ps
module ALU(out,in1,in2,addsub);
input [15:0] in1,in2;
input addsub;
output reg [15:0]out;
always@(*)
begin
    if(addsub==0) out=in1-in2;
    else out=in1+in2;
end    
endmodule
