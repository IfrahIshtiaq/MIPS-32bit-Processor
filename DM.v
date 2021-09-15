module data_memory(
    input clk,
    input [31:0] mem_access_addr, //read/write address
    input [31:0] mem_write_data,
    input mem_write_en,
    input mem_read,
    output [31:0] mem_read_data
    );
	
	integer i;  
      reg [31:0] dram [255:0];  
      //wire [7 : 0] dram_addr = mem_access_addr[8 : 1];  
      initial begin  
           for(i=0;i<256;i=i+1)  
                dram[i] <= 32'd0;  
      end  
      always @(posedge clk) begin  
           if (mem_write_en)  
                dram[mem_access_addr] <= mem_write_data;  
      end  
      assign mem_read_data = (mem_read==1'b1) ? dram[mem_access_addr]: 32'd0;

endmodule