`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   01:08:26 09/15/2020
// Design Name:   mips_32
// Module Name:   C:/Users/SE/FINAL_1/MIPS_TB.v
// Project Name:  FINAL_1
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: mips_32
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module MIPS_TB;

	// Inputs
	reg clk;
	reg reset;

	// Outputs
	wire [31:0] PC;
	wire [31:0] Instruction;
	wire [4:0] RegRead_1;
	wire [4:0] RegRead_2;
	wire [31:0] RegData_1;
	wire [31:0] RegData_2;
	wire [31:0] ALU_Result;
	wire RegDst;
	wire MemtoReg;
	wire Jump;
	wire Branch;
	wire MemRead;
	wire MemWrite;
	wire [1:0] ALUOp;
	wire AluSource;
	wire RegWrte;
	wire Beq;

	// Instantiate the Unit Under Test (UUT)
	mips_32 uut (
		.clk(clk), 
		.reset(reset), 
		.PC(PC), 
		.Instruction(Instruction), 
		.RegRead_1(RegRead_1), 
		.RegRead_2(RegRead_2), 
		.RegData_1(RegData_1), 
		.RegData_2(RegData_2), 
		.ALU_Result(ALU_Result), 
		.RegDst(RegDst), 
		.MemtoReg(MemtoReg), 
		.Jump(Jump), 
		.Branch(Branch), 
		.MemRead(MemRead), 
		.MemWrite(MemWrite), 
		.ALUOp(ALUOp), 
		.AluSource(AluSource), 
		.RegWrte(RegWrte), 
		.Beq(Beq)
	);

	initial begin  
           clk = 0;  
           forever #10 clk = ~clk;  
      end  
      initial begin  
           // Initialize Inputs  
           //$monitor ("register 3=%d, register 4=%d", reg3,reg4);  
           reset = 1;  
           // Wait 100 ns for global reset to finish  
           #100;  
				reset = 0;  
           // Add stimulus here  
      end
      
endmodule

