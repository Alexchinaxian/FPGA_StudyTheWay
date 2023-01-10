module Top_module
(
  CLK,RSTn,LED_out
);

  input CLK;
  input RSTn;
  output [3:0]LED_out;

  wire LED0_Out;
  LED0_module U1
  (
    .CLK(CLK),
    .RSTn(RSTn),
    .LED_out(LED0_Out)
  );


  wire LED1_Out;
  LED2_module U1
  (
    .CLK(CLK),
    .RSTn(RSTn),
    .LED_out(LED1_Out)
  );

    wire LED2_Out;
  LED2_module U1
  (
    .CLK(CLK),
    .RSTn(RSTn),
    .LED_out(LED2_Out)
  );

  wire LED3_Out;
  LED2_module U1
  (
    .CLK(CLK),
    .RSTn(RSTn),
    .LED_out(LED3_Out)
  );

  assign LED_out = {LED3_Out,LED2_Out,LED1_Out,LED0_Out};

endmodule