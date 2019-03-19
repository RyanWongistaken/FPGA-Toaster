// kpdecode.sv - ELEX 7660 Design Project
// Determines the value pressed by colseq.sv and then determines the hex value
// and then passes it on to kpcontrol. 
// Ryan Wong & Bhavik Maisuria
// 3-16-2019 (Last edited)

module kpdecode (input logic [3:0] kpr, input logic [3:0] kpc,
				output logic kphit, output logic [3:0] num); 

	always_comb
		case(kpc) //this case statement pulls one column low at a time 
			'b0111 : case(kpr) //this case statement checks if any of rows have been pulled to ground
						'b0111 : begin kphit = 1; num = 1; end //combination of row and column indicate the "1" key was pressed
						'b1011 : begin kphit = 1; num = 4; end
						'b1101 : begin kphit = 1; num = 7; end
						'b1110 : begin kphit = 1; num = 'hE; end
						default : begin kphit = 0; num = 'hF; end
					endcase
					
			'b1011 : case(kpr)
						'b0111 : begin kphit = 1; num = 2; end
						'b1011 : begin kphit = 1; num = 5; end
						'b1101 : begin kphit = 1; num = 8; end
						'b1110 : begin kphit = 1; num = 0; end
						default : begin kphit = 0; num = 'hF; end
					endcase

			'b1101 : case(kpr)
						'b0111 : begin kphit = 1; num = 3; end
						'b1011 : begin kphit = 1; num = 6; end
						'b1101 : begin kphit = 1; num = 9; end
						'b1110 : begin kphit = 1; num = 'hF; end
						default : begin kphit = 0; num = 'hF; end
					endcase
					
			'b1110 : case(kpr)
						
						'b0111 : begin kphit = 1; num = 'hA; end
						'b1011 : begin kphit = 1; num = 'hB; end
						'b1101 : begin kphit = 1; num = 'hC; end
						'b1110 : begin kphit = 1; num = 'hD; end
						default : begin kphit = 0; num = 'hF; end
					endcase
					
			default : begin kphit = 0; num = 'hF; end
		endcase	
		
endmodule