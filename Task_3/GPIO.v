module GPIO(
  input wire clk,
  input wire reset,
  input wire we,
  input wire re,
  input wire[3:0] addr, 
  input wire[31:0]wdata,
  output reg[31:0]rdata, 
  input wire[31:0lgpio_in, 
  output wire[31:0lgpio_out, 
  output wire[31:0]gpio_dir
);

  //32 bit register is needed to store data 
  reg[31:0]gpio_data_reg;
  reg[31:0]gpio_dir_reg;

  always @(posedge clk) begin 
    if (reset) begin
      gpio_data_reg<=32'h0;
      gpio_dir_reg<=32'h0;
    end else if (we) begin
      case (addr)
        4'h0: gpio_data_reg <= wdata;
        4'h4: gpio_dir_reg <= wdata;
        default: ;
      endcase
    end
end

  always @(*) begin
    if (re) begin
      case (addr)
        4'h0: rdata = gpio_data_reg;
        4'h4: rdata = gpio_dir_reg;
        4'h8: rdata = (gpio_dir_reg & gpio_data_reg)| 
                      (- gpio dir_reg & gpio_in);
        default: rdata = 32'h0;
      endcase
    end else begin
      rdata = 32'h0;
    end
  end

  //Read logic (combinational) -allows CPU to read alue instantly
  assign gpio_out = gpio_data_reg & gpio_dir_reg;
  assign gpio_dir=gpio_dir_reg;

endmodule
