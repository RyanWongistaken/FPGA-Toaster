// kpcontrol.sv - ELEX 7660 Design Project
// Interface with keypad by recieving values from kpdecode.sv 
// and then executing the appropriate code based on the mode
// Ryan Wong & Bhavik Maisuria
// 3-31-2019 (Last edited)


module kpcontrol (input logic [11:0] tLED, input logic [3:0] num, input logic kphit, clk, write_ack,
						output logic start, stop, write, mode, output logic [9:0] Time, output logic [7:0] DC,
						output logic [11:0] tLED_temp, cLED);
						
						logic [9:0] debounce; 
						logic [9:0] celcius;
						
						always_comb begin
							// Converts the value stored in the temporary register time in seconds
							Time = tLED_temp[11:8] * 60 + tLED_temp[7:4] * 10 + tLED_temp[3:0];
							
							// converts the bcd into binary
							celcius = cLED[11:8] * 100 + cLED[7:4] * 10 + cLED[3:0];
							
							//PWM Temperature control: the value entered is set as the new pwm duty cycle
							DC = celcius / 2 - 13;
						end
						
						always_ff @(posedge clk) begin
							//checks if the user has decided to edit the values of the toaster
							// A corressponds to the "stop" button on the keypad
							if(num <= 9 && debounce == 0 && stop) begin
								if(mode)
									tLED_temp <= {tLED_temp[7:0], num}; 
								else
									cLED <= {cLED[7:0], num};
									
								start <= start;
								stop <= stop;
								mode <= mode;
								debounce <= 1023;
							end
							//stops the timer and the toasting
							else if(num == 'hA && debounce == 0) begin 
								start <= 0;
								stop <= 1;
								tLED_temp <= tLED;
								cLED <= cLED;
								mode <= mode;
								debounce <= 1023;
							end
							//Starts the timer and the toasting 
							else if(num == 'hB && debounce == 0 && stop && celcius <= 200 && celcius >= 30 && Time < 600) begin
								start <= 1;
								stop <= 0;
								tLED_temp <= tLED_temp;
								cLED <= cLED;
								write <= 1;
								mode <= mode;
								debounce <= 1023;
							end
							//Toggle between temperature and time mode
							else if(num == 'hC && debounce == 0) begin
								mode <= ~mode;
								debounce <= 1023;
							end
							//do nothing if nothing is pressed
							else begin
								start <= start;
								stop <= stop;
								tLED_temp <= tLED_temp;
								cLED <= cLED;
								mode <= mode;
							end
							// confirms the value is recieved by the other module 
							if(write_ack)
								write <= 0;
							//does the debouncing by counting down
							if(debounce > 0)
								debounce <= debounce - 1;
								
						end
endmodule