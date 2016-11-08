`timescale 1ns/1ps
module tb();

initial begin
  $dumpfile("out.vcd");
  $dumpvars;
end

localparam CLK_PERIOD = 10;
localparam RST_PERIOD = 23;
localparam RUN_PERIOD = 20*CLK_PERIOD;

//clock
reg clk = 1'b0;
always # (CLK_PERIOD/2) clk = ~clk;

//reset
reg rst;
initial
begin
    #0 rst = 1'b0;
    #RST_PERIOD rst = 1'b1;
end

//finish
initial #RUN_PERIOD $finish();

//in_a
reg [11:0] in_a;
initial
begin
    in_a = 10;
    forever #40 in_a = in_a + 3;
end

//in_b
reg [11:0] in_b;
initial
begin
    in_b = 0;
    forever #40 in_b = in_a + 13;
end

wire [11:0] out;

adder adder
    (.clk(clk),
     .rst(rst),
     .in_a(in_a),
     .in_b(in_b),
     .out(out));


endmodule