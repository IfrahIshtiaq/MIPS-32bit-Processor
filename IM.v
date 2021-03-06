module instr_mem(
    input [31:0] pc,
    output [31:0] instruction
    );
	 
	 
      reg [31:0] instMem[58:0];  
		
      initial  
			begin
						instMem[0] <= 32'b00000000000000000000000000000000;
						instMem[1] <= 32'b00000010001100101000000000100000;		//add $s0, $s1, $s2
						instMem[2] <= 32'b00000010011101001010100000000101;		//or $s5, $s3, $s4
						instMem[3] <= 32'b00000010110101111100000000000100;		//and $s8, $s6, $s7
						instMem[4] <= 32'b00000001000010010101000000100000;		//add $t2, $t0, $t1
						instMem[5] <= 32'b00000001100010110110100000000010;		//sub $t5, $t4, $t3
						instMem[6] <= 32'b00000010011101001010100000100110;		//xor $s5, $s3, $s4
						instMem[7] <= 32'b00100010010100010000000000001100;		//addi $s1, $s2, 12
						
						/*instMem[0] <= 32'b000000 00000 00000 00000 00000 000000;
						instMem[1] <= 32'b000000 10001 10010 10000 00000 100000;		//add $s0, $s1, $s2
						instMem[2] <= 32'b000000 10011 10100 10101 00000 000101;		//or $s5, $s3, $s4
						instMem[3] <= 32'b100011 10110 10111 11000 00000 000100;		//and $s8, $s6, $s7
						instMem[4] <= 32'b000000 01000 01001 01010 00000 100000;		//add $t2, $t0, $t1
						instMem[5] <= 32'b000000 01100 01011 01101 00000 000010;		//sub $t5, $t4, $t3
						instMem[6] <= 32'b000000 01100 01011 01101 00000 000010;		//addi $s1, $s2, 12
						instMem[2] <= 32'b000000 10011 10100 10101 00000 100110;		//xor $s5, $s3, $s4
						
								
						instMem[3] <= 32'b100011 10011 01000 00000 00000 100000;		//lw $t0, 32($s3) 
						
						instMem[] <= 32'b000000 00000 00000 00000 00000 000000;
						instMem[] <= 32'b000000 10001 10010 10000 00000 100000;		//add $s0, $s1, $s2
						instMem[] <= 32'b000000 10011 10001 10010 00000 000101;		//or $s5, $s3, $s4 
						instMem[] <= 32'b100011 10011 01000 00000 00000 100000;		//lw $t0, 32($s3) */
						
		
				
			end  	
      assign instruction = (pc[31:0] < 58 )? instMem[pc]: 32'd0; //Instruction Read

endmodule