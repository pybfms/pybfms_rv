/****************************************************************************
 * rv_data_out_bfm.sv
 ****************************************************************************/

/**
 * Module: rv_data_out_bfm
 * 
 * TODO: Add module documentation
 */
module rv_data_out_bfm #(
		parameter DATA_WIDTH = 8
		) (
			input						clock,
			input						reset,
			output reg[DATA_WIDTH-1:0]	data,
			output reg					data_valid,
			input						data_ready
		);
	
	reg[DATA_WIDTH-1:0]		data_v = 0;
	reg						data_valid_v = 0;
	
	initial begin
		if (DATA_WIDTH > 64) begin
			$display("Error: rv_data_out_bfm %m -- DATA_WIDTH>64 (%0d)", DATA_WIDTH);
			$finish();
		end
	end
	
	always @(posedge clock) begin
		if (reset) begin
			data_valid <= 0;
			data <= 0;
		end else begin
			data_valid <= data_valid_v;
			data <= data_v;
			if (data_valid && data_ready) begin
				write_ack();
				data_valid_v = 0;
			end
		end
	end
	
	task write_req(reg[63:0] d);
		begin
			data_v = d;
			data_valid_v = 1;
		end
	endtask

	// Auto-generated code to implement the BFM API
${cocotb_bfm_api_impl}

endmodule
