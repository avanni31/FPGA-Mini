module simple_gpio (
    input  wire        clk,
    input  wire        reset,
    input  wire        we,       // Write Enable (from Address Decoder)
    input  wire        re,       // Read Enable (from Address Decoder)
    input  wire [31:0] data_in,  // Data from CPU
    output wire [31:0] data_out, // Data to CPU
    output wire [31:0] gpio_out  // Output to physical pins/LEDs
);

    // Only one 32-bit register is needed to store the state
    reg [31:0] gpio_reg;

    // --- Write Logic (Synchronous) ---
    always @(posedge clk) begin
        if (reset) begin
            gpio_reg <= 32'b0;
        end else if (we) begin
            gpio_reg <= data_in;
        end
    end

    // --- Read Logic (Combinational) ---
    // This allows the CPU to read the value instantly without waiting a clock cycle
    assign data_out = (re) ? gpio_reg : 32'h0000_0000;

    // --- Physical Output ---
    assign gpio_out = gpio_reg;

endmodule
