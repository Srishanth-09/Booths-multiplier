`timescale 1ns / 1ps
module controller(ldA,ldQ,clrA,clrQ,sftA,sftQ,ldM,clrff,addsub,start,decr,ldcnt,done,clk,q0,qm1,eqz);
input clk,q0,qm1,start,eqz;
output reg ldA,clrA,sftA,ldQ,clrQ,sftQ,ldM,clrff,addsub,decr,ldcnt,done;
reg [2:0]state;
parameter S0=3'b000,S1=3'b001,S2=3'b010,S3=3'b011,S4=3'b100,S5=3'b101,S6=3'b110;
always@(posedge clk)
begin
    
    case(state)
        S0: if(start) state<=S1;
        S1: state<=S2;
        S2: if({q0,qm1}==2'b01) state<=S3;
            else if({q0,qm1}==2'b10) state<=S4;
            else state<=S5;
        S3: state<=S5;
        S4: state<=S5;
        S5: begin
                if (!eqz)begin
                    if({q0,qm1}==2'b01) state<=S3;
                    else if ({q0,qm1} == 2'b10) state <=S4;
                    else state<= S5;
                end else state<= S6;
            end
        S6: state<=S6;
        default : state<=S0;
    endcase
end      
always@(state)
begin
    {ldA, clrA, sftA, ldQ, clrQ, sftQ, ldM, clrff, addsub, decr, ldcnt, done} = 13'b0;
    case(state)
            S1: begin clrA = 1; clrff = 1; ldcnt = 1; ldM = 1; end
            S2: ldQ = 1;
            S3: begin ldA = 1; addsub = 1; end
            S4: begin ldA = 1; addsub = 0; end
            S5: begin sftA = 1; sftQ = 1; decr = 1; end
            S6: done = 1;
end  
endmodule
