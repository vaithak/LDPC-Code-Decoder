/*NAME OF DEVICE:INTRINSIC RAM
  FUNCTION OF DEVICE:STORE INTRINSIC MESSAGES
  FILE NAME:INT_RAM.v*/

module INT_RAM #
(
  parameter DATA_WIDTH = 8,
  parameter ADDR_WIDTH = 8,
  parameter RAM_DEPTH = 1 << ADDR_WIDTH
)
(
  input logic                       clk, //clock input
  input logic  [ADDR_WIDTH - 1 : 0] data_in  [2 : 1], //data input
  input logic  [ADDR_WIDTH - 1 : 0] address  [2 : 1], //address to r/w
  input logic                       chip_sel [2 : 1], //to control RAM working
  input logic                       write_en [2 : 1], //to say to read or write

  output logic [ADDR_WIDTH - 1 : 0] data_out [2 : 1] //data output
);
  //there are two frames in INT_RAM one for the current
  //frame and the other for the next frame
  //therefore we are using two RAM instances here
  RAM_SP_SR_RW #(DATA_WIDTH, ADDR_WIDTH, RAM_DEPTH) int_ram_frame_one
  (
    .clk      (clk),
    .data_in  (data_in[1]),
    .address  (address[1]),
    .chip_sel (chip_sel[1]),
    .write_en (write_en[1]),

    .data_out (data_out[1])
  );

  RAM_SP_SR_RW #(DATA_WIDTH, ADDR_WIDTH, RAM_DEPTH) int_ram_frame_two
  (
    .clk      (clk),
    .data_in  (data_in[2]),
    .address  (address[2]),
    .chip_sel (chip_sel[2]),
    .write_en (write_en[2]),

    .data_out (data_out[2])
  );
endmodule
