//---------------------------------------------
// Test Bench #1 for PE_BLOCK
// This Test-Bench firstly initializes the EXT_RAM
// with data and then randomly reads data 
//---------------------------------------------

`include "../PE_BLOCK.v"
`include "../RAM_SP_SR_RW.v"
`include "../INT_RAM.v"
`include "../EXT_RAM.v"
`include "../DEC_RAM.v" 

module PE_TB1
#(
  parameter MESSAGE_WIDTH = 5 ,
  parameter DECISION_WIDTH = 1,
  parameter ADDR_WIDTH = 8 ,
  parameter RAM_DEPTH  = 1 << ADDR_WIDTH
);

  logic                  clk   ; // Clock Input
  logic [ADDR_WIDTH-1:0] address ; // Address Input

  //-------------Extrinsic RAM Ports----------------------------
  logic                     ext_we             ; // Write Enable
  logic                     ext_cs             ; // Chip select
  logic [MESSAGE_WIDTH-1:0] ext_data_in  [0:2] ; // Data Input
   wire [MESSAGE_WIDTH-1:0] ext_data_out [0:2] ; // Data Output

  //-------------Intrinsic RAM Ports-----------------------------
  logic                     int_we       [0:1] ; // Write Enable
  logic                     int_cs       [0:1] ; // Chip select
  logic                     int_rs             ; // RAM Select
  logic [MESSAGE_WIDTH-1:0] int_data_in  [0:1] ; // Data Input
   wire [MESSAGE_WIDTH-1:0] int_data_out [0:1] ; // Data Output

  //--------------Decision RAM Ports------------------------------
  logic                      dec_we       [0:1] ; // Write Enable
  logic                      dec_cs       [0:1] ; // Chip select 
  logic                      dec_rs             ; // RAM Select 
  logic [DECISION_WIDTH-1:0] dec_data_in  [0:1] ; // Data Input
   wire [DECISION_WIDTH-1:0] dec_data_out [0:1] ; // Data Output

  integer                    i                  ; // loop variable
  integer                    j                  ; // loop variable
  integer                    k                  ; // loop variable
  integer                    seed               ; // seed for random 

  PE_BLOCK #(MESSAGE_WIDTH, DECISION_WIDTH, ADDR_WIDTH, RAM_DEPTH) pe_block
  (
    .clk            (clk),
    .address        (address),

    .ext_we         (ext_we),
    .ext_cs         (ext_cs),
    .ext_data_in    (ext_data_in),
    .ext_data_out   (ext_data_out),

    .int_we         (int_we),
    .int_cs         (int_cs),
    .int_rs         (int_rs),
    .int_data_in    (int_data_in),
    .int_data_out   (int_data_out),

    .dec_we         (dec_we),
    .dec_cs         (dec_cs),
    .dec_rs         (dec_rs),
    .dec_data_in    (dec_data_in),
    .dec_data_out   (dec_data_out)
  );



  //-----------------------------------
  // Clock generation
  //-----------------------------------
  initial begin
    clk=0;
  end

  always begin 
    #5 clk= ~clk;
  end



  //-----------------------------------
  // Dump waveform
  //-----------------------------------
  initial begin
    $dumpfile("PE_TB2.vcd");
    $dumpvars;
  end



  //-----------------------------------
  // Initialize RAM with Data
  //-----------------------------------
  initial begin
    seed=1;
    dec_rs=1'b0;
    int_rs=1'b0;

    for(k=0;k<2;k=k+1) begin

      $display("Iteration %d",k);
      #3 for(i=0;i<RAM_DEPTH;i=i+1) begin
        int_data_in[int_rs]=i;
        address=i;
        int_we[int_rs]=1; 
        int_cs[int_rs]=1;
        #10 int_we[int_rs]=0; int_cs[int_rs]=0;
      end    

      for(i=0;i<RAM_DEPTH;i=i+1) begin
        int_data_in[!int_rs]=i;
        address=i;
        int_we[!int_rs]=1; 
        int_cs[!int_rs]=1;

        dec_data_in[dec_rs]=i;
        dec_we[dec_rs]=1;
        dec_cs[dec_rs]=1;

        #10 int_we[!int_rs]=0; int_cs[!int_rs]=0;
        dec_we[dec_rs]=1; dec_cs[dec_rs]=1;
      end    
  
      repeat(20) begin
        repeat(1) @(posedge clk);
        address=$random(seed) % RAM_DEPTH;
        int_we[int_rs]=0;
        int_cs[int_rs]=1;
  
        #2 if(int_data_out[int_rs]==address) begin
        $display("Correct \t Address:%d\tData:%d\t",address,int_data_out[int_rs]);
        end
        else begin
          $display("Correct \t Address:%d\tData:%d\t",address,int_data_out[int_rs]);
        end
      end
      
      int_rs=!int_rs;
      dec_rs=!dec_rs;
    end

  $display("Decision RAM verification");
  repeat(20) begin
    repeat(1) @(posedge clk);
    address=$random(seed) % RAM_DEPTH;
    dec_we[!dec_rs]=0;
    dec_cs[!dec_rs]=1;

    #2 if(dec_data_out[!dec_rs]==address) begin
    $display("Correct \t Address:%d\tData:%d\t ",address,dec_data_out[!dec_rs]);
    end
    else begin
      $display("Correct \t Address:%d\tData:%d\t",address,dec_data_out[!dec_rs]);
    end
  end

    
    #5 $finish;

  end



endmodule
