`timescale 1ns / 1ps
`define NULL 0



// Coder:	joe
// Description:
//	4 input 4output BPU
//  
//  
//
//  
//
module eebpu6X6
	#(
		parameter DATA_WIDTH = 8,
		parameter STAGE_NUMBER = 2,
		parameter NUM_QUEUES = 4
	) (
		input clk,
		input rst,
		
		//////////////////////////////////////////////////0
		input input_wire,
		input input_new_packet,
		input [DATA_WIDTH-1:0]			input_data,
		//////////////////////////////////////////////////
		//////////////////////////////////////////////////0

		output reg output_wire,
		output reg [DATA_WIDTH-1:0]			output_data
		//////////////////////////////////////////////////
		
		
	);
	wire [NUM_QUEUES-1:0] in_valid_2c;
	wire [NUM_QUEUES-1:0] newpkt_2c;
	wire [DATA_WIDTH-1:0]	in_data_2c [0:NUM_QUEUES-1];
	wire [DATA_WIDTH-1:0]	out_data_2out [0:NUM_QUEUES-1];
	
	wire [NUM_QUEUES-1:0] out_wire_2out;
	
	wire [NUM_QUEUES-1:0] in_v_2arb0;
	wire [NUM_QUEUES-1:0] in_v_2arb1;
	wire [NUM_QUEUES-1:0] in_v_2arb2;
	wire [NUM_QUEUES-1:0] in_v_2arb3;
	
	wire [NUM_QUEUES-1:0] in_new_2arb0;
	wire [NUM_QUEUES-1:0] in_new_2arb1;
	wire [NUM_QUEUES-1:0] in_new_2arb2;
	wire [NUM_QUEUES-1:0] in_new_2arb3;

	wire [DATA_WIDTH-1:0]	in_data_2arb0 [0:NUM_QUEUES-1];
	wire [DATA_WIDTH-1:0]	in_data_2arb1 [0:NUM_QUEUES-1];
	wire [DATA_WIDTH-1:0]	in_data_2arb2 [0:NUM_QUEUES-1];
	wire [DATA_WIDTH-1:0]	in_data_2arb3 [0:NUM_QUEUES-1];

	wire [NUM_QUEUES-1:0] next_out_wr0;
	wire [NUM_QUEUES-1:0] next_out_wr1;
	wire [NUM_QUEUES-1:0] next_out_wr2;
	wire [NUM_QUEUES-1:0] next_out_wr3;
	
	wire [DATA_WIDTH-1:0]	next_out_data0 [0:NUM_QUEUES-1];
	wire [DATA_WIDTH-1:0]	next_out_data1 [0:NUM_QUEUES-1];
	wire [DATA_WIDTH-1:0]	next_out_data2 [0:NUM_QUEUES-1];
	wire [DATA_WIDTH-1:0]	next_out_data3 [0:NUM_QUEUES-1];

	wire [0:NUM_QUEUES-1]	out_wr0_2selec;
    wire [32-1:0]	out_ctl0_2selec [0:NUM_QUEUES-1];
    wire [32-1:0]	out_ctl_c2a [0:NUM_QUEUES-1];
    wire [480-1:0]	out_data0_2selec [0:NUM_QUEUES-1];
    wire [480-1:0]	out_wr_c2a [0:NUM_QUEUES-1];
    
    wire [0:NUM_QUEUES-1]	select_out_wr;
    wire [32-1:0]	select_out_ctl [0:NUM_QUEUES-1];
    wire [480-1:0]	select_out_data [0:NUM_QUEUES-1];
    
    wire [NUM_QUEUES-1:0]			crossbar_out_wr;
	wire [32-1:0]			crossbar_out_ctl [NUM_QUEUES-1:0];
	wire [480-1:0]			crossbar_out_data [NUM_QUEUES-1:0];
	
	wire [NUM_QUEUES-1:0]			lookup_out_wr;
	wire [32-1:0]			lookup_out_ctl [NUM_QUEUES-1:0];
	wire [480-1:0]			lookup_out_data [NUM_QUEUES-1:0];
    wire [480-1:0]			out_data_c2a [NUM_QUEUES-1:0];

	reg [7:0] input_sel;

	always @(posedge clk or negedge rst)begin
		if(!rst)begin
			input_sel <= 0;
		end else begin
			input_sel <= input_sel + 1;
		end

	end






	assign in_valid_2c[0] = (input_sel == 0)?input_wire:0;
	assign in_valid_2c[1] = (input_sel == 1)?input_wire:0;
	assign in_valid_2c[2] = (input_sel == 2)?input_wire:0;
	assign in_valid_2c[3] = (input_sel == 3)?input_wire:0;



	assign newpkt_2c[0] = (input_sel == 0)?input_new_packet:0;
	assign newpkt_2c[1] = (input_sel == 1)?input_new_packet:0;
	assign newpkt_2c[2] = (input_sel == 2)?input_new_packet:0;
	assign newpkt_2c[3] = (input_sel == 3)?input_new_packet:0;


	assign in_data_2c[0] = (input_sel == 0)?input_data:0;
	assign in_data_2c[1] = (input_sel == 1)?input_data:0;
	assign in_data_2c[2] = (input_sel == 2)?input_data:0;
	assign in_data_2c[3] = (input_sel == 3)?input_data:0;




	always @(*)begin
	  if (input_sel == 0)begin
		output_wire = out_wire_2out[0];
		output_data = out_data_2out[0];
	  end else if (input_sel == 1)begin
		output_wire = out_wire_2out[1];
		output_data = out_data_2out[1];
	  end else if (input_sel == 2)begin
		output_wire = out_wire_2out[2];
		output_data = out_data_2out[2];
	  end else if (input_sel == 3)begin
		output_wire = out_wire_2out[3];
		output_data = out_data_2out[3];
	  end 
	end

    generate
    genvar int8to512;
    for(int8to512=0; int8to512<NUM_QUEUES; int8to512=int8to512+1) begin: in8_512
        c8to512
		#()
		c8to512_inst(
			.clk(clk),
            .rst(rst),
            .data_in(in_data_2c[int8to512]),
            .datavalid(in_valid_2c[int8to512]),
            .newpkt(newpkt_2c[int8to512]),
            .out_wr(out_wr_c2a[int8to512]),
            .out_ctl(out_ctl_c2a[int8to512]),
            .out_data(out_data_c2a[int8to512])
		);
    end
    endgenerate





	generate
	genvar isel;
	for(isel=0; isel<NUM_QUEUES; isel=isel+1) begin: selector_q
		selector
			#()
		selectors
			(
			.clk(clk),
			.rst(rst),
			.datavalid(out_wr_c2a[isel]),
			.in_ctl(out_ctl_c2a[isel]),
			.in_data(out_data_c2a[isel]),
			.out_wr(select_out_wr[isel]),
			.out_ctl(select_out_ctl[isel]),
			.out_data(select_out_data[isel]));
	end 
	endgenerate


	crossbar #() crossbar0(
		.clk(clk),
		.rst(rst),
		
		
		.datavalid0(select_out_wr[0]),
		.in_ctl0(select_out_ctl[0]),
		.in_data0(select_out_data[0]),
		.datavalid1(select_out_wr[1]), 
		.in_ctl1(select_out_ctl[1]),
		.in_data1(select_out_data[1]),
		.datavalid2(select_out_wr[2]),
		.in_ctl2(select_out_ctl[2]),
		.in_data2(select_out_data[2]),
		.datavalid3(select_out_wr[3]),
		.in_ctl3(select_out_ctl[3]),
		.in_data3(select_out_data[3]),


	
		
		.out_wr0(crossbar_out_wr[0]),
		.out_ctl0(crossbar_out_ctl[0]),
		.out_data0(crossbar_out_data[0]),
		.out_wr1(crossbar_out_wr[1]),
		.out_ctl1(crossbar_out_ctl[1]),
		.out_data1(crossbar_out_data[1]),
		.out_wr2(crossbar_out_wr[2]),
		.out_ctl2(crossbar_out_ctl[2]),
		.out_data2(crossbar_out_data[2]),
		.out_wr3(crossbar_out_wr[3]),
		.out_ctl3(crossbar_out_ctl[3]),
		.out_data3(crossbar_out_data[3])
		
	);




	generate
	genvar ilookup;
	for(ilookup=0; ilookup<NUM_QUEUES; ilookup=ilookup+1) begin: lookup_q
		lookup
			#()
		lookups
			(
			.clk(clk),
			.rst(rst),
			.datavalid(crossbar_out_wr[ilookup]),
			.in_ctl(crossbar_out_ctl[ilookup]),
			.in_data(crossbar_out_data[ilookup]),
			.out_wr(lookup_out_wr[ilookup]),
			.out_ctl(lookup_out_ctl[ilookup]),
			.out_data(lookup_out_data[ilookup]));
	end 
	endgenerate



	generate
    genvar int512to8;
    for(int512to8=0; int512to8<NUM_QUEUES; int512to8=int512to8+1) begin: in512_8
        c512to8
		#()
		c512to8_inst(
			.clk(clk),
            .rst(rst),
            .in_ctl(lookup_out_ctl[int512to8]),
            .in_data(lookup_out_data[int512to8]),
            .datavalid(lookup_out_wr[int512to8]),
            .out_data(out_data_2out[int512to8]),
            .out_wr(out_wire_2out[int512to8])
		);
    end
    endgenerate










endmodule