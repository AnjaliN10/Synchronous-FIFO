`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.03.2026 18:46:40
// Design Name: 
// Module Name: fifo
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


module fifo #(
    parameter DATA_WIDTH = 8,
    parameter DEPTH = 8
)(
    input clk,
    input rst,
    input wr_en,
    input rd_en,
    input [DATA_WIDTH-1:0] data_in,
    output reg [DATA_WIDTH-1:0] data_out,
    output full,
    output empty
);

// Pointer width
localparam ADDR_WIDTH = $clog2(DEPTH);

// Memory
reg [DATA_WIDTH-1:0] mem [0:DEPTH-1];

// Pointers
reg [ADDR_WIDTH-1:0] wr_ptr = 0;
reg [ADDR_WIDTH-1:0] rd_ptr = 0;

// Counter (for full/empty)
reg [ADDR_WIDTH:0] count = 0;

// Write operation
always @(posedge clk) begin
    if (rst) begin
        wr_ptr <= 0;
    end
    else if (wr_en && !full) begin
        mem[wr_ptr] <= data_in;
        wr_ptr <= wr_ptr + 1;
    end
end

// Read operation
always @(posedge clk) begin
    if (rst) begin
        rd_ptr <= 0;
        data_out <= 0;
    end
    else if (rd_en && !empty) begin
        data_out <= mem[rd_ptr];
        rd_ptr <= rd_ptr + 1;
    end
end

// Count logic
always @(posedge clk) begin
    if (rst)
        count <= 0;
    else begin
        case ({wr_en && !full, rd_en && !empty})
            2'b10: count <= count + 1; // write
            2'b01: count <= count - 1; // read
            default: count <= count;   // no change
        endcase
    end
end

// Flags
assign full  = (count == DEPTH);
assign empty = (count == 0);

endmodule
