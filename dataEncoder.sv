module dataEncoder(input logic [7:0] rawData, input logic parity, output logic upButton, output logic downButton);

always_comb
begin
	if(parity ^ rawData)
		begin
			case(rawData)
				8'b00011101: begin
									upButton <= 1; 
									downButton <= 0;
								 end
				8'b00011011: begin
									upButton <= 0; 
									downButton <= 1;
								 end
				default: begin
								upButton <= 1; 
								downButton <= 0;
							end
			endcase
		end
	else begin 
				upButton = 0; 
				downButton = 0;
		  end
end
endmodule 