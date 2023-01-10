module LED_funcmod				//LED_funcmod 模块开始
(
	input CLOCK,RESET,			//输入信号时钟 和复位信号
	output [3:0]LED
);
	//相关寄存器的声明。寄存器i用来指向步骤，
	//寄存器C1用来计数，寄存器D用来暂存结果和驱动删除，
	//寄存器T用来暂存及数量，
	//isTga则用来暂存延迟标签
	
	parameter T1S = 26'd50_000_000;		//1HZ  位宽26 十进制 50,000,000
	parameter T100MS = 26'd5_000_000	//10HZ  位宽26 十进制 5,000,000
	parameter T10MS = 26'd500_000		//100HZ  位宽26 十进制 500,000
	parameter T1MS = 26'd500_000		//1000HZ  位宽26 十进制 500,000


	reg[3:0]i;		//4位宽i
	reg[25:0]C1;	//26位宽C1
	reg[3:0]D;		//4位宽D
	reg[25:0]T;		//26位宽
	reg[3:0]isTag;	//4位宽isTag

	always @(posedge CLOCK or negedge RESET)	//每当clock下降沿或reset上升沿
		if(!RESET)								//低复位
			begin 
			i <= 4'd0;							//i复位值为0
			C1 <= 26'd0;						//C1复位值为0
			D <= 4'b0001;						//D复位值为1；
			T <= T1S;							//T 复位值为1；
			isTag <= 4'b0001;					//isTag 复位值为1；
			end
		else
		case(i)
		0:
			if(C1 == T-1) begin C1 <= 26'd0; i <= i+ 1'b1; end  //如果C1 == T-1 那么C1 = 0； i+1；
			else begin C1 <= C1 + 1'b1; D <= 4'b0001; end		//反之 则C1 +1    D= 1；
			1:
			if(C1 == T-1) begin C1 <= 26'd0; i <= i+ 1'b1; end  //如果C1 == T-1 那么C1 = 0； i+1；
			else begin C1 <= C1 + 1'b1; D <= 4'b0010; end		//反之 则C1 +1    D= 2；
			2：
			if(C1 == T-1) begin C1 <= 26'd0; i <= i+ 1'b1; end  //如果C1 == T-1 那么C1 = 0； i+1；
			else begin C1 <= C1 + 1'b1; D <= 4'b0100; end		//反之 则C1 +1    D= 3；
			3：
			if(C1 == T-1) begin C1 <= 26'd0; i <= i+ 1'b1; end  //如果C1 == T-1 那么C1 = 0； i+1；
			else begin C1 <= C1 + 1'b1; D <= 4'b1000; end		//反之 则C1 +1    D= 3；
			4:
			begin isTag <= {isTag[2:0],isTag[3]}; i <= i+1'b1; end   //
			5:
			if(isTag[0]) begin T <= T1s; i <= 4'd0;end
			if(isTag[1]) begin T <= T100MS; i <= 4'd0;end
			if(isTag[2]) begin T <= T10MS; i <= 4'd0;end
			if(isTag[3]) begin T <= T1MS; i <= 4'd0;end
		endcase
	assign LED = 0;
endmodule		