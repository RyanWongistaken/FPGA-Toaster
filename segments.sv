// segments.sv - ELEX 7660 Design Project
// Code that controls two 7-segment displays
// tLED ---> LEDt Time Display
// cLED ---> LEDc Temperature displays (Celsius)
// Ryan Wong & Bhavik Maisuria



module segments (input logic [11:0] tLED, 
				input logic [15:0] cLED,
				input logic [1:0] digit,
				output logic [3:0] LEDt, LEDc,
				output logic [3:0] ct_1, ct_2,
				input logic clk, reset_n);
				
		logic [3:0] t_digit2, t_digit1, t_digit0;
		logic [3:0] c_digit3, c_digit2, c_digit1, c_digit0;
		
		
				
	always_comb begin
		
		t_digit2 = tLED[11:8];
		t_digit1 = tLED[7:4];
		t_digit0 = tLED[3:0];
		
		c_digit3 = cLED[15:12];
		c_digit2 = cLED[11:8];
		c_digit1 = cLED[7:4];
		c_digit0 = cLED[3:0];
		
		//set the digit for the time display
		case (digit)
			0 : LEDt = t_digit0;	//extracted first digit
			1 : LEDt = t_digit1;	//extracted second digit
			2 : LEDt = t_digit2;	//extracted thrid digit
			3 : LEDt = 4'hA;  		//"t"
			default : LEDt = 4'hF; // F to pay respects
		endcase
			
		//set the digit for the Temperature display
		case (digit)
			0 : LEDc = c_digit0;	//extracted first digit
			1 : LEDc = c_digit1;	//extracted second digit
			2 : LEDc = c_digit2;	//extracted thrid digit
			3 : LEDc = c_digit3;  	//extracted fourth digit
			default : LEDc = 4'hF; // F to pay respects
		endcase
		
		//which digit to write to at the time
		case (digit)
			0 : begin 
					ct_1 = 4'b0001;
					ct_2 = 4'b0001;
				end
			1 : begin 
					ct_1 = 4'b0010;
					ct_2 = 4'b0010;
				end
			2 : begin
					ct_1 = 4'b0100;
					ct_2 = 4'b0100;
				end
			3 : begin
					ct_1 = 4'b1000;
					ct_2 = 4'b1000;
				end
		
		default : begin 
					ct_1 = 4'b0001;
					ct_2 = 4'b0001;
				end
		endcase
	
	
	end
endmodule

			
