 //----------------------------------------------------------------------------------
// Design Name : INT_RAM
// File Name  : INT_RAM.v
// Function  : Single port Synchronous read and write RAMs to store Intrinsic Messages
//-----------------------------------------------------------------------------------


module INT_RAM 
#(
  parameter DATA_WIDTH = 5 ,
  parameter ADDR_WIDTH = 8 ,
  parameter RAM_DEPTH  = 1 << ADDR_WIDTH
)
(
  input  logic                  clk            , // Clock Input
  input  logic [1:0][ADDR_WIDTH-1:0] address   , // Address Input
  input  logic [1:0][DATA_WIDTH-1:0] data_in   , // Data Input
  input  logic      [1:0]            we        , // Write Enable
  input  logic      [1:0]            cs        , // Chip select
  output logic [1:0][DATA_WIDTH-1:0] data_out  , // Data Output
  input  logic                  reset    
);

  RAM_SP_SR_RW #(DATA_WIDTH, ADDR_WIDTH, RAM_DEPTH) int_ram_1
  (
    .clk      (clk),
    .data_in  (data_in  [0]),
    .data_out (data_out [0]),
    .address  (address  [0]),
    .we       (we       [0]),
    .cs       (cs       [0]),
    .reset    (reset)
  );

  RAM_SP_SR_RW #(DATA_WIDTH, ADDR_WIDTH, RAM_DEPTH) int_ram_2
  (
    .clk      (clk),
    .data_in  (data_in  [1]),
    .data_out (data_out [1]),
    .address  (address  [1]),
    .we       (we       [1]),
    .cs       (cs       [1]),
    .reset    (reset)
  );


endmodule
