// kpcontrol.sv - ELEX 7660 Design Project
// 
// 
//
// Ryan Wong & Bhavik Maisuria
// 3-16-2019 (Last edited)


module kpcontrol (input logic [11:0] tLED, input logic [3:0] num, input logic kphit, clk, write_ack,
						output logic start, stop, write, output logic [9:0] Time, output logic [7:0] DC,
						output logic [11:0] tLED_temp, cLED);
						
						logic [9:0] debounce;
						logic mode;
						
						always_comb begin
							Time = tLED_temp[11:8] * 60 + tLED_temp[7:4] * 10 + tLED_temp[3:0];
							DC = cLED[11:8] * 100 + cLED[7:4] * cLED[3:0];
						end
						
						always_ff @(posedge clk) begin
							if(num < 'hA && debounce == 0 && stop) begin
								if(mode)
									tLED_temp <= {tLED_temp[7:0], num}; 
								else
									cLED <= {cLED[7:0], num};
									
								start <= start;
								stop <= stop;
								mode <= mode;
								debounce <= 1023;
							end
							else if(num == 'hA && debounce == 0) begin 
								start <= 0;
								stop <= 1;
								tLED_temp <= tLED;
								cLED <= cLED;
								mode <= mode;
								debounce <= 1023;
							end
							else if(num == 'hB && debounce == 0) begin
								start <= 1;
								stop <= 0;
								tLED_temp <= tLED_temp;
								cLED <= cLED;
								write <= 1;
								mode <= mode;
								debounce <= 1023;
							end
							else if(num == 'hC && debounce == 0) 
								mode <= ~mode;
							else begin
								start <= start;
								stop <= stop;
								tLED_temp <= tLED_temp;
								cLED <= cLED;
								mode <= mode;
							end
							
							if(write_ack)
								write <= 0;
							
							if(debounce > 0)
								debounce <= debounce - 1;
								
						end
endmodule