/*
*	NAME:
* 		ROM
* 
*	DESCRIPTION:
* 		This module implements a Read-Only Memory with a parameterizable data width 
* 		and memory depth. The ROM reads data from a specified address on the rising
* 		edge of the clock.
*		The initial contents of the memory are loaded from an external file.
* 	
* 	PARAMETERS:
* 		- DATA_LENGTH: The width of the data bus (default is 32 bits).
* 		- MEM_LENGHT:  The depth of the memory, i.e., the number of memory locations 
* 		  				default is 32).
* 	
*
* 	PORTS:
* 		- INPUT:
*					-clk: The clock signal. Data is read from memory on the rising edge of this clock.
*
* 				 	-address: The address input to specify which memory location 
* 		                          to read. The width of this port is determined by 
* 		                          the logarithm of the memory depth.
*
* 		- OUTPUTS:
*                	 -return_data: The data output that holds the value read from the memory.
* 	
*/




module ROM #(parameter DATA_LENGTH = 32, 
             parameter MEM_LENGTH = 32) //32 bit by 32 registers
(
    input clk,                                      // clock
    input [$clog2(MEM_LENGTH)-1:0] address,         // address to read
    output reg [DATA_LENGTH-1:0] return_data        // data output 
);

    reg [DATA_LENGTH-1:0] mem [0:MEM_LENGTH-1];

    /* Initialize values from file */

    initial
    begin
        $readmemb("instructions.mem", mem);         // initializes values into memory
    end

    // Or initialize from code, better for testing
    // initial begin
    //    mem[0] = 32'b00110000000011000000000000000001; // Example binary instruction
    // end

    always @(posedge clk)
    begin 
        return_data <= mem[address];    
    end 
endmodule
