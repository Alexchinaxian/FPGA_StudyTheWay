//按键消抖
/*
按键消抖一般有三段操作
1、检测电平变化；
2、过滤抖动（延迟）；
3、产生有效按键
*/

//出入端声明
module key_funcmod
(
  input CLOCK,RESET,        //时钟信号，复位信号
  input KEY,                //按键
  output [1:0]LED           //输出LED信号
);

parameter T10MS = 19'd500_000;      //参数 10毫秒
reg F1,F2;                          //寄存器变量 F1 F2

always (posedge CLOCK or negedge RESET)
  if (!RESET)                       //低复位
    {F1,F2} <= 2'b11;
  else 
    {F1,F2} <= {F1,KEY};
  wire isH2L = {F2 == 1 && F1 == 0};      //按下事件
  wire isH2L = {F2 == 1 && F2 == 1};      //释放事件

