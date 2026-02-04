'timescale 1ns/lps

module GPIO_TB;

  reg clk;
  reg reset;
  reg we;
  reg re;
  reg[3:0] addr;
  reg [31:0] wdata; 
  wire [31:0] rdata; 
  reg[31:0] gpio_in; 
  wire[31:0] gpio_out; 
  wire[31:0] gpio_dir;

  GPIO dut (
    .clk(clk),
    .reset (reset),
    .we (we), 
    .re (re),
    .addr(addr), 
    .wdata(wdata),
    .rdata(rdata),
    .gpio_in(gpio_in),
    .gpio_out(gpio_out),
    .gpio_dir(gpio_dir)
  );

  always #5 clk= ~clk;

  initial begin
    $dumpfile("waves_vcd");
    $dumpvars(0, GPIO_TB);

    clk=0; reset=1; we=0; re=0; addr=4'h0; wdata=32'h0; gpio_in=32'h0;

    #10;
    reset=0;

    #10; 
    we=1; 
    addr=4'h4;
    wdata=32'h000000F;

    #10; 
    we=0;

    #10; 
    we=1; 
    addr=4'h0;
    wdata=32'h00000005;

    #10; 
    we=0;

    #10; 
    re=1; 
    addr=4'h8;

    #10; 
    re=0;

    #10; 
    gpio_in=32'h000000A0;

    #10; 
    re=1; 
    addr=4' h8;

    #10; 
    re=0;

    #20;
    $display("Simulation Finished. Check waves for DEADBEEF on gpio_out");
    $finish;
  end
endmodule
