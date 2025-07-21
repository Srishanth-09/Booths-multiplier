`timescale 1ns / 1ps
module BOOTH(ldA,ldQ,ldM,clrA,clrQ,clrff,sftA,sftQ,addsub,decr,ldcnt,data_in,clk,qm1,eqz,product);
input ldA,ldQ,ldM,clrA,clrQ,clrff,sftA,sftQ,addsub,decr,ldcnt,clk;
input [15:0]data_in;
output qm1,eqz;
output [31:0] product;
wire [15:0]A,M,Q,Z;
wire [4:0] count;
assign eqz= ~|count;
assign product = {A, Q};
shiftreg AR(A,Z,A[15],clk,ldA,clrA,sftA);
shiftreg QR(Q,data_in,A[0],clk,ldQ,clrQ,sftQ);
dff QM1(Q[0],qm1,clk,clrff);
PIPO MR(M,data_in,ldM,clk);
ALU AS(Z,A,M,addsub);
counter CN(count,decr,ldcnt,clk);
endmodule
