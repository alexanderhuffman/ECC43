module my_dff_tb;

parameter SIZE = 8;

reg [SIZE-1:0] d;
reg en, clk, rst;
wire [SIZE-1:0] q;

my_dff #SIZE dut(.d(d), .en(en), .clk(clk), .rst(rst), .q(q));

initial begin
	en = 1'b1; clk = 1'b0; rst = 1'b0;
	d = 0; #10;
	d = 4; #10;
	d = 7; #10;
	$stop;
end

always @(posedge clk) begin
	$display("q = %d",q);
end

always begin
	clk = ~clk; #5;
end

endmodule
