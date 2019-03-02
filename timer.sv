module timer (input logic clk, stop, start, write, //[9:0] Time, [7:0] DC,
				  output logic [11:0] tLED, output logic pwm);

	logic [26:0] ctr = 1; 
	logic [9:0] tim = 120; //temporary just to test logic	
	logic [3:0] minutes;
	logic [3:0] tens;
	logic [3:0] ones;
	
	always_comb begin
		minutes = tim / 60;
		tens = (tim % 60) / 10;
		ones = (tim % 60) % 10;
		tLED =  {minutes, tens, ones};
	end
		
	always_ff @(posedge clk) begin
		if (ctr >= 2000) begin 
			ctr <= 0;
			
			if(tim > 0)
				tim <= tim - 1;
		end
		else 
			ctr <= ctr + 1;
	end

endmodule