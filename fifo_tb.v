`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.03.2026 18:47:52
// Design Name: 
// Module Name: fifo_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module fifo_tb;

// Inputs (reg because we drive them)
reg clk;
reg rst;
reg wr_en;
reg rd_en;
reg [7:0] data_in;

// Outputs (wire because FIFO drives them)
wire [7:0] data_out;
wire full;
wire empty;

// Instantiate FIFO
fifo uut (
    .clk(clk),
    .rst(rst),
    .wr_en(wr_en),
    .rd_en(rd_en),
    .data_in(data_in),
    .data_out(data_out),
    .full(full),
    .empty(empty)
);

// Clock generation (10ns period)
always #5 clk = ~clk;

// Test sequence
initial begin
    // Initialize
    clk = 0;
    rst = 1;
    wr_en = 0;
    rd_en = 0;
    data_in = 0;

    // Apply reset
    #10;
    rst = 0;

    // -----------------------
    // WRITE DATA
    // -----------------------
    #10;
    wr_en = 1;
    data_in = 8'hA1; #10;
    data_in = 8'hB2; #10;
    data_in = 8'hC3; #10;

    // -----------------------
    // READ DATA
    // -----------------------
    wr_en = 0;
    rd_en = 1;
    #30;

    // -----------------------
    // FILL FIFO (check FULL)
    // -----------------------
    rd_en = 0;
    wr_en = 1;
    repeat (10) begin
        data_in = $random;
        #10;
    end

    // -----------------------
    // EMPTY FIFO
    // -----------------------
    wr_en = 0;
    rd_en = 1;
    repeat (10) #10;

    // End simulation
    $finish;
end

endmodule
