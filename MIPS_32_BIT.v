module mips_32(
    input clk,
    input reset,
    output [31:0] PC,
	 output [31:0] Instruction,
	 output [4:0] RegRead_1, RegRead_2,
	 output [31:0] RegData_1, RegData_2,
	 output [15:0] Immediate,
    output [31:0] ALU_Result,
	 output RegDst,
	 output MemtoReg,
	 output Jump,
	 output Branch,
	 output MemRead,
	 output MemWrite,
	 output [1:0] ALUOp,
	 output AluSource,
	 output RegWrte,
	 output Beq,
	 output [4:0] Reg_Destination,  
	 output [31:0] Write_Data_Value	 );

 
 // PC: 
 reg [31:0] pc_current;  
 wire signed [31:0] pc_next,pc1;

 // Instruction Memory:
 wire [31:0] instr;  
 
 // Register file: 
 wire  [4:0]  reg_read_addr_1;
 wire  [4:0]  reg_read_addr_2;   
 wire  [31:0] reg_read_data_1;  
 wire  [31:0] reg_read_data_2;
 wire  [4:0]  reg_write_dest;  
 wire  [31:0] reg_write_data;  
 
 // Control Unit:
 wire [31:0] sign_ext_im, read_data2, zero_ext_im, imm_ext;  
 wire JRControl;  
 wire [2:0] ALU_Control;  
 wire [31:0] ALU_out;
 wire[1:0] alu_op;
 wire reg_dst,mem_to_reg,jump,branch,mem_read,mem_write,alu_src,reg_write,beq_control; 
 wire zero_flag;  
 wire signed[31:0] im_shift_1, PC_j, PC_beq, PC_4beq,PC_4beqj,PC_jr;  
 wire [27:0] jump_shift_1;  
 wire [31:0] mem_read_data;  
 wire [31:0] no_sign_ext;  
 wire sign_or_zero;  
 
 //-----------------------------------------------------------------------------------------------//
 
 // Program Counter (PC)  
 
 initial begin
  pc_current <= 32'd0;
 end
 
 always @(posedge clk or posedge reset)  
	 begin   
			if(reset)   
				  pc_current <= 32'd0;  
			else  
				  pc_current <= pc_next;  
	 end 
	 
	 
 // PC + 1   
 assign pc1 = pc_current + 32'd1; 
 
 // instruction memory  
 instr_mem instrucion_memory(.pc(pc_current),.instruction(instr));  
 
 // jump shift left 1  
 assign jump_shift_1 = {instr[25:0],2'b00}; 
 
 // control unit  
 control control_unit(.reset(reset),
							 .opcode(instr[31:26]),
							 .reg_dst(reg_dst),
							 .mem_to_reg(mem_to_reg),
							 .alu_op(alu_op),
							 .jump(jump),
							 .branch(branch),
							 .mem_read(mem_read),  
							 .mem_write(mem_write),
							 .alu_src(alu_src),
							 .reg_write(reg_write),
							 .sign_or_zero(sign_or_zero));  
 
 
 // multiplexer regdest  
 assign reg_write_dest = (reg_dst==1'b0) ? instr[20:16]:  instr[15:11];  
 
 // register file  
 assign reg_read_addr_1 = instr[25:21];  
 assign reg_read_addr_2 = instr[20:16];  
 register_file reg_file(.clk(clk),
								.reset(reset),
								.reg_write_en(reg_write),  
								.reg_write_dest(reg_write_dest),  
								.reg_write_data(reg_write_data),  
								.reg_read_addr_1(reg_read_addr_1),  
								.reg_read_data_1(reg_read_data_1),  
								.reg_read_addr_2(reg_read_addr_2),  
								.reg_read_data_2(reg_read_data_2)); 
   
 // sign extend  
 assign sign_ext_im = {{16{instr[15]}},instr[15:0]};  
 assign zero_ext_im = {{16{1'b0}},instr[15:0]};  
 assign imm_ext = (sign_or_zero==1'b1) ? sign_ext_im : zero_ext_im;  
 
 // JR control  
 JR_Control JRControl_unit(.alu_op(alu_op),
									.funct(instr[5:0]),
									.JRControl(JRControl));  
 
 // ALU Control Unit  
 ALUControl ALU_Control_unit(.ALUOp(alu_op),
									  .Function(instr[5:0]),
									  .ALU_Control(ALU_Control)); 
 
 // Multiplexer Alu_Src  
 assign read_data2 = (alu_src==1'b1) ? imm_ext : reg_read_data_2;  
 
 // ALU   
 alu alu_unit(.a(reg_read_data_1),
				  .b(read_data2),
				  .alu_control(ALU_Control),
				  .result(ALU_out),
				  .zero(zero_flag));  
 
 // Branch Shift - immediate shift 1  
 assign im_shift_1 = {imm_ext[29:0],2'b00};
 
 //  
 assign no_sign_ext = ~(im_shift_1) + 1'b1;
 
 // PC beq add  
 assign PC_beq = (im_shift_1[31] == 1'b1) ? (pc1 - no_sign_ext): (pc1 +im_shift_1);  
 
 // beq control  
 assign beq_control = branch & zero_flag;  
 
 // PC_beq  
 assign PC_4beq = (beq_control==1'b1) ? PC_beq : pc1;
 
 // PC_j  
 assign PC_j = {pc1[31:28],jump_shift_1};
 
 // PC_4beqj  
 assign PC_4beqj = (jump == 1'b1) ? PC_j : PC_4beq;  
 
 // PC_jr  
 assign PC_jr = reg_read_data_1;  
 
 // PC_next  
 assign pc_next = (JRControl==1'b1) ? PC_jr : PC_4beqj;  
 
 // data memory  
 data_memory datamem(.clk(clk),
							.mem_access_addr(ALU_out),  
							.mem_write_data(reg_read_data_2),
							.mem_write_en(mem_write),
							.mem_read(mem_read),  
							.mem_read_data(mem_read_data));  

 // write back  
 assign reg_write_data = (mem_to_reg == 1'b1) ? mem_read_data : ALU_out;  
 
 
 //-----------------------------------------------------------------------------------------//
 
 // Final Outputs:  
 assign PC = pc_current; 						//PC 
 assign Instruction = instr;					//Instruction
 
 assign RegRead_1 = reg_read_addr_1;		//Register Read 1
 assign RegRead_2 = reg_read_addr_2;		//Register Read 2
 
 assign Immediate = instr[15:0];
 
 assign RegData_1 = reg_read_data_1;		//Register Data 1
 assign RegData_2 = reg_read_data_2;		//Register Data 2
 
 assign ALU_Result = ALU_out;					//ALU-Result
 
 assign RegDst = reg_dst;						// Control Signals:
 assign MemtoReg = mem_to_reg;
 assign Jump = jump;
 assign Branch = branch;
 assign MemRead = mem_read;
 assign MemWrite = mem_write;
 assign ALUOp = alu_op;
 assign AluSource = alu_src;
 assign RegWrte = reg_write;
 assign Beq = beq_control;
 
 assign Reg_Destination = reg_write_dest; 	//Reg Write 
 assign Write_Data_Value = reg_write_data;
 
 

endmodule



































