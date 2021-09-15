module control(
    input [5:0] opcode,
    input reset,
    output reg  reg_dst,
    output reg  mem_to_reg,
    output reg [1:0] alu_op,
    output reg jump,
    output reg branch,
    output reg mem_read,
    output reg mem_write,
    output reg alu_src,
    output reg reg_write,
	 output reg sign_or_zero	//////////////////
    );
	 
	 always @(*)  
	 if (reset) begin
						  reg_dst = 1'b0;
						  alu_src = 1'b0;
						  mem_to_reg = 1'b0;
						  reg_write = 1'b0;
						  mem_read = 1'b0;
						  mem_write = 1'b0;
						  branch = 1'b0;
						  alu_op = 2'b00;
						  jump = 1'b0;
						  sign_or_zero = 1'b0;
	  end
	  else begin
	  begin case(opcode) 
		6'b000000 : begin // R - type
						  reg_dst = 1'b1;
						  alu_src = 1'b0;
						  mem_to_reg= 1'b0;
						  reg_write = 1'b1;
						  mem_read = 1'b0;
						  mem_write= 1'b0;
						  branch = 1'b0;
						  alu_op = 2'b10;
						  jump = 1'b0;
						  sign_or_zero= 1'b0;
						 end
						 
		 6'b100011 : begin // lw - load word 
						  reg_dst = 1'b0;
						  alu_src = 1'b1;
						  mem_to_reg = 1'b1;
						  reg_write = 1'b1;
						  mem_read = 1'b1;
						  mem_write = 1'b0;
						  branch = 1'b0;
						  alu_op = 2'b00;
						  jump = 1'b0;
						  sign_or_zero = 1'b0; // sign extend
						 end
						 
		 6'b101011 : begin // sw - store word
						  reg_dst = 1'bx;
						  alu_src = 1'b1;
						  mem_to_reg = 1'bx;
						  reg_write = 1'b0;
						  mem_read = 1'b0;
						  mem_write = 1'b1;
						  branch = 1'b0;
						  alu_op = 2'b00;
						  jump = 1'b0;
						  sign_or_zero = 1'b0;
						 end
						 
		6'b000100 : begin // beq - branch if equal
						  reg_dst = 1'b0;
						  alu_src = 1'b0;
						  mem_to_reg = 1'b0;
						  reg_write = 1'b0;
						  mem_read = 1'b0;
						  mem_write = 1'b0;
						  branch = 1'b1;
						  alu_op = 2'b01;
						  jump = 1'b0;
						  sign_or_zero = 1'b1; 
						 end
						 
		 6'b000101 : begin // bne - branch if not equal
						  reg_dst = 1'b0;
						  alu_src = 1'b0;
						  mem_to_reg = 1'b0;
						  reg_write = 1'b0;
						  mem_read = 1'b0;
						  mem_write = 1'b0;
						  branch = 1'b1;
						  alu_op = 2'b01;
						  jump = 1'b0;
						  sign_or_zero = 1'b0; // sign extend
						 end
						 
			6'b001000 : begin // Addi - ADD immidiate
						  reg_dst = 1'b0;
						  alu_src = 1'b1;
						  mem_to_reg = 1'b0;
						  reg_write = 1'b1;
						  mem_read = 1'b0;
						  mem_write = 1'b0;
						  branch = 1'b0;
						  alu_op = 2'b00;
						  jump = 1'b0;
						  sign_or_zero = 1'b1; // sign extend
						 end						 

						 
		 6'b001110 : begin // XORI - XOR immidiate
						  reg_dst = 1'b1;
						  alu_src = 1'b1;
						  mem_to_reg = 1'b0;
						  reg_write = 1'b1;
						  mem_read = 1'b0;
						  mem_write = 1'b0;
						  branch = 1'b0;
						  alu_op = 2'b11;
						  jump = 1'b0;
						  sign_or_zero = 1'b1; // zero extend
						 end
						 
		 6'b000010 : begin // j - Jump
						  reg_dst = 1'b0;
						  alu_src = 1'b0;
						  mem_to_reg = 1'b0;
						  reg_write = 1'b0;
						  mem_read = 1'b0;
						  mem_write = 1'b0;
						  branch = 1'b0;
						  alu_op = 2'b00;
						  jump = 1'b1;
						  sign_or_zero = 1'b0;
						 end
						 
		 default : begin 
						  reg_dst = 1'b0;
						  alu_src = 1'b0;
						  mem_to_reg = 1'b0;
						  reg_write = 1'b0;
						  mem_read = 1'b0;
						  mem_write = 1'b0;
						  branch = 1'b0;
						  alu_op = 2'b10;
						  jump = 1'b0;
						  sign_or_zero = 1'b0;
						 end
		 
				endcase
		end
		end
		
endmodule