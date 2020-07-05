
module single_port_sync_ram 
  # (parameter ADDR_WIDTH = 4,
     parameter DATA_WIDTH = 32,
     parameter DEPTH = 16 
    )
  
  ( 	input 					clk,
   		input [ADDR_WIDTH-1:0]	addr,
   		inout [DATA_WIDTH-1:0]	data,
   		input 					cs,
   		input 					we,
   		input 					oe
  );
  
  reg [DATA_WIDTH-1:0] 	tmp_data;
  reg [DATA_WIDTH-1:0] 	mem [DEPTH:0];
  
  always @ (posedge clk) begin
    if (cs & we)
      mem[addr] <= data;
  end
  
  always @ (posedge clk) begin
    if (cs & !we)
    	tmp_data <= mem[addr];
  end
  
  assign data = cs & oe & !we ? tmp_data : 'hz;
endmodule
  