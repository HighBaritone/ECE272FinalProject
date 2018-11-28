module kbDecoder(input logic kbData, kbClock, input logic [3:0] count, output logic parity, output logic [7:0] rawData);

always_ff @ (negedge kbClock)
begin
	case(count)
			10: parity = kbData;
			default: rawData[count-2] = kbData;
	endcase
end

endmodule 