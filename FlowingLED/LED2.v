//模块出入端声明
module LED2_module
(
	CLK,RSTn,LED_out
);

input CLK;          //输入信号CLK
input RSTn;         //输入信号RSTn
output LED_out;     //输出信号LED
parameter T100MS = 23'd5_000_000;
reg[22:0]Count1;
always @(posedge CLK or negedge RSTn)
  if (!RSTn)
		Count1 <= 23'd0;
	else if (Count1 == T100MS)
		Count1 <= 23'd0;
	else 
		Count1 <= Count1 + 1'd1;

	reg rLed_out;
	always @ (posedge CLK or negedge RSTn)
		if(!RSTn)
			rLed_out <= 1'b0;
		else if( Count1 >= 23'd0 && Count1 <= 23'd1_250_000)
			rLed_out <= 1'b1;
		else 
			rLed_out <= 1'b0;
	assign LED_out = rLed_out;

endmodule