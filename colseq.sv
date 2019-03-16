// colseq.sv - ELEX 7660 Design Project
// Determins the column of the button pressed
// Ryan Wong & Bhavik Maisuria
// 3-16-2019 (Last edited)

module colseq (input logic [3:0] kpr, output logic [3:0] kpc,
				input logic clk, reset_n); 
				
	logic [3:0] next_count;

	always_comb
		case(kpc) //this case statement pulls one column low at a time
			'b0111 : case(kpr) //this case statement checks if any of rows have been pulled to ground
						'b0111 : next_count = kpc;
						'b1011 : next_count = kpc;
						'b1101 : next_count = kpc;
						'b1110 : next_count = kpc;
						default : next_count = 'b1011; //assigns next state if no button is pressed
					endcase
					
			'b1011 : case(kpr)
						'b0111 : next_count = kpc;
						'b1011 : next_count = kpc;
						'b1101 : next_count = kpc;
						'b1110 : next_count = kpc;
						default : next_count = 'b1101;
					endcase

			'b1101 : case(kpr)
						'b0111 : next_count = kpc;
						'b1011 : next_count = kpc;
						'b1101 : next_count = kpc;
						'b1110 : next_count = kpc;
						default : next_count = 'b1110;
					endcase
					
			'b1110 : case(kpr)
						'b0111 : next_count = kpc;
						'b1011 : next_count = kpc;
						'b1101 : next_count = kpc;
						'b1110 : next_count = kpc;
						default : next_count = 'b0111;
					endcase
					
			default : next_count = 'b0111;
		endcase
	
	always_ff @(posedge clk, negedge reset_n) //flip flop logic for assigning next value of kpc
		if(!reset_n)
			kpc = 'b0111;
		else
			kpc = next_count;
			
endmodule