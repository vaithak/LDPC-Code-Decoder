`include "INT_RAM.v"
`include "RAM_SP_SR_RW.v"
module IntRamTest #
(
  parameter DATA_WIDTH = 8,
  parameter ADDR_WIDTH = 8,
  parameter RAM_DEPTH  = 1 << ADDR_WIDTH
);
  //creating the clock signal
  logic clk = 1;
  always #5 clk = ~clk;

  //initialising ports
  //INPUT PORTS
  logic  [DATA_WIDTH - 1 : 0] data_in  [2 : 1]; //data input
  logic  [ADDR_WIDTH - 1 : 0] address  [2 : 1]; //address to r/w
  logic                       chip_sel [2 : 1]; //to control RAM working
  logic                       write_en [2 : 1]; //to say to read or write

  //OUTPUT PORTS
  logic  [DATA_WIDTH - 1 : 0] data_out [2 : 1]; //data output

  INT_RAM #(DATA_WIDTH, ADDR_WIDTH, RAM_DEPTH) int_ram_test
  (
    .clk(clk),
    .data_in(data_in),
    .address(address),
    .chip_sel(chip_sel),
    .write_en(write_en),

    .data_out(data_out)
  );

  initial begin
    $dumpfile("INT_RAM_test.vcd");
    $dumpvars(0,IntRamTest);

    #2; //a delay of 2 time units to give input correctly

    //writing data into the first address
    chip_sel[1] = 1'b1;
    chip_sel[2] = 1'b1;
    write_en[1] = 1'b1;
    write_en[2] = 1'b1;
    address[1]  = 8'd0;
    address[2]  = 8'd0;
    data_in[1]  = 8'd76;
    data_in[2]  = 8'd45;
    #10;

    //writing data into the second address
    address[1] = 8'd1;
    address[2] = 8'd1;
    data_in[1] = 8'd44;
    data_in[2] = 8'd35;
    #10;

    //reading from the same address in both
    write_en[1] = 1'b0;
    write_en[2] = 1'b0;
    address[1] = 8'd0;
    address[2] = 8'd0;
    #10;
    if((data_out[1] != 8'd76) && (data_out[2] != 8'd45)) begin
      $display("error data_out[1] and data_out[2] exp:%x %x act:%x %x", 8'd76, 8'd45, data_out[1], data_out[2]);
      $finish;
    end

    //reading from different address in both
    address[2] = 8'd1;
    #10;
    if((data_out[1] != 8'd76) && (data_out[2] != 8'd35)) begin
      $display("error data_out[1] and data_out[2] exp:%x %x act:%x %x", 8'd76, 8'd35, data_out[1], data_out[2]);
      $finish;
    end

    //reading from only one of them
    chip_sel[1] = 1'b1;
    chip_sel[2] = 1'b0;
    write_en[1] = 1'b0;
    address[1]  = 8'd0;
    #10;
    if(data_out[1] != 8'd76)begin
      $display("error data_out[1] exp:%x act:%x", 8'd76, data_out[1]);
      $finish;
    end

    //reading from one ram and writing to other
    chip_sel[1] = 1'b1;
    chip_sel[2] = 1'b1;
    write_en[2] = 1'b1;
    write_en[2] = 1'b0;
    address[1]  = 8'd0;
    address[2]  = 8'd1;
    data_in[1]  = 8'd78;
    #10;
    if(data_out[2] != 8'd35) begin
      $display("error data_out[2] exp:%x act:%x", 8'd35, data_out[2]);
      $finish;
    end

    //reading from the changed address
    chip_sel[2] = 1'b0;
    write_en[1] = 1'b0;
    #10;
    if (data_out[1] != 8'd78) begin
      $display("error data_out[1] exp:%x act:%x", 8'd78, data_out[1]);
      $finish;
    end

    //if everything is passed display that
    $display("PASSED!!!");
    $finish;
  end
endmodule
