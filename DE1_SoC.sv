// Top-level module that defines the I/Os for the DE1 SoC board
module DE1_SoC (HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, KEY, LEDR, SW);
	output logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5; 
	output logic [9:0] LEDR; input logic [3:0] KEY; 
	input logic [9:0] SW; 
	
	// Default values, turns off the HEX displays
	assign HEX0 = 7'b1111111; 
	assign HEX1 = 7'b1111111; 
	assign HEX2 = 7'b1111111; 
	assign HEX3 = 7'b1111111; 
	assign HEX4 = 7'b1111111; 
	assign HEX5 = 7'b1111111; 
	
	// Summary:
	// 1. Circuit will light a 'Discounted' LED for discounted UPCs.
	// 2. Circuit will light a 'Stolen' LED when an expensive item is returned without its secret mark.
	
	logic U, P, C, M;
	assign {U, P, C} = SW[9:7];
	assign {M} = SW[0];
	
	assign LEDR[0] = P|| (U && C);
	assign LEDR[1] = (~P && ~C && ~M) || (U && ~P && ~M);
	
	
endmodule 

module DE1_SoC_testbench();
	logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	logic [9:0] LEDR;
	logic [3:0] KEY; 
	logic [9:0] SW; 
	
	DE1_SoC dut (.HEX0, .HEX1, .HEX2, .HEX3, .HEX4, .HEX5, .KEY, .LEDR, .SW); 
	
		// Try all combinations of inputs. 
		integer i;
		initial begin
			SW[6:1] = 1'b0;
			// SW[8] = 1'b0;
			for(i = 0; i <256; i++) begin
				SW[9:7] = i; #10;
				SW[0] = i; #10;
			end
		end
endmodule