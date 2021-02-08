module counter(en, clk, rst, count);

parameter m = 255;
parameter SIZE = $clog2(SIZE);

input en, clk, rst;
output reg [SIZE-1:0] count;

wire [511:0] rst_val = 512'd0;

always @(posedge clk or posedge rst) begin
	if (rst) count[SIZE-1:0] <= rst_val[SIZE-1:0];
	else if (en) count <= count + 1'b1;
end

endmodule
