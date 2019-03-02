// decode7.sv - ELEX 7660 Design Project
// Code that turns on the necessary LEDS in the 7-segement
// Ryan Wong & Bhavik Maisuria

module decode7 (input logic [3:0] LEDt, LEDc,
			output logic [7:0] ledst, ledsc);
			
	always_comb begin
		case (LEDt)
			4'h0 : ledst = 8'b11000000;//0
			4'h1 : ledst = 8'b11111001;//1
			4'h2 : ledst = 8'b10100100;//2
			4'h3 : ledst = 8'b10110000;//3
			4'h4 : ledst = 8'b10011001;//4
			4'h5 : ledst = 8'b10010010;//5
			4'h6 : ledst = 8'b10000010;//6
			4'h7 : ledst = 8'b11111000;//7
			4'h8 : ledst = 8'b10000000;//8
			4'h9 : ledst = 8'b10010000;//9
			4'hA : ledst = 8'b10000111;//t
			4'hB : ledst = 8'b10000011;//B
			4'hC : ledst = 8'b11000110;//C
			4'hD : ledst = 8'b10100001;//D
			4'hE : ledst = 8'b10000110;//E
			4'hF : ledst = 8'b10001110;//F
			default : ledst =  8'b10001110;// F to pay respects
			endcase
			
			
		case (LEDc)
			4'h0 : ledsc = 8'b11000000;//0
			4'h1 : ledsc = 8'b11111001;//1
			4'h2 : ledsc = 8'b10100100;//2
			4'h3 : ledsc = 8'b10110000;//3
			4'h4 : ledsc = 8'b10011001;//4
			4'h5 : ledsc = 8'b10010010;//5
			4'h6 : ledsc = 8'b10000010;//6
			4'h7 : ledsc = 8'b11111000;//7
			4'h8 : ledsc = 8'b10000000;//8
			4'h9 : ledsc = 8'b10010000;//9
			4'hA : ledsc = 8'b10001000;//A
			4'hB : ledsc = 8'b10000011;//B
			4'hC : ledsc = 8'b11000110;//C
			4'hD : ledsc = 8'b10100001;//D
			4'hE : ledsc = 8'b10000110;//E
			4'hF : ledsc = 8'b10001110;//F
			default : ledsc =  8'b10001110;// F to pay respects
			endcase
			
	end
endmodule