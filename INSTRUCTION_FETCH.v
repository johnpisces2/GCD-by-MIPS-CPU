`timescale 1ns/1ps

module INSTRUCTION_FETCH(
	clk,
	rst,
	jump,
	branch,
	jump_addr,
	branch_addr,

	PC,
	IR
);

input clk, rst, jump, branch;
input [31:0] jump_addr, branch_addr;

output reg 	[31:0] PC, IR;

reg [31:0] instruction [127:0];

// output instruction
always @(posedge clk or posedge rst)
begin
	if(rst)
		IR <= 32'd0;
	else
		IR <= instruction[PC[10:2]];
end

// output program counter
always @(posedge clk or posedge rst or branch)
begin
	if(rst)
		PC <= 32'd0;
	else if(branch)
			PC <= branch_addr;
	else if(jump)
			PC <= jump_addr;
	else 
			PC <= PC+4;
		//PC <= (branch) ? branch_addr : ( (jump) ? jump_addr : (PC+4)) ;
end


endmodule

