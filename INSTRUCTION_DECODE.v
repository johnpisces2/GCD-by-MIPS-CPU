`timescale 1ns/1ps

module INSTRUCTION_DECODE(
	clk,
	rst,
	PC,
	IR,
	MW_MemtoReg,
	MW_RegWrite,
	MW_RD,
	MDR,
	MW_ALUout,

	MemtoReg,
	RegWrite,
	MemRead,
	MemWrite,
	branch,
	jump,
	ALUctr,
	JT,
	DX_PC,
	NPC,
	A,
	B,
	imm,
	RD,
	MD
);
input clk, rst, MW_MemtoReg, MW_RegWrite;
input [31:0] IR, PC, MDR, MW_ALUout;
input [4:0]  MW_RD;

output reg MemtoReg, RegWrite, MemRead, MemWrite, branch, jump;
output reg [2:0] ALUctr;
output reg [31:0]JT, DX_PC, NPC, A, B;
output reg [15:0]imm;
output reg [4:0] RD, MD;

// register files
reg [31:0] REG [0:31];

always @(posedge clk)
begin
	if(MW_RegWrite)
	
			REG[MW_RD] <= (MW_MemtoReg)? MDR : MW_ALUout;

	if (IR[31:26]==6'd3)
		
			REG[32'd31]	<=	PC;
end
			
always @(posedge clk or posedge rst)
begin
	if(rst) begin
		A 	<=32'b0;
		RD 	<=5'b0;
		MD 	<=5'b0;
		imm <=16'b0;
	    DX_PC<=32'b0;
		NPC	<=32'b0;
		//jump 	<=1'b0;
		//JT 	<=32'b0;
	end else begin
		A 	<=REG[IR[25:21]];
		MD 	<=IR[20:16];
		imm <=IR[15:0];
	    DX_PC<=PC;
		NPC	<=PC;
		//jump<=(IR[31:26]==6'd2)?1'b1:1'b0;  //judge on below
		//JT	<={PC[31:28], IR[25:0], 2'b0};    //26->25
	end
end

always @(posedge clk or posedge rst)
begin
   if(rst) begin
   		B 		<= 32'b0;
		MemtoReg<= 1'b0;
		RegWrite<= 1'b0;
		MemRead <= 1'b0;
		MemWrite<= 1'b0;
		branch  <= 1'b0;
		ALUctr	<= 3'b0;
		jump	<= 1'b0;
		JT		<= 32'b0;
   end else begin
   		case( IR[31:26] )
		6'd0:
			begin  // R-type
				B 		<= REG[IR[20:16]];
				RD 		<=IR[15:11];
				MemtoReg<= 1'b0;
				RegWrite<= 1'b1;
				MemRead <= 1'b0;
				MemWrite<= 1'b0;
				branch  <= 1'b0;
				jump	<= 1'b0;
			    case(IR[5:0])
			    	//funct
				    6'd32://add
				        ALUctr <= 3'd0;
				    6'd34://sub
				        ALUctr <= 3'd1;
				    6'd36://and
				        ALUctr <= 3'd2;
				    6'd37://or
				        ALUctr <= 3'd3;
				    6'd42://slt
				        ALUctr <= 3'd4;
					6'd8: //jr
						begin
						jump	<= 1'b1;
						JT		<= REG[IR[25:21]];
						ALUctr 	<= 3'd5;
						end
				    default:
		   				ALUctr <= 3'd0;
		    	endcase
			end
		6'd35:  begin// lw
			    B 		<= { { 16{IR[15]} } , IR[15:0] };//sign_extend(IR[15:0]);
			    RD 	<=IR[20:16];
			    MemtoReg<= 1'b1;
			    RegWrite<= 1'b1;
			    MemRead <= 1'b1;
			    MemWrite<= 1'b0;
			    branch  <= 1'b0;
			    ALUctr  <= 3'd0;
		 	end
		6'd43:  begin// sw
			    B 		<= { { 16{IR[15]} } , IR[15:0] };//sign_extend(IR[15:0]);
			    MemtoReg<= 1'b0;
			    RegWrite<= 1'b0;
			    MemRead <= 1'b0;
			    MemWrite<= 1'b1;
			    branch  <= 1'b0;
			    ALUctr  <= 3'd0;
		 	end
		6'd4:   begin // beq
			    B 		<= REG[IR[20:16]];
			    MemtoReg<= 1'b0;
			    RegWrite<= 1'b0;
			    MemRead <= 1'b0;
			    MemWrite<= 1'b0;
			    branch  <= 1'b1;
			    ALUctr  <= 3'd5;
			end
		6'd2: begin  // j
			    B 		<= 32'b0;
			    MemtoReg<= 1'b0;
			    RegWrite<= 1'b0;
			    MemRead <= 1'b0;
			    MemWrite<= 1'b0;
			    branch 	<= 1'b0;
				jump	<= 1'b1;
				JT	<={PC[31:28], IR[25:0], 2'b0};    //26->25
			    ALUctr  <= 3'd0;
			end
		6'd3: begin //jal
				B 		<= 32'b0;
			    MemtoReg<= 1'b0;
			    RegWrite<= 1'b0;
			    MemRead <= 1'b0;
			    MemWrite<= 1'b0;
			    branch 	<= 1'b0;
				jump	<= 1'b1;
				JT	<={PC[31:28], IR[25:0], 2'b0};    //26->25
			    ALUctr  <= 3'd0;
			end
			default: begin
				$display("ERROR instruction!!");
			end
		endcase
   end
end

endmodule

