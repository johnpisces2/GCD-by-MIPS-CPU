`timescale 1ns/1ps

module EXECUTION(
	clk,
	rst,
	DX_MemtoReg,
	DX_RegWrite,
	DX_MemRead,
	DX_MemWrite,
	DX_branch,
	ALUctr,
	NPC,
	A,
	B,
	imm,
	DX_RD,
	DX_MD,

	XM_MemtoReg,
	XM_RegWrite,
	XM_MemRead,
	XM_MemWrite,
	XM_branch,
	ALUout,
	XM_RD,
	XM_MD,
	XM_BT
);
input clk, rst, DX_MemtoReg, DX_RegWrite, DX_MemRead, DX_MemWrite, DX_branch, DX_jump;
input [2:0] ALUctr;
input [31:0]JT, DX_PC, NPC, A, B;
input [15:0]imm;
input [4:0] DX_RD, DX_MD;

output reg XM_MemtoReg, XM_RegWrite, XM_MemRead, XM_MemWrite, XM_branch;
output reg [31:0]ALUout, XM_BT;
output reg [4:0] XM_RD, XM_MD;

always @(posedge clk or posedge rst)
begin
	if(rst) begin
		XM_MemtoReg	<= 1'b0;
		XM_RegWrite	<= 1'b0;
		XM_MemRead 	<= 1'b0;
		XM_MemWrite	<= 1'b0;
		XM_RD 	   	<= 5'b0;
		XM_MD 	   	<= 5'b0;
		XM_branch	<= 1'b0;
		XM_BT		<=32'b0;
	end else begin
		XM_MemtoReg	<= DX_MemtoReg;
		XM_RegWrite	<= DX_RegWrite;
		XM_MemRead 	<= DX_MemRead;
		XM_MemWrite	<= DX_MemWrite;
		XM_RD 	   	<= DX_RD;
		XM_MD 	   	<= DX_MD;
	    XM_branch=((ALUctr==5) && (A == B) && DX_branch)? 1'b1: 1'b0;
		XM_BT=NPC+4	+  { {14{imm[15]}}, imm, 2'b00 };
		//XM_BT=NPC+{ { 15{imm[15]}}, imm, 2'b0};
	end
end

always @(posedge clk or posedge rst)
begin
   if(rst) begin
   		ALUout <= 32'b0;
   end else begin
   		case(ALUctr)
			3'd2: //and
		    	ALUout <= A & B;
		  	3'd0: //add //lw
		     	ALUout <= A + B;
		  	3'd1: //sub
		    	ALUout <= A - B;
		  	3'd3: //or
		     	ALUout <= A | B;
		  	3'd4: //slt
		     	ALUout <= (A >= B) ? 32'b0 : 32'b1;
		  	3'd5: //branch
		     	ALUout <= 32'b0;
		 	default:
		    	$display("ERROR instruction!!");
		endcase
   end
end


endmodule

