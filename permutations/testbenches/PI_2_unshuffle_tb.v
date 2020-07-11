//testbench for  module pi_2_unshuffle_tb
/*
Here, random 6 bit number is sent as input whose value is then compared with the output
which is connected to that input according to the condition of Pi 2 unshuffle
*/
module pi_2_unshuffle_tb;
  reg [6-1 : 0] data_in [0 : 35];
  reg [6-1 : 0] data_out [0 : 35];
  reg [6-1 : 0] temp     [0 : 35];
  
  PI_2_unshuffle#(6) test(                 //parameter DATA_WIDTH is 6
    .data_in(data_in),
    .data_out(data_out));
  
    initial begin
    // Dump waves
    $dumpfile("dump.vcd");
    $dumpvars(1, test);
    
      for(int i=0;i<36;i++)begin
        data_in[i]=$random%(1<<6);       //random 6-bit number is sent as input
        temp[i]=data_in[i];              //random number is stored at index same as that of input
      end
      #10;
      
      //compare each index explicitly according to the condition that each CNU(input index (30-35),(24-29)...) is connected to PE blocks with same y index(output index (0-5), (6-11)...)
      //if any test fails then finish at that step
  if (data_out[0] != temp[30]) begin
    $display("data_in[30] not shuffled correctly");
	#10 $finish;
  end
  if (data_out[1] != temp[31]) begin
    $display("data_in[31] not shuffled correctly");
	#10 $finish;
  end
  if (data_out[2] != temp[32]) begin
    $display("data_in[32] not shuffled correctly");
	#10 $finish;
  end
  if (data_out[3] != temp[33]) begin
    $display("data_in[33] not shuffled correctly");
	#10 $finish;
  end
  if (data_out[4] != temp[34]) begin
    $display("data_in[34] not shuffled correctly");
	#10 $finish;
  end
  if (data_out[5] != temp[35]) begin
    $display("data_in[35] not shuffled correctly");
	#10 $finish;
  end
  if (data_out[6] != temp[24]) begin
    $display("data_in[24] not shuffled correctly");
	#10 $finish;
  end
  if (data_out[7] != temp[25]) begin
    $display("data_in[25] not shuffled correctly");
	#10 $finish;
  end
  if (data_out[8] != temp[26]) begin
    $display("data_in[26] not shuffled correctly");
	#10 $finish;
  end
  if (data_out[9] != temp[27]) begin
    $display("data_in[27] not shuffled correctly");
	#10 $finish;
  end
  if (data_out[10] != temp[28]) begin
    $display("data_in[28] not shuffled correctly");
	#10 $finish;
  end
  if (data_out[11] != temp[29]) begin
    $display("data_in[29] not shuffled correctly");
	#10 $finish;
  end
  if (data_out[12] != temp[18]) begin
    $display("data_in[18] not shuffled correctly");
	#10 $finish;
  end
  if (data_out[13] != temp[19]) begin
    $display("data_in[19] not shuffled correctly");
	#10 $finish;
  end
  if (data_out[14] != temp[20]) begin
    $display("data_in[20] not shuffled correctly");
	#10 $finish;
  end
  if (data_out[15] != temp[21]) begin
    $display("data_in[21] not shuffled correctly");
	#10 $finish;
  end
  if (data_out[16] != temp[22]) begin
    $display("data_in[22] not shuffled correctly");
	#10 $finish;
  end
  if (data_out[17] != temp[23]) begin
    $display("data_in[23] not shuffled correctly");
	#10 $finish;
  end
  if (data_out[18] != temp[12]) begin
    $display("data_in[12] not shuffled correctly");
	#10 $finish;
  end
  if (data_out[19] != temp[13]) begin
    $display("data_in[13] not shuffled correctly");
	#10 $finish;
  end
  if (data_out[20] != temp[14]) begin
    $display("data_in[14] not shuffled correctly");
	#10 $finish;
  end
  if (data_out[21] != temp[15]) begin
    $display("data_in[15] not shuffled correctly");
	#10 $finish;
  end
  if (data_out[22] != temp[16]) begin
    $display("data_in[16] not shuffled correctly");
	#10 $finish;
  end
  if (data_out[23] != temp[17]) begin
    $display("data_in[17] not shuffled correctly");
	#10 $finish;
  end
  if (data_out[24] != temp[6]) begin
    $display("data_in[6] not shuffled correctly");
	#10 $finish;
  end
  if (data_out[25] != temp[7]) begin
    $display("data_in[7] not shuffled correctly");
	#10 $finish;
  end
  if (data_out[26] != temp[8]) begin
    $display("data_in[8] not shuffled correctly");
	#10 $finish;
  end
  if (data_out[27] != temp[9]) begin
    $display("data_in[9] not shuffled correctly");
	#10 $finish;
  end
  if (data_out[28] != temp[10]) begin
    $display("data_in[10] not shuffled correctly");
	#10 $finish;
  end
  if (data_out[29] != temp[11]) begin
    $display("data_in[11] not shuffled correctly");
	#10 $finish;
  end
  if (data_out[30] != temp[0]) begin
    $display("data_in[0] not shuffled correctly");
	#10 $finish;
  end
  if (data_out[31] != temp[1]) begin
    $display("data_in[1] not shuffled correctly");
	#10 $finish;
  end
  if (data_out[32] != temp[2]) begin
    $display("data_in[2] not shuffled correctly");
	#10 $finish;
  end
  if (data_out[33] != temp[3]) begin
    $display("data_in[3] not shuffled correctly");
	#10 $finish;
  end
  if (data_out[34] != temp[4]) begin
    $display("data_in[4] not shuffled correctly");
	#10 $finish;
  end
  if (data_out[35] != temp[5]) begin
    $display("data_in[5] not shuffled correctly");
	#10 $finish;
  end

  $display("All tests passed.");
  #10 $finish;
  end
endmodule
