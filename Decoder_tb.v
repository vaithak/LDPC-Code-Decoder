// Testbench for LDPC_Decoder module
module Decoder_tb ();
  parameter L = 32;
  parameter K = 6;
  parameter DATA_COUNT = 3;     // L*K*K

  string inp_file_name = "inp.txt";
  string out_file_name = "out.txt";
  integer code_frames = 1;
  integer scan_faults;

  integer inp_fd;
  integer out_fd;

  reg [5-1:0] curr_data;
  reg [5-1:0] int_data[0:(L*K*K)-1];
  reg [(L*K*K)-1:0] out_data;
  initial begin
    // Taking arguments from the command line
    if ($value$plusargs("FRAMES=%0d", code_frames) | 1'b1) begin 
      $display("Number of frames = %0d", code_frames);
    end

    if ($value$plusargs("INP_FILE=%s", inp_file_name) | 1'b1) begin 
      $display("Input file = %s", inp_file_name);
    end

    if ($value$plusargs("OUT_FILE=%s", out_file_name) | 1'b1) begin 
      $display("Output file = %s", out_file_name);
    end


    // Reading data from input file
    inp_fd = $fopenr(inp_file_name);
    
    for(int frame=1; frame<=code_frames; frame=frame+1) begin
      $display("\nFrame number: %0d",frame);
      for(int i=0; i<DATA_COUNT; i=i+1) begin
        scan_faults = $fscanf(inp_fd, "%b", int_data[i]);
        $display("data: %b", int_data[i]);
      end

      // TODO: Now send data to Decoder module
    end

    $fclose(inp_fd);


    // Writing decoded data to file, assumes that the data for current frame is in 

  end

endmodule