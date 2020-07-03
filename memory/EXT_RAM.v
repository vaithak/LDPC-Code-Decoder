/* DESIGN NAME : EXT_RAM
   FILE NAME : EXT_RAM.v
   FUNCTION : STORING EXTRINSIC MESSAGES*/
module EXT_RAM #
(
  parameter DATA_WIDTH = 8,
  parameter ADDR_WIDTH = 8,
  parameter RAM_DEPTH  = 1 << ADDR_WIDTH
)
(
  input logic                       clk,     //clock input
  input logic  [ADDR_WIDTH - 1 : 0] address, //address
  input logic  [DATA_WIDTH - 1 : 0] data_in, //input data
  input logic                       chip_sel,//chip select
  input logic                       write_en,//write enable

  output logic [DATA_WIDTH - 1 : 0] data_out //output data
);
  RAM_SP_SR_RW #(DATA_WIDTH, ADDR_WIDTH, RAM_DEPTH) ext_ram
  (
    .clk      (clk),
    .address  (address),
    .data_in  (data_in),
    .chip_sel (chip_sel),
    .write_en (write_en),

    .data_out (data_out)
  );
endmodule
