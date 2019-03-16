// timer.sv - ELEX 7660 Design Project
// 
// 
//
// Ryan Wong & Bhavik Maisuria
// 3-16-2019 (Last edited)


module timer (input logic clk, stop, start, write, input logic [9:0] Time, input logic [7:0] DC,
				  output logic [11:0] tLED, output logic pwm, write_ack);

	logic [26:0] ctr; 
	logic [9:0] tim; 
	logic [3:0] minutes;
	logic [3:0] tens;
	logic [3:0] ones;
	
	always_comb begin
		minutes = tim / 60;
		tens = (tim % 60) / 10;
		ones = (tim % 60) % 10;
		tLED =  {minutes, tens, ones};
		pwm = tim && start && ctr < 10 * DC;
	end
		
	always_ff @(posedge clk) begin
		if(write) begin
			tim <= Time;
			write_ack <= 1;
		end
		else if(ctr >= 2000 && start) begin 
			ctr <= 0;
			write_ack <= 0;
			
			if(tim > 0)
				tim <= tim - 1;
		end
		else begin
			ctr <= ctr + 1;
			write_ack <= 0;
		end
	end

endmodule