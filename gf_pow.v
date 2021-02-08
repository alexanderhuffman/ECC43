module gf_pow(a, power, y);

parameter m = 255;
parameter SIZE = $clog2(m);

input [SIZE-1:0] a, power;
output [SIZE-1:0] y;

wire [SIZE-1:0] gf_expa, gf_loga;
wire [SIZE-1:0] gf_logy;
wire [SIZE-1:0] index;

LUT #(.m(m), .SIZE(SIZE)) LUTa(.index(a), .gf_exp(gf_expa), .gf_log(gf_loga));

assign index = (gf_loga * power) % 255;

LUT #(.m(m), .SIZE(SIZE)) LUTy(.index(index), .gf_exp(y), .gf_log(gf_logy));

endmodule
