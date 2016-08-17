`define CYCLE_TIME 50
`define INSTRUCTION_NUMBERS 102
`timescale 1ns/1ps
`include "CPU.v"

module testbench;
reg Clk, Rst;
reg [31:0] cycles, i;

// Instruction DM initialilation
initial
begin
		cpu.IF.instruction[  0] = 32'b000000_00001_00000_00011_00000_100000;		//add $3, $1, $0		# extend $t1 into $t3
		cpu.IF.instruction[  1] = 32'b000000_00000_00000_00000_00000_100000;		//		add 	$0, $0, $0
		cpu.IF.instruction[  2] = 32'b000000_00000_00000_00000_00000_100000;		//		add 	$0, $0, $0
		cpu.IF.instruction[  3] = 32'b000000_00000_00000_00000_00000_100000;		//		add 	$0, $0, $0
		cpu.IF.instruction[  4] = 32'b000000_00000_00000_00000_00000_100000;		//		add 	$0, $0, $0
		cpu.IF.instruction[  5] = 32'b000000_00000_00000_00000_00000_100000;		//		add 	$0, $0, $0
		cpu.IF.instruction[  6] = 32'b000000_00010_00000_00100_00000_100000;   		//add $4, $2, $0		# extend $t2 into $t4
		cpu.IF.instruction[  7] = 32'b000000_00000_00000_00000_00000_100000;		//		add 	$0, $0, $0
		cpu.IF.instruction[  8] = 32'b000000_00000_00000_00000_00000_100000;		//		add 	$0, $0, $0
		cpu.IF.instruction[  9] = 32'b000000_00000_00000_00000_00000_100000;		//		add 	$0, $0, $0
		cpu.IF.instruction[ 10] = 32'b000000_00000_00000_00000_00000_100000;		//		add 	$0, $0, $0
		cpu.IF.instruction[ 11] = 32'b000000_00000_00000_00000_00000_100000;		//		add 	$0, $0, $0
		cpu.IF.instruction[ 12] = 32'b000010_00000_00000_00000_00000_010010;		//j equalzero(18)
		cpu.IF.instruction[ 13] = 32'b000000_00000_00000_00000_00000_100000;		//		add 	$0, $0, $0
		cpu.IF.instruction[ 14] = 32'b000000_00000_00000_00000_00000_100000;		//		add 	$0, $0, $0
		cpu.IF.instruction[ 15] = 32'b000000_00000_00000_00000_00000_100000;		//		add 	$0, $0, $0
		cpu.IF.instruction[ 16] = 32'b000000_00000_00000_00000_00000_100000;		//		add 	$0, $0, $0
		cpu.IF.instruction[ 17] = 32'b000000_00000_00000_00000_00000_100000;		//		add 	$0, $0, $0
																					//-------equalzero :--------------------------------------
		cpu.IF.instruction[ 18] = 32'b000000_00011_00100_00001_00000_100010;		//sub $1, $3, $4 	#if $t3=$t4,go to Exit and get the gcd
		cpu.IF.instruction[ 19] = 32'b000000_00000_00000_00000_00000_100000;		//		add 	$0, $0, $0
		cpu.IF.instruction[ 20] = 32'b000000_00000_00000_00000_00000_100000;		//		add 	$0, $0, $0
		cpu.IF.instruction[ 21] = 32'b000000_00000_00000_00000_00000_100000;		//		add 	$0, $0, $0
		cpu.IF.instruction[ 22] = 32'b000000_00000_00000_00000_00000_100000;		//		add 	$0, $0, $0
		cpu.IF.instruction[ 23] = 32'b000000_00000_00000_00000_00000_100000;		//		add 	$0, $0, $0
		cpu.IF.instruction[ 24] = 32'b000100_00001_00000_00000_00001_000110;		//beq $1, $0,	Exit(96-24-2=70)	# $t3!=$t4
		cpu.IF.instruction[ 25] = 32'b000000_00000_00000_00000_00000_100000;		//		add 	$0, $0, $0
		cpu.IF.instruction[ 26] = 32'b000000_00000_00000_00000_00000_100000;		//		add 	$0, $0, $0
		cpu.IF.instruction[ 27] = 32'b000000_00000_00000_00000_00000_100000;		//		add 	$0, $0, $0
		cpu.IF.instruction[ 28] = 32'b000000_00000_00000_00000_00000_100000;		//		add 	$0, $0, $0
		cpu.IF.instruction[ 29] = 32'b000000_00000_00000_00000_00000_100000;		//		add 	$0, $0, $0
		cpu.IF.instruction[ 30] = 32'b000010_00000_00000_00000_00000_100100;		//j compare(36)           #compare $t3 & $t4
		cpu.IF.instruction[ 31] = 32'b000000_00000_00000_00000_00000_100000;		//		add 	$0, $0, $0
		cpu.IF.instruction[ 32] = 32'b000000_00000_00000_00000_00000_100000;		//		add 	$0, $0, $0
		cpu.IF.instruction[ 33] = 32'b000000_00000_00000_00000_00000_100000;		//		add 	$0, $0, $0
		cpu.IF.instruction[ 34] = 32'b000000_00000_00000_00000_00000_100000;		//		add 	$0, $0, $0
		cpu.IF.instruction[ 35] = 32'b000000_00000_00000_00000_00000_100000;		//		add 	$0, $0, $0
																					//-------compare :---------------------------------------
		cpu.IF.instruction[ 36] = 32'b000100_00011_00000_00000_00000_111010;		//beq $3, $0, Exit(96-36-2=58)	#critical! ,geting the gcd before $t3==0
		cpu.IF.instruction[ 37] = 32'b000000_00000_00000_00000_00000_100000;		//		add 	$0, $0, $0
		cpu.IF.instruction[ 38] = 32'b000000_00000_00000_00000_00000_100000;		//		add 	$0, $0, $0
		cpu.IF.instruction[ 39] = 32'b000000_00000_00000_00000_00000_100000;		//		add 	$0, $0, $0
		cpu.IF.instruction[ 40] = 32'b000000_00000_00000_00000_00000_100000;		//		add 	$0, $0, $0
		cpu.IF.instruction[ 41] = 32'b000000_00000_00000_00000_00000_100000;		//		add 	$0, $0, $0
		cpu.IF.instruction[ 42] = 32'b000000_00011_00100_00001_00000_101010;		//slt $1, $3, $4 	#t4>$t3 ,$t1=1  or $t4$<t3
		cpu.IF.instruction[ 43] = 32'b000000_00000_00000_00000_00000_100000;		//		add 	$0, $0, $0
		cpu.IF.instruction[ 44] = 32'b000000_00000_00000_00000_00000_100000;		//		add 	$0, $0, $0
		cpu.IF.instruction[ 45] = 32'b000000_00000_00000_00000_00000_100000;		//		add 	$0, $0, $0
		cpu.IF.instruction[ 46] = 32'b000000_00000_00000_00000_00000_100000;		//		add 	$0, $0, $0
		cpu.IF.instruction[ 47] = 32'b000000_00000_00000_00000_00000_100000;		//		add 	$0, $0, $0
		cpu.IF.instruction[ 48] = 32'b000100_00001_00000_00000_00000_011100;		//beq $1, $0, morethan(78-48-2=28) #if t3>=$t4,go to morethan but lessthan
		cpu.IF.instruction[ 49] = 32'b000000_00000_00000_00000_00000_100000;		//		add 	$0, $0, $0
		cpu.IF.instruction[ 50] = 32'b000000_00000_00000_00000_00000_100000;		//		add 	$0, $0, $0
		cpu.IF.instruction[ 51] = 32'b000000_00000_00000_00000_00000_100000;		//		add 	$0, $0, $0
		cpu.IF.instruction[ 52] = 32'b000000_00000_00000_00000_00000_100000;		//		add 	$0, $0, $0
		cpu.IF.instruction[ 53] = 32'b000000_00000_00000_00000_00000_100000;		//		add 	$0, $0, $0
		cpu.IF.instruction[ 54] = 32'b000010_00000_00000_00000_00000_111100;		//j lessthan(60)          #t3<$t4
		cpu.IF.instruction[ 55] = 32'b000000_00000_00000_00000_00000_100000;		//		add 	$0, $0, $0
		cpu.IF.instruction[ 56] = 32'b000000_00000_00000_00000_00000_100000;		//		add 	$0, $0, $0
		cpu.IF.instruction[ 57] = 32'b000000_00000_00000_00000_00000_100000;		//		add 	$0, $0, $0
		cpu.IF.instruction[ 58] = 32'b000000_00000_00000_00000_00000_100000;		//		add 	$0, $0, $0
		cpu.IF.instruction[ 59] = 32'b000000_00000_00000_00000_00000_100000;		//		add 	$0, $0, $0
																					//------lessthan :----------------------------------------
		cpu.IF.instruction[ 60] = 32'b000000_00100_00011_00010_00000_100010;		//sub $2, $4, $3
		cpu.IF.instruction[ 61] = 32'b000000_00000_00000_00000_00000_100000;		//		add 	$0, $0, $0
		cpu.IF.instruction[ 62] = 32'b000000_00000_00000_00000_00000_100000;		//		add 	$0, $0, $0
		cpu.IF.instruction[ 63] = 32'b000000_00000_00000_00000_00000_100000;		//		add 	$0, $0, $0
		cpu.IF.instruction[ 64] = 32'b000000_00000_00000_00000_00000_100000;		//		add 	$0, $0, $0
		cpu.IF.instruction[ 65] = 32'b000000_00000_00000_00000_00000_100000;		//		add 	$0, $0, $0
		cpu.IF.instruction[ 66] = 32'b000000_00010_00000_00100_00000_100000; 		//add $4, $2, $0
		cpu.IF.instruction[ 67] = 32'b000000_00000_00000_00000_00000_100000;		//		add 	$0, $0, $0
		cpu.IF.instruction[ 68] = 32'b000000_00000_00000_00000_00000_100000;		//		add 	$0, $0, $0
		cpu.IF.instruction[ 69] = 32'b000000_00000_00000_00000_00000_100000;		//		add 	$0, $0, $0
		cpu.IF.instruction[ 70] = 32'b000000_00000_00000_00000_00000_100000;		//		add 	$0, $0, $0
		cpu.IF.instruction[ 71] = 32'b000000_00000_00000_00000_00000_100000;		//		add 	$0, $0, $0
		cpu.IF.instruction[ 72] = 32'b000010_00000_00000_00000_00000_100100;		//j compare(36)			#go to compare
		cpu.IF.instruction[ 73] = 32'b000000_00000_00000_00000_00000_100000;		//		add 	$0, $0, $0
		cpu.IF.instruction[ 74] = 32'b000000_00000_00000_00000_00000_100000;		//		add 	$0, $0, $0
		cpu.IF.instruction[ 75] = 32'b000000_00000_00000_00000_00000_100000;		//		add 	$0, $0, $0
		cpu.IF.instruction[ 76] = 32'b000000_00000_00000_00000_00000_100000;		//		add 	$0, $0, $0
		cpu.IF.instruction[ 77] = 32'b000000_00000_00000_00000_00000_100000;		//		add 	$0, $0, $0
																					//------morethan :----------------------------------------
		cpu.IF.instruction[ 78] = 32'b000000_00011_00100_00001_00000_100010;		//sub $1, $3, $4
		cpu.IF.instruction[ 79] = 32'b000000_00000_00000_00000_00000_100000;		//		add 	$0, $0, $0
		cpu.IF.instruction[ 80] = 32'b000000_00000_00000_00000_00000_100000;		//		add 	$0, $0, $0
		cpu.IF.instruction[ 81] = 32'b000000_00000_00000_00000_00000_100000;		//		add 	$0, $0, $0
		cpu.IF.instruction[ 82] = 32'b000000_00000_00000_00000_00000_100000;		//		add 	$0, $0, $0
		cpu.IF.instruction[ 83] = 32'b000000_00000_00000_00000_00000_100000;		//		add 	$0, $0, $0
		cpu.IF.instruction[ 84] = 32'b000000_00001_00000_00011_00000_100000;		//add $3, $1, $0
		cpu.IF.instruction[ 85] = 32'b000000_00000_00000_00000_00000_100000;		//		add 	$0, $0, $0
		cpu.IF.instruction[ 86] = 32'b000000_00000_00000_00000_00000_100000;		//		add 	$0, $0, $0
		cpu.IF.instruction[ 87] = 32'b000000_00000_00000_00000_00000_100000;		//		add 	$0, $0, $0
		cpu.IF.instruction[ 88] = 32'b000000_00000_00000_00000_00000_100000;		//		add 	$0, $0, $0
		cpu.IF.instruction[ 89] = 32'b000000_00000_00000_00000_00000_100000;		//		add 	$0, $0, $0
		cpu.IF.instruction[ 90] = 32'b000010_00000_00000_00000_00000_100100;		//j compare(36)			#go to compare
		cpu.IF.instruction[ 91] = 32'b000000_00000_00000_00000_00000_100000;		//		add 	$0, $0, $0
		cpu.IF.instruction[ 92] = 32'b000000_00000_00000_00000_00000_100000;		//		add 	$0, $0, $0
		cpu.IF.instruction[ 93] = 32'b000000_00000_00000_00000_00000_100000;		//		add 	$0, $0, $0
		cpu.IF.instruction[ 94] = 32'b000000_00000_00000_00000_00000_100000;		//		add 	$0, $0, $0
		cpu.IF.instruction[ 95] = 32'b000000_00000_00000_00000_00000_100000;		//		add 	$0, $0, $0
																					//------Exit :--------------------------------------------
		cpu.IF.instruction[ 96] = 32'b000000_00100_00000_00101_00000_100000;		//add $5, $4, $0
		cpu.IF.instruction[ 97] = 32'b000000_00000_00000_00000_00000_100000;		//		add 	$0, $0, $0
		cpu.IF.instruction[ 98] = 32'b000000_00000_00000_00000_00000_100000;		//		add 	$0, $0, $0
		cpu.IF.instruction[ 99] = 32'b000000_00000_00000_00000_00000_100000;		//		add 	$0, $0, $0
		cpu.IF.instruction[100] = 32'b000000_00000_00000_00000_00000_100000;		//		add 	$0, $0, $0
		cpu.IF.instruction[101] = 32'b000000_00000_00000_00000_00000_100000;		//		add 	$0, $0, $0
cpu.IF.PC = 0;

end

// Data Memory & Register Files initialilation
initial
begin
	cpu.MEM.DM[0] = 32'd9;
	cpu.MEM.DM[1] = 32'd3;
	for (i=2; i<128; i=i+1) cpu.MEM.DM[i] = 32'b0;
	cpu.ID.REG[0] = 32'd0;
	cpu.ID.REG[1] = 32'd36;//numA
	cpu.ID.REG[2] = 32'd12;//numB
	cpu.ID.REG[3] = 32'd0;//initial_temp_A
	cpu.ID.REG[4] = 32'd0;//initial_temp_B
	cpu.ID.REG[5] = 32'd0;//initial_gcd	
/*
---------------------------------		
Register usage
$0		$1		$2		$3		$4		$5
 0		t1		t2		t3		t4  	gcd
*/ 
	for (i=6; i<32; i=i+1) cpu.ID.REG[i] = 32'b0;

end

initial Clk = 1'b1;
always #(`CYCLE_TIME/2) Clk = ~Clk;

initial begin
	cycles = 32'b0;
	Rst = 1'b1;
	#12 Rst = 1'b0;
end

CPU cpu(
	.clk(Clk),
	.rst(Rst)
);



always @(posedge Clk) begin
	cycles <= cycles + 1;
	if (cpu.FD_PC == `INSTRUCTION_NUMBERS*4) $finish; // Finish when excute the 24-th instruction (End label).
	$display("PC: %d cycles: %d", cpu.FD_PC>>2 , cycles);
	$display("  R00-R07: %08d %08d %08d %08d %08d %08d %08x %08x", cpu.ID.REG[0], cpu.ID.REG[1], cpu.ID.REG[2], cpu.ID.REG[3],cpu.ID.REG[4], cpu.ID.REG[5], cpu.ID.REG[6], cpu.ID.REG[7]);
	$display("  R08-R15: %08x %08x %08x %08x %08x %08x %08x %08x", cpu.ID.REG[8], cpu.ID.REG[9], cpu.ID.REG[10], cpu.ID.REG[11],cpu.ID.REG[12], cpu.ID.REG[13], cpu.ID.REG[14], cpu.ID.REG[15]);
	$display("  R16-R23: %08x %08x %08x %08x %08x %08x %08x %08x", cpu.ID.REG[16], cpu.ID.REG[17], cpu.ID.REG[18], cpu.ID.REG[19],cpu.ID.REG[20], cpu.ID.REG[21], cpu.ID.REG[22], cpu.ID.REG[23]);
	$display("  R24-R31: %08x %08x %08x %08x %08x %08x %08x %08d", cpu.ID.REG[24], cpu.ID.REG[25], cpu.ID.REG[26], cpu.ID.REG[27],cpu.ID.REG[28], cpu.ID.REG[29], cpu.ID.REG[30], cpu.ID.REG[31]);
	$display("  0x00   : %08x %08x %08x %08x %08x %08x %08x %08x", cpu.MEM.DM[0],cpu.MEM.DM[1],cpu.MEM.DM[2],cpu.MEM.DM[3],cpu.MEM.DM[4],cpu.MEM.DM[5],cpu.MEM.DM[6],cpu.MEM.DM[7]);
	$display("  0x08   : %08x %08x %08x %08x %08x %08x %08x %08x", cpu.MEM.DM[8],cpu.MEM.DM[9],cpu.MEM.DM[10],cpu.MEM.DM[11],cpu.MEM.DM[12],cpu.MEM.DM[13],cpu.MEM.DM[14],cpu.MEM.DM[15]);
end

initial begin
	$dumpfile("cpu_hw.vcd");
	$dumpvars;
end
endmodule

