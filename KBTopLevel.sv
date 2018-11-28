module KBTopLevel(input logic kbData, kbClock, output logic upButton, downButton);

logic parity;
logic [3:0] count;
logic [7:0] rawData;

kbCounter counter(.kbClock(kbClock), .count(count));

kbDecoder decoder(.kbData(kbData), .kbClock(kbClock), .count(count), .parity(parity), .rawData(rawData));

dataEncoder encoder(.rawData(rawData), .parity(parity), .upButton(upButton), .downButton(downButton));

endmodule 