module counter_tb;

parameter m = 255;
parameter SIZE = $clog2(m);

reg en, clk, rst;
wire [SIZE-1:0] count;

counter #(.m(m), .SIZE(SIZE)) dut(.en(en), .clk(clk), .rst(rst), .count(count));

initial begin
	en = 1'b1; clk = 1'b0; rst = 1'b1; #1;
	rst = 1'b0;
end

always @(posedge clk) begin
	$display("Count = %d",count);
end

always begin
	clk = ~clk; #5;
end

endmodule
