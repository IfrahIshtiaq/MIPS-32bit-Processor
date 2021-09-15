module ALUControl(
    output reg [2:0] ALU_Control,
    input [1:0] ALUOp,
    input [5:0] Function
    );
	 
	 

always @(ALUOp or Function) 
			begin
				if (ALUOp == 2'b00) ALU_Control=3'b010; 			// ALU Op = 00 for lw/sw
				else if (ALUOp == 2'b01) ALU_Control=3'b110;		// ALU Op = 01 for beq/bne
				else if (ALUOp == 2'b11) ALU_Control=3'b010;		// ALU Op = 11 for 
				else if (ALUOp == 2'b10)								// ALU Op = 00 for R Type
					begin
						case(Function)
							 6'b100000: ALU_Control=3'b010;   		// Funct = 100000 for add
							 6'b000010: ALU_Control=3'b110;  		// Funct = 000010 for sub 
							 6'b000100: ALU_Control=3'b000;  		// Funct = 000100 for and 
							 6'b000101: ALU_Control=3'b001;  		// Funct = 000101 for or 
							 6'b101010: ALU_Control=3'b100;  		// Funct = 101010 for slt
							 6'b100110: ALU_Control=3'b011;  		// Funct = 100110 for xor
								default: ALU_Control=3'b000; 
						endcase
					end
			end
			
			/*wire [7:0] ALUControlIn;  
	 assign ALUControlIn = {ALUOp,Function};  
	 always @(ALUControlIn)  
	 casex (ALUControlIn)  
    8'b00xxxxxx: ALU_Control=3'b010;  // ALU Op = 00 for lw
    8'b00xxxxxx: ALU_Control=3'b010;  // ALU Op = 00 for sw
    8'b01xxxxxx: ALU_Control=3'b110;  // ALU Op = 01 for beq
    8'b10100000: ALU_Control=3'b010;  // Funct = 100000 for add
    8'b10000010: ALU_Control=3'b110;  // Funct = 000010 for sub 
    8'b10000100: ALU_Control=3'b000;  // Funct = 000100 for and 
    8'b10000101: ALU_Control=3'b001;  // Funct = 000101 for or 
    8'b10101010: ALU_Control=3'b100;  // Funct = 101010 for slt 
    default: ALU_Control=3'b000;  
    endcase  
endmodule  */
	 

endmodule 