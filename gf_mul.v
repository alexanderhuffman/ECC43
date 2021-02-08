module gf_mul(a, b, y);

parameter m = 255;
parameter SIZE = $clog2(m);

input [SIZE-1:0] a, b;
output [SIZE-1:0] y;

wire [SIZE-1:0] gf_expa, gf_loga;
wire [SIZE-1:0] gf_expb, gf_logb;
wire [SIZE-1:0] gf_expy, gf_logy;
wire [SIZE-1:0] index;

LUT #(.m(m), .SIZE(SIZE)) LUTa(.index(a), .gf_exp(gf_expa), .gf_log(gf_loga));
LUT #(.m(m), .SIZE(SIZE)) LUTb(.index(b), .gf_exp(gf_expb), .gf_log(gf_logb));

assign index = (gf_loga + gf_logb) % 255;

LUT #(.m(m), .SIZE(SIZE)) LUTy(.index(index), .gf_exp(gf_expy), .gf_log(gf_logy));

assign y = ((a == 0) | (b == 0)) ? 0 : gf_expy;

endmodule
