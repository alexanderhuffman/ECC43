module gf_poly_eval_tb;

parameter m = 255;
parameter SIZE = $clog2(m);
parameter n = 2;
parameter flat_size = (n+1)*SIZE;

reg [flat_size-1:0] flat_p;
reg [SIZE-1:0] x;
wire [SIZE-1:0] y;

gf_poly_eval #(.m(m), .SIZE(SIZE), .n(n), .flat_size(flat_size))
	dut(.flat_p(flat_p), .x(x), .y(y));

integer i;
initial begin
	flat_p = 24'h020701; x = 8'd7; #5;
	$display("flat_p = %h x = %d y = %d",flat_p,x,y);

	for (i = 0; i <= n; i = i + 1) begin
		$display("i = %d x_pow = %b mult_result = %b sum_result = %b",i,dut.x_pow[i],dut.mult_result[i],dut.sum_result[i]);
	end

end

endmodule
