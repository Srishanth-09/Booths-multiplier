`timescale 1ns / 1ps
module BM_tb;
  reg clk,start;
  reg [15:0]data_in;
  wire ldA,ldQ,clrA,clrQ,sftA,sftQ,ldM,clrff,addsub,decr,ldcnt,done;
  wire q0,qm1,eqz;
  wire [31:0]product;

  always #5 clk= ~clk;
  BOOTH uut_datapath (
    .ldA(ldA),.ldQ(ldQ),.ldM(ldM),.clrA(clrA),.clrQ(clrQ),.clrff(clrff),.sftA(sftA),.sftQ(sftQ), .addsub(addsub),
    .decr(decr),.ldcnt(ldcnt),.data_in(data_in),.clk(clk),
    .qm1(qm1),.eqz(eqz),.product(product)
  );
  control_path uut_control (
    .ldA(ldA),.ldQ(ldQ),.clrA(clrA),.clrQ(clrQ),.sftA(sftA),.sftQ(sftQ),.ldM(ldM),.clrff(clrff),
    .addsub(addsub),.start(start),.decr(decr),.ldcnt(ldcnt),.done(done),.clk(clk),.q0(product[0]),.qm1(qm1),.eqz(eqz)
  );
  initial begin
    clk =0;
    start= 0;
    data_in =0;
    #10;
    data_in=16'sd3;    // Multiplicand=3
    start=1;
    #10 start =0;
    #10 data_in = -16'sd4;  // Multiplier Q=-4

    #500;
    $display("Result = %0d", $signed(product));
    $stop;
  end

endmodule
