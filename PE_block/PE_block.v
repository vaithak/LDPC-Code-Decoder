//----------------------------------------------------------------------------------
// Design Name : PE_BLOCK
// File Name  : PE_BLOCK.v
// Function  : PE Memory Block for storing all information and performing VNU phase
//-----------------------------------------------------------------------------------
module PE_BLOCK 
#(
  parameter L=32,
  parameter K=6,
  parameter X=1,
  parameter Y=1,
  parameter ADDR_WIDTH=5,
  parameter RAM_DEPTH=1<<ADDR_WIDTH,
  parameter COUNT_FROM=0,
  parameter VNU_DELAY=3,
  parameter CNU_DELAY=5,
  parameter MESSAGE_WIDTH=5,
  parameter DECISION_WIDTH=1
)
(
  input  logic                     clk,               //clock
  input  logic                     clk_df,            //clock double frequency
  output logic                     enable_cnu,        // CNU enable pin
  input  logic                     pe_select,         //PE_Block select line
  input  logic                     rs,                //RAM select                   
  input  logic [ADDR_WIDTH-1:0]    read_add_in,       //read address input for reading hard decision 
  output logic [ADDR_WIDTH-1:0]    read_add_out,      //read address output for reading hard decision
  input  logic [ADDR_WIDTH-1:0]    load_add_in,       //load address input for storing intrinsic data
  output logic [ADDR_WIDTH-1:0]    load_add_out,      //load address output for storing intrinsic data
  input  logic [K-1:0]             dec_in,            //hard decision input from previous block
  output logic [K-1:0]             dec_out,           //hard decision output to next block
  input  logic [MESSAGE_WIDTH-1:0] int_in,            //intrinsic message input from previous block
  output logic [MESSAGE_WIDTH-1:0] int_out,           //intrinsic message output to next block
  input  logic [MESSAGE_WIDTH-1:0] cnu_data_in [0:2], //input extrinsic messages from CNU
  output logic [MESSAGE_WIDTH:0]   cnu_data_out [0:2] //output extrinsic messages to CNU
);

endmodule : PE_BLOCK