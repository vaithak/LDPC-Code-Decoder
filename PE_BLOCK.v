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

  input  logic                     enable,            //enable pin

  output logic                     enable_cnu,        // CNU enable pin

  input  logic                     pe_select,         //PE_Block select line               

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

//------------Intrinsic RAM-----------------
logic [ADDR_WIDTH-1:0]    int_add      [0:1];               //addresses for Intrinsic RAMs (INT_RAM)
logic [MESSAGE_WIDTH-1:0] int_data_in  [0:1];               //data input for INT_RAMs  
logic                     int_we       [0:1];               //write enable for INT_RAMs
logic                     int_cs       [0:1];               //chip select for INT_RAMs   
logic [MESSAGE_WIDTH-1:0] int_data_out [0:1];               //data output for INT_RAMs

//------------Extrinsic RAM -----------------
logic [ADDR_WIDTH-1:0]    ext_add           ;               //address for Extrinsic RAM (EXT_RAM) 
logic [MESSAGE_WIDTH-1:0] ext_data_in  [0:2];               //data input for EXT_RAM  
logic                     ext_we            ;               //write enable for EXT_RAM  
logic                     ext_cs            ;               //chip select for EXT_RAM
logic [MESSAGE_WIDTH-1:0] ext_data_out [0:2];               //data output for EXT_RAM

//------------Decision RAM------------------
logic [ADDR_WIDTH-1:0]     dec_add      [0:1];              //addresses for Decision RAMs (DEC_RAM)
logic [DECISION_WIDTH-1:0] dec_data_in  [0:1];              //data input for DEC_RAMs      
logic                      dec_we       [0:1];              //write enable for DEC_RAMs
logic                      dec_cs       [0:1];              //chip select for DEC_RAMs
logic [DECISION_WIDTH-1:0] dec_data_out [0:1];              //data output for DEC_RAMs

//---------Address Generator-----------------
logic                       ag_en            ;              //enable for address generator
logic                       ag_out           ;              //output for address generator
logic                       ag_reset         ;              //reset for address generator

//-----------------VNU------------------------
logic [MESSAGE_WIDTH-1:0]   vnu_ext_in  [0:2];              //Extrinsic data input for VNU
logic [MESSAGE_WIDTH-1:0]   vnu_int_in       ;              //Intrinsic data input for VNU
logic [MESSAGE_WIDTH:0]     vnu_ext_out [0:2];              //Extrinsic data output from VNU
logic [DECISION_WIDTH-1:0]  vnu_dec_out      ;              //Decision data output from VNU
logic                       vnu_en           ;              //enable pin for VNU

//--------------Shift Registers----------------
logic [ADDR_WIDTH-1:0]      shift_add_cnu [0:CNU_DELAY-1];  //store address to write data during CNU phase after the CNU_DELAY clock cycles
logic [ADDR_WIDTH-1:0]      shift_add_vnu [0:VNU_DELAY-1];  //store address to write data during VNU phase after the VNU_DELAY clock cycles 


logic [ADDR_WIDTH-1:0]      write_add_cnu     ;             //delayed address to write data during CNU phase 
logic [ADDR_WIDTH-1:0]      write_add_vnu     ;             //delayed address to write data during VNU phase

logic                       rs        =1'b0   ;             //RAM selct to shift focus between data frames   
integer                     itr_count =0      ;             //count the number of iterations




//---------------------------------------------------------------------------
//---------------------Module Instantiation ---------------------------------
//---------------------------------------------------------------------------

INT_RAM #(MESSAGE_WIDTH,ADDR_WIDTH,RAM_DEPTH) int_ram
(
  .clk      (clk),
  .address  (int_add),
  .data_in  (int_data_in),
  .we       (int_we),
  .cs       (int_cs),
  .data_out (int_data_out)
);


genvar i;
generate
  for(i=0;i<3;i=i+1)begin
    EXT_RAM #(MESSAGE_WIDTH+1,ADDR_WIDTH,RAM_DEPTH)ext_ram_i
    (
      .clk      (clk_df),
      .address  (ext_add),
      .we       (ext_we),
      .cs       (ext_cs),
      .data_in  (ext_data_in[i]),
      .data_out (ext_data_out[i])
    );
  end
endgenerate


DEC_RAM #(DECISION_WIDTH,ADDR_WIDTH,RAM_DEPTH) dec_ram
(
  .clk      (clk),
  .address  (dec_add),
  .data_in  (dec_data_in),
  .we       (dec_we),
  .cs       (dec_cs),
  .data_out (dec_data_out)
);

ADDRESS_GENERATOR #(ADDR_WIDTH,COUNT_FROM) ag
(
  .clk   (clk),
  .en    (ag_en),
  .reset (ag_reset),
  .out   (ag_out)
);

VNU vnu
(
  .X             (vnu_ext_in),
  .Z             (vnu_int_in),
  .clk           (clk),
  .Y             (vnu_ext_out),
  .hard_decision (vnu_dec_out),
  .en            (vnu_en)
);



//---------------------------------------------------------------------------
//---------------------Intrinsic Data Frame Loading--------------------------
//---------------------------------------------------------------------------
assign load_add_out=load_add_in; 
assign int_out=int_in;

always @(negedge clk) begin
  if(pe_select) begin
    int_data_in[!rs]=int_in;
    int_add[!rs]=load_add_in;
    int_we[!rs]=1'b1;
    int_cs[!rs]=1'b1;
  end
end


//-----------------------------------------------------------------------------
//-----------------------Hard Decision Frame Reading---------------------------
//-----------------------------------------------------------------------------
always @(negedge clk) begin
  dec_add[!rs]=read_add_in;
  dec_we[!rs]=1'b0;
  dec_cs[!rs]=1'b1;
end

always @(posedge clk)begin
  dec_out={dec_in[K:Y],dec_data_out[!rs],dec_in[Y-2:0]};
  read_add_out=read_add_in;
end


//------------------------------------------------------------------------------
//-----------------------Initializing PE_Block----------------------------------
//------------------------------------------------------------------------------
always @(enable) begin
  ag_en=1'b1;

  if(enable) begin
    ag_reset=1'b0;
    enable_cnu=1'b1;
  end
  else begin
    ag_reset=1'b1;
    enable_cnu=1'bz;
  end
end


//----------------------------------------------------------------------------
//-------------------------------CNU Phase------------------------------------
//----------------------------------------------------------------------------

//------------Setting up EXT_RAM for writing data from the CNU----------------
always @(negedge clk_df) begin
  if(clk && enable && enable_cnu) begin
    ext_add=write_add_cnu;
    ext_we=1'b1;
    ext_cs=1'b1;
    ext_data_in=cnu_data_in;
  end
end

//------------Setting up EXT_RAM for reading data to send to the CNU-------------
always @(negedge clk_df) begin
  if(!clk && enable && enable_cnu) begin
    ext_add=read_add_cnu;
    ext_we=1'b0;
    ext_cs=1'b1;
  end
end

//------------Setting up DEC_RAM for reading data to send to the CNU-------------
always @(negedge clk_df) begin
  if(!clk && enable && enable_cnu) begin
  dec_add[rs]=read_add_cnu;
  dec_we[rs]=1'b0;
  dec_cs[rs]=1'b1;
  end
end

//------------Writing data from the EXT_RAM and DEC_RAM to the CNU----------------
always @(posedge clk) begin
  if(enable && enable_cnu) begin
    cnu_data_out = { dec_data_out, ext_data_out };
  end
end

//------------Delaying the address for writing data by CNU_DELAY-------------------
always @(posedge clk) begin
  if(enable && enable_cnu) begin
    if((shift_add_cnu[0]== COUNT_FROM-1) ||
       (shift_add_cnu[1]== COUNT_FROM-1) ||
       (shift_add_cnu[2]== COUNT_FROM-1) ||
       (shift_add_cnu[3]== COUNT_FROM-1) ||
       (shift_add_cnu[4]== COUNT_FROM-1) )begin
        read_add_cnu= 5'bz;
    end

    else begin
      read_add_cnu=ag_out;
    end

    shift_add_cnu[0]<=read_add_cnu;
    shift_add_cnu[1]<=shift_add_cnu[0];
    shift_add_cnu[2]<=shift_add_cnu[1];
    shift_add_cnu[3]<=shift_add_cnu[2];
    shift_add_cnu[4]<=shift_add_cnu[3];
    write_add_cnu   <=shift_add_cnu[4];
  end
end


//---------------------------------------------------------------------------------
//------------------------------VNU Phase------------------------------------------
//---------------------------------------------------------------------------------

//------------Setting up EXT_RAM for writing data from the VNU----------------
always @(negedge clk_df) begin
  if(clk && enable && !enable_cnu) begin
    ext_add=write_add_vnu;
    ext_we=1'b1;
    ext_cs=1'b1;
    ext_data_in=vnu_ext_out[5:0];
  end
end

//------------Setting up EXT_RAM for reading data to send to the VNU-------------
always @(negedge clk_df) begin
  if(!clk && enable && !enable_cnu) begin
    ext_add=read_add_vnu;
    ext_we=1'b0;
    ext_cs=1'b1;
  end
end

//------------Setting up DEC_RAM for writing data from the VNU--------------------
always @(negedge clk_df) begin
  if(clk && enable && !enable_cnu) begin
    dec_add[rs]=write_add_vnu;
    dec_we[rs]=1'b1;
    dec_cs[rs]=1'b1;
    dec_data_in[rs]=vnu_dec_out;
  end
end

//------------Setting up INT_RAM for reading data to send to the VNU----------------
always @(negedge clk_df) begin
  if(!clk && enable && !enable_cnu) begin
    int_add[rs]=read_add_vnu;
    int_we[rs]=1'b0;
    int_cs[rs]=1'b1;
  end
end

//------------Writing data from the EXT_RAM and INT_RAM to the VNU----------------
always @(posedge clk) begin
  if(enable && !enable_cnu) begin
    vnu_int_in=int_data_out[rs];
    vnu_ext_in=ext_data_out;
  end
end

//------------Delaying the address for writing data by VNU_DELAY---------------
always @(posedge clk) begin
  if(enable && !enable_cnu) begin
    if((shift_add_vnu[0]== COUNT_FROM-1) ||
       (shift_add_vnu[1]== COUNT_FROM-1) ||
       (shift_add_vnu[2]== COUNT_FROM-1) )begin
        read_add_vnu= 5'bz;
    end

    else begin
      read_add_vnu=ag_out;
    end

    shift_add_vnu[0]<=read_add_vnu;
    shift_add_vnu[1]<=shift_add_vnu[0];
    shift_add_vnu[2]<=shift_add_vnu[1];
    write_add_vnu   <=shift_add_vnu[2];
  end
end


//-------------------------------------------------------------------------------------
//-----------------------Flipping between CNU phase and VNU phase----------------------
//-------------------------------------------------------------------------------------
always @(ag_out) begin
  if(ag_out== COUNT_FROM-1) begin
    if(enable_cnu) begin
      repeat(CNU_DELAY)
      @(posedge clk);
      vnu_en=1'b1;
    end

    else begin
      repeat(VNU_DELAY)
      @(posedge clk);
      vnu_en=1'b0;
    end

    ag_reset=1'b1;
    @(posedge clk);
    ag_reset=1'b0;
    enable_cnu= ~enable_cnu;
  end
end


//-----------------------------------------------------------------------------------------
//--------------------------Flipping focus on data frames----------------------------------
//-----------------------------------------------------------------------------------------
always @(enable_cnu) begin
  itr_count=itr_count+1;
  
  if(itr_count==36)
  rs= ~rs;

end


endmodule
