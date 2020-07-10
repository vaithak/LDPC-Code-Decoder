//----------------------------------------------------------------------------------
// Design Name : DEC_RAM
// File Name  : DEC_RAM.v
//-----------------------------------------------------------------------------------

module DEC_RAM
#(
  parameter DATA_WIDTH = 1 ,
  parameter ADDR_WIDTH = 8 ,
  parameter RAM_DEPTH  = 1 << ADDR_WIDTH
)
(
  input wire [ADDR_WIDTH-1:0] address        , // Address Input
  input wire [DATA_WIDTH-1:0] data_in  [0:1] , // Data Input

  input logic [1:0] we , // Write Enable
  input logic [1:0] cs , // Chip select
  input logic clk      , // Clock Input

  output wire [DATA_WIDTH-1:0] data_out [0:1] // Data Output
);
  RAM_SP_SR_RW #(DATA_WIDTH, ADDR_WIDTH, RAM_DEPTH) dec_ram_1
  (
    .clk      (clk),
    .data_in  (data_in  [0]),
    .data_out (data_out [0]),
    .address  (address),
    .we       (we       [0]),
    .cs       (cs       [0])
  );
  RAM_SP_SR_RW #(DATA_WIDTH, ADDR_WIDTH, RAM_DEPTH) dec_ram_2
  (
    .clk      (clk),
    .data_in  (data_in  [1]),
    .data_out (data_out [1]),
    .address  (address),
    .we       (we       [1]),
    .cs       (cs       [1])
  );
endmodule
