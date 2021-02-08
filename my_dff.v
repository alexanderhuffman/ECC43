module my_dff(d, en, clk, rst, q);

parameter SIZE = 1;

input [SIZE-1:0] d;
input en, clk, rst;
output reg [SIZE-1:0] q;

wire [511:0] rst_val = 512'd0;

always @(posedge clk or posedge rst) begin
	if (rst) q[SIZE-1:0] <= rst_val[SIZE-1:0];
	else if (en) q <= d;
	else q <= q;
end

endmodule
