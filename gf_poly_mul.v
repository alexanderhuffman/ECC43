module gf_poly_mul(flat_p, flat_q, flat_z);

parameter m = 255;
parameter SIZE = $clog2(m);
parameter n = 2;
parameter flat_size = (n+1)*SIZE;
parameter large_array = 2*n;
parameter large_array_size = (large_array+1)*SIZE;

input [flat_size-1:0] flat_p;
input [flat_size-1:0] flat_q;
output [large_array_size-1:0] flat_z;

wire [SIZE-1:0] p[0:n];
wire [SIZE-1:0] q[0:n];

wire [SIZE-1:0] initial_mult[0:n][0:n];
wire [large_array_size-1:0] flat_initial_mult[0:n];
wire [large_array_size-1:0] flat_final_mult[0:n];

wire [large_array_size-1:0] sum_result[0:n-1];

genvar i;
genvar j;

generate
	for (i = 0; i <= n; i = i + 1) begin
		assign p[i] = flat_p[((i+1)*SIZE)-1:i*SIZE];
		assign q[i] = flat_q[((i+1)*SIZE)-1:i*SIZE];
		// perform initial multiplication
		for (j = 0; j <= n; j = j + 1) begin
			gf_mul #(.m(m), .SIZE(SIZE)) my_multiplier(.a(p[i]), .b(q[j]), .y(initial_mult[j][i]));
		end
	end

	// flatten initial_mult arrays so that gf_poly_add can be used
	for  (i = 0; i <= n; i = i + 1) begin
		for (j = 0; j <= large_array; j = j + 1) begin
			assign flat_initial_mult[i][((j+1)*SIZE)-1:j*SIZE] = initial_mult[j][i];
		end
	end

	// getting rid of x (don't care) values
	for (i = 0; i < n; i = i + 1) begin
		assign flat_final_mult[i][flat_size+(i*SIZE)-1:0] = flat_initial_mult[i][flat_size-1:0] << i*SIZE;
		assign flat_final_mult[i][large_array_size-1:flat_size+(i*SIZE)] = 0;
	end
	assign flat_final_mult[n] = flat_initial_mult[n][flat_size-1:0] << n*SIZE;

	// perform first gf_poly_add operation
	gf_poly_add #(.m(m), .SIZE(SIZE), .n(large_array), .flat_size(large_array_size))
		first_adder(.flat_p(flat_final_mult[0]), .flat_q(flat_final_mult[1]), .flat_z(sum_result[0]));

	// perform the rest of the gf_poly_add operations
	for (i = 0; i < n-1; i = i + 1) begin
		gf_poly_add #(.m(m), .SIZE(SIZE), .n(large_array), .flat_size(large_array_size))
			my_adder(.flat_p(sum_result[i]), .flat_q(flat_final_mult[i+2]), .flat_z(sum_result[i+1]));
	end

	assign flat_z = sum_result[n-1];

endgenerate

endmodule
