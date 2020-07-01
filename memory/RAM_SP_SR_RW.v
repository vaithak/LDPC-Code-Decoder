//-----------------------------------------------------
// Design Name : RAM_SP_SR_RW
// File Name  : RAM_SP_SR_RW.v
// Function  : Single port Synchronous read and write RAM
//-----------------------------------------------------
module RAM_SP_SR_RW #(
  parameter DATA_WIDTH = 8 ,
  parameter ADDR_WIDTH = 8 ,
  parameter RAM_DEPTH = 1 << ADDR_WIDTH
)
(
  input  logic                      clk,      // Clock Input
  input  logic [ADDR_WIDTH - 1 : 0] address,  // Address Input
  input  logic [DATA_WIDTH - 1 : 0] data_in,  // Data Input
  input  logic                      write_en, // Write Enable
  input  logic                      chip_sel, // Chip select

  output logic [DATA_WIDTH - 1 : 0] data_out  // Data Output
);
  //memory with width of DATA_WIDTH and depth of RAM_DEPTH
  logic [DATA_WIDTH - 1 : 0] mem [RAM_DEPTH - 1 : 0];

  always @ (posedge clk) begin
    if(write_en && chip_sel) begin      //writing data
      mem[address] <= data_in;
    end
    else if(~write_en && chip_sel) begin//reading data
      data_out <= mem[address];
    end
  end
endmodule
