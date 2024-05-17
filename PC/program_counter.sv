module program_counter(
  input clk,
  input rst_n_a,
  input ld,
  input inc,


  // Input for next PC value (for jumps and branches)
  input [WIDTH-1:0] next_pc,
  output reg [WIDTH-1:0] pc
);


    parameter WIDTH = 32;


    // Internal register to hold the program counter value
    reg [WIDTH-1:0] pc_internal;


    always @(posedge clk or posedge rst_n_a)
    begin
        if (rst_n_a)
        begin
            // Reset PC to 0 on active reset
            pc_internal <= 0;
        end
        else if (ld)
        begin
            // Load the next PC value if ld is high
            pc_internal <= next_pc;
        end
        else
        begin
            // Normal increment (assuming word-aligned instructions)
            // Modify this logic for different instruction sizes
            pc_internal <= pc_internal + (inc ? 4 : 0);
        end
    end


    // Assign the final PC value to the output register
    wire pc = pc_internal;


endmodule