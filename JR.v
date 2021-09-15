module JR_Control(
    input [1:0] alu_op,
    input [5:0] funct,
    output JRControl
    );
	 
	 assign JRControl = ({alu_op,funct} == 8'b00001000) ? 1'b1 : 1'b0; // Func of Jr = 001000

endmodule