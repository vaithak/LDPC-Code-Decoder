 //----------------------------------------------------------------------------------
// Design Name : PE_BLOCK
// File Name  : PE_BLOCK.v
// Function  : PE Memory Block for storing all information 
//-----------------------------------------------------------------------------------



module PE_BLOCK 
#(
  parameter MESSAGE_WIDTH = 5 ,
  parameter DECISION_WIDTH = 1,
  parameter ADDR_WIDTH = 8 ,
  parameter RAM_DEPTH  = 1 << ADDR_WIDTH
)
(
  input  logic                  clk   , // Clock Input
  input  logic [ADDR_WIDTH-1:0] address , // Address Input

  //-------------Extrinsic RAM Ports----------------------------
  input  logic                     ext_we             , // Write Enable
  input  logic                     ext_cs             , // Chip select
  input  logic [MESSAGE_WIDTH-1:0] ext_data_in  [0:2] , // Data Input
  output  wire [MESSAGE_WIDTH-1:0] ext_data_out [0:2] , // Data Output

  //-------------Intrinsic RAM Ports-----------------------------
  input  logic                     int_we       [0:1] , // Write Enable
  input  logic                     int_cs       [0:1] , // Chip select
  input  logic                     int_rs             , // RAM Select
  input  logic [MESSAGE_WIDTH-1:0] int_data_in  [0:1] , // Data Input
  output  wire [MESSAGE_WIDTH-1:0] int_data_out [0:1] , // Data Output

  //--------------Decision RAM Ports------------------------------
  input  logic                      dec_we       [0:1] , // Write Enable
  input  logic                      dec_cs       [0:1] , // Chip select 
  input  logic                      dec_rs             , // RAM Select 
  input  logic [DECISION_WIDTH-1:0] dec_data_in  [0:1] , // Data Input
  output  wire [DECISION_WIDTH-1:0] dec_data_out [0:1]   // Data Output

);

  generate
    genvar i;
    for(i=0;i<3;i=i+1) begin
      EXT_RAM #(MESSAGE_WIDTH, ADDR_WIDTH, RAM_DEPTH) ext_ram
      (
        .clk      (clk)              ,
        .address  (address)          ,
        .we       (ext_we)           ,
        .cs       (ext_cs)           ,
        .data_in  (ext_data_in [i])  ,
        .data_out (ext_data_out [i])
      );
    end
  endgenerate

  INT_RAM #(MESSAGE_WIDTH, ADDR_WIDTH, RAM_DEPTH) int_ram
  (
    .clk      (clk),
    .data_in  (int_data_in),
    .data_out (int_data_out),
    .address  (address),
    .we       (int_we),
    .cs       (int_cs),
    .rs       (int_rs)
  );

  DEC_RAM #(DECISION_WIDTH, ADDR_WIDTH, RAM_DEPTH) dec_ram
  (
    .clk      (clk),
    .data_in  (dec_data_in),
    .data_out (dec_data_out),
    .address  (address),
    .we       (dec_we),
    .cs       (dec_cs),
    .rs       (dec_rs)
  );

  

endmodule