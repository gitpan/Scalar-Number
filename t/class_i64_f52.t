use Test::More;

use Data::Integer 0.000 qw(natint_bits);
use Data::Float 0.005 qw(significand_bits hex_float);

plan skip_all => "tests not designed for these word sizes"
	unless natint_bits == 64 && significand_bits == 52;
plan tests => 569;

require_ok "Scalar::Number";
Scalar::Number->import(qw(sclnum_is_natint sclnum_is_float));

sub check($$$) {
	my($expect_natint, $expect_float, $value) = @_;
	my $desc = sprintf("status of %s (%.1f)",
			my $sval = $value, my $fval = $value);
	is !!sclnum_is_natint($value), !!$expect_natint, "integer $desc";
	is !!sclnum_is_float($value), !!$expect_float, "float $desc";
}

eval do { local $/; <DATA>; } or die $@;
__DATA__
local $SIG{__DIE__};

no warnings "portable";

# positive integers

check 1, 1, +0xfffe;
check 1, 1, +0xffff;
check 1, 1, +0x10000;
check 1, 1, +0x10001;
check 1, 1, +0x10002;

check 1, 1, +0xfffffe;
check 1, 1, +0xffffff;
check 1, 1, +0x1000000;
check 1, 1, +0x1000001;
check 1, 1, +0x1000002;

check 1, 1, +0x7ffffffe;
check 1, 1, +0x7fffffff;
check 1, 1, +0x80000000;
check 1, 1, +0x80000001;
check 1, 1, +0x80000002;

check 1, 1, +0xfffffffe;
check 1, 1, +0xffffffff;
check 1, 1, +0x100000000;
check 1, 1, +0x100000001;
check 1, 1, +0x100000002;

check 1, 1, +0x1fffffffe;
check 1, 1, +0x1ffffffff;
check 1, 1, +0x200000000;
check 1, 1, +0x200000001;
check 1, 1, +0x200000002;

check 1, 1, +0xffffffffffffe;
check 1, 1, +0xfffffffffffff;
check 1, 1, +0x10000000000000;
check 1, 1, +0x10000000000001;
check 1, 1, +0x10000000000002;

check 1, 1, +0x1ffffffffffffe;
check 1, 1, +0x1fffffffffffff;
check 1, 1, +0x20000000000000;
check 1, 0, +0x20000000000001;
check 1, 1, +0x20000000000002;
check 1, 0, +0x20000000000003;
check 1, 1, +0x20000000000004;

check 1, 1, +0x3ffffffffffffc;
check 1, 0, +0x3ffffffffffffd;
check 1, 1, +0x3ffffffffffffe;
check 1, 0, +0x3fffffffffffff;
check 1, 1, +0x40000000000000;
check 1, 0, +0x40000000000001;
check 1, 0, +0x40000000000002;
check 1, 1, +0x40000000000004;
check 1, 0, +0x40000000000006;
check 1, 1, +0x40000000000008;

check 1, 1, +0x7ffffffffffff800;
check 1, 0, +0x7ffffffffffffa00;
check 1, 1, +0x7ffffffffffffc00;
check 1, 0, +0x7ffffffffffffe00;
check 1, 0, +0x7ffffffffffffffe;
check 1, 0, +0x7fffffffffffffff;
check 1, 1, +0x8000000000000000;
check 1, 0, +0x8000000000000001;
check 1, 0, +0x8000000000000002;
check 1, 0, +0x8000000000000400;
check 1, 1, +0x8000000000000800;
check 1, 0, +0x8000000000000c00;
check 1, 1, +0x8000000000001000;

check 1, 1, +0xfffffffffffff000;
check 1, 0, +0xfffffffffffff400;
check 1, 1, +0xfffffffffffff800;
check 1, 0, +0xfffffffffffffc00;
check 1, 0, +0xfffffffffffffffe;
check 1, 0, +0xffffffffffffffff;

# negative integers

check 1, 1, -0xfffe;
check 1, 1, -0xffff;
check 1, 1, -0x10000;
check 1, 1, -0x10001;
check 1, 1, -0x10002;

check 1, 1, -0xfffffe;
check 1, 1, -0xffffff;
check 1, 1, -0x1000000;
check 1, 1, -0x1000001;
check 1, 1, -0x1000002;

check 1, 1, -0x7ffffffe;
check 1, 1, -0x7fffffff;
check 1, 1, -0x80000000;
check 1, 1, -0x80000001;
check 1, 1, -0x80000002;

check 1, 1, -0xfffffffe;
check 1, 1, -0xffffffff;
check 1, 1, -0x100000000;
check 1, 1, -0x100000001;
check 1, 1, -0x100000002;

check 1, 1, -0x1fffffffe;
check 1, 1, -0x1ffffffff;
check 1, 1, -0x200000000;
check 1, 1, -0x200000001;
check 1, 1, -0x200000002;

check 1, 1, -0xffffffffffffe;
check 1, 1, -0xfffffffffffff;
check 1, 1, -0x10000000000000;
check 1, 1, -0x10000000000001;
check 1, 1, -0x10000000000002;

check 1, 1, -0x1ffffffffffffe;
check 1, 1, -0x1fffffffffffff;
check 1, 1, -0x20000000000000;
check 1, 0, -0x20000000000001;
check 1, 1, -0x20000000000002;
check 1, 0, -0x20000000000003;
check 1, 1, -0x20000000000004;

check 1, 1, -0x3ffffffffffffc;
check 1, 0, -0x3ffffffffffffd;
check 1, 1, -0x3ffffffffffffe;
check 1, 0, -0x3fffffffffffff;
check 1, 1, -0x40000000000000;
check 1, 0, -0x40000000000001;
check 1, 0, -0x40000000000002;
check 1, 1, -0x40000000000004;
check 1, 0, -0x40000000000006;
check 1, 1, -0x40000000000008;

check 1, 1, -0x7ffffffffffff800;
check 1, 0, -0x7ffffffffffffa00;
check 1, 1, -0x7ffffffffffffc00;
check 1, 0, -0x7ffffffffffffe00;
check 1, 0, -0x7ffffffffffffffe;
check 1, 0, -0x7fffffffffffffff;
check 1, 1, -0x8000000000000000;

# positive floats

check 1, 1, hex_float("+0x1.fffc000000000p+15");
check 0, 1, hex_float("+0x1.fffd000000000p+15");
check 1, 1, hex_float("+0x1.fffe000000000p+15");
check 0, 1, hex_float("+0x1.ffff000000000p+15");
check 0, 1, hex_float("+0x1.fffffffffffffp+15");
check 1, 1, hex_float("+0x1.0000000000000p+16");
check 0, 1, hex_float("+0x1.0000000000001p+16");
check 0, 1, hex_float("+0x1.0000800000000p+16");
check 1, 1, hex_float("+0x1.0001000000000p+16");
check 0, 1, hex_float("+0x1.0001800000000p+16");
check 1, 1, hex_float("+0x1.0002000000000p+16");

check 1, 1, hex_float("+0x1.fffffc0000000p+23");
check 0, 1, hex_float("+0x1.fffffd0000000p+23");
check 1, 1, hex_float("+0x1.fffffe0000000p+23");
check 0, 1, hex_float("+0x1.ffffff0000000p+23");
check 0, 1, hex_float("+0x1.fffffffffffffp+23");
check 1, 1, hex_float("+0x1.0000000000000p+24");
check 0, 1, hex_float("+0x1.0000000000001p+24");
check 0, 1, hex_float("+0x1.0000008000000p+24");
check 1, 1, hex_float("+0x1.0000010000000p+24");
check 0, 1, hex_float("+0x1.0000018000000p+24");
check 1, 1, hex_float("+0x1.0000020000000p+24");

check 1, 1, hex_float("+0x1.fffffff800000p+30");
check 0, 1, hex_float("+0x1.fffffffa00000p+30");
check 1, 1, hex_float("+0x1.fffffffc00000p+30");
check 0, 1, hex_float("+0x1.fffffffe00000p+30");
check 0, 1, hex_float("+0x1.fffffffffffffp+30");
check 1, 1, hex_float("+0x1.0000000000000p+31");
check 0, 1, hex_float("+0x1.0000000000001p+31");
check 0, 1, hex_float("+0x1.0000000100000p+31");
check 1, 1, hex_float("+0x1.0000000200000p+31");
check 0, 1, hex_float("+0x1.0000000300000p+31");
check 1, 1, hex_float("+0x1.0000000400000p+31");

check 1, 1, hex_float("+0x1.fffffffc00000p+31");
check 0, 1, hex_float("+0x1.fffffffd00000p+31");
check 1, 1, hex_float("+0x1.fffffffe00000p+31");
check 0, 1, hex_float("+0x1.ffffffff00000p+31");
check 0, 1, hex_float("+0x1.fffffffffffffp+31");
check 1, 1, hex_float("+0x1.0000000000000p+32");
check 0, 1, hex_float("+0x1.0000000000001p+32");
check 0, 1, hex_float("+0x1.0000000080000p+32");
check 1, 1, hex_float("+0x1.0000000100000p+32");
check 0, 1, hex_float("+0x1.0000000180000p+32");
check 1, 1, hex_float("+0x1.0000000200000p+32");

check 1, 1, hex_float("+0x1.fffffffe00000p+32");
check 0, 1, hex_float("+0x1.fffffffe80000p+32");
check 1, 1, hex_float("+0x1.ffffffff00000p+32");
check 0, 1, hex_float("+0x1.ffffffff80000p+32");
check 0, 1, hex_float("+0x1.fffffffffffffp+32");
check 1, 1, hex_float("+0x1.0000000000000p+33");
check 0, 1, hex_float("+0x1.0000000000001p+33");
check 0, 1, hex_float("+0x1.0000000040000p+33");
check 1, 1, hex_float("+0x1.0000000080000p+33");
check 0, 1, hex_float("+0x1.00000000c0000p+33");
check 1, 1, hex_float("+0x1.0000000100000p+33");

check 1, 1, hex_float("+0x1.ffffffffffffcp+51");
check 0, 1, hex_float("+0x1.ffffffffffffdp+51");
check 1, 1, hex_float("+0x1.ffffffffffffep+51");
check 0, 1, hex_float("+0x1.fffffffffffffp+51");
check 1, 1, hex_float("+0x1.0000000000000p+52");
check 1, 1, hex_float("+0x1.0000000000001p+52");
check 1, 1, hex_float("+0x1.0000000000002p+52");

check 1, 1, hex_float("+0x1.ffffffffffffep+52");
check 1, 1, hex_float("+0x1.fffffffffffffp+52");
check 1, 1, hex_float("+0x1.0000000000000p+53");
check 1, 1, hex_float("+0x1.0000000000001p+53");
check 1, 1, hex_float("+0x1.0000000000002p+53");

check 1, 1, hex_float("+0x1.ffffffffffffep+62");
check 1, 1, hex_float("+0x1.fffffffffffffp+62");
check 1, 1, hex_float("+0x1.0000000000000p+63");
check 1, 1, hex_float("+0x1.0000000000001p+63");
check 1, 1, hex_float("+0x1.0000000000002p+63");

check 1, 1, hex_float("+0x1.ffffffffffffep+63");
check 1, 1, hex_float("+0x1.fffffffffffffp+63");
check 0, 1, hex_float("+0x1.0000000000000p+64");
check 0, 1, hex_float("+0x1.0000000000001p+64");
check 0, 1, hex_float("+0x1.0000000000002p+64");

check 0, 1, hex_float("+0x1.ffffffffffffep+64");
check 0, 1, hex_float("+0x1.fffffffffffffp+64");
check 0, 1, hex_float("+0x1.0000000000000p+65");
check 0, 1, hex_float("+0x1.0000000000001p+65");
check 0, 1, hex_float("+0x1.0000000000002p+65");

# negative floats

check 1, 1, hex_float("-0x1.fffc000000000p+15");
check 0, 1, hex_float("-0x1.fffd000000000p+15");
check 1, 1, hex_float("-0x1.fffe000000000p+15");
check 0, 1, hex_float("-0x1.ffff000000000p+15");
check 0, 1, hex_float("-0x1.fffffffffffffp+15");
check 1, 1, hex_float("-0x1.0000000000000p+16");
check 0, 1, hex_float("-0x1.0000000000001p+16");
check 0, 1, hex_float("-0x1.0000800000000p+16");
check 1, 1, hex_float("-0x1.0001000000000p+16");
check 0, 1, hex_float("-0x1.0001800000000p+16");
check 1, 1, hex_float("-0x1.0002000000000p+16");

check 1, 1, hex_float("-0x1.fffffc0000000p+23");
check 0, 1, hex_float("-0x1.fffffd0000000p+23");
check 1, 1, hex_float("-0x1.fffffe0000000p+23");
check 0, 1, hex_float("-0x1.ffffff0000000p+23");
check 0, 1, hex_float("-0x1.fffffffffffffp+23");
check 1, 1, hex_float("-0x1.0000000000000p+24");
check 0, 1, hex_float("-0x1.0000000000001p+24");
check 0, 1, hex_float("-0x1.0000008000000p+24");
check 1, 1, hex_float("-0x1.0000010000000p+24");
check 0, 1, hex_float("-0x1.0000018000000p+24");
check 1, 1, hex_float("-0x1.0000020000000p+24");

check 1, 1, hex_float("-0x1.fffffff800000p+30");
check 0, 1, hex_float("-0x1.fffffffa00000p+30");
check 1, 1, hex_float("-0x1.fffffffc00000p+30");
check 0, 1, hex_float("-0x1.fffffffe00000p+30");
check 0, 1, hex_float("-0x1.fffffffffffffp+30");
check 1, 1, hex_float("-0x1.0000000000000p+31");
check 0, 1, hex_float("-0x1.0000000000001p+31");
check 0, 1, hex_float("-0x1.0000000100000p+31");
check 1, 1, hex_float("-0x1.0000000200000p+31");
check 0, 1, hex_float("-0x1.0000000300000p+31");
check 1, 1, hex_float("-0x1.0000000400000p+31");

check 1, 1, hex_float("-0x1.fffffffc00000p+31");
check 0, 1, hex_float("-0x1.fffffffd00000p+31");
check 1, 1, hex_float("-0x1.fffffffe00000p+31");
check 0, 1, hex_float("-0x1.ffffffff00000p+31");
check 0, 1, hex_float("-0x1.fffffffffffffp+31");
check 1, 1, hex_float("-0x1.0000000000000p+32");
check 0, 1, hex_float("-0x1.0000000000001p+32");
check 0, 1, hex_float("-0x1.0000000080000p+32");
check 1, 1, hex_float("-0x1.0000000100000p+32");
check 0, 1, hex_float("-0x1.0000000180000p+32");
check 1, 1, hex_float("-0x1.0000000200000p+32");

check 1, 1, hex_float("-0x1.fffffffe00000p+32");
check 0, 1, hex_float("-0x1.fffffffe80000p+32");
check 1, 1, hex_float("-0x1.ffffffff00000p+32");
check 0, 1, hex_float("-0x1.ffffffff80000p+32");
check 0, 1, hex_float("-0x1.fffffffffffffp+32");
check 1, 1, hex_float("-0x1.0000000000000p+33");
check 0, 1, hex_float("-0x1.0000000000001p+33");
check 0, 1, hex_float("-0x1.0000000040000p+33");
check 1, 1, hex_float("-0x1.0000000080000p+33");
check 0, 1, hex_float("-0x1.00000000c0000p+33");
check 1, 1, hex_float("-0x1.0000000100000p+33");

check 1, 1, hex_float("-0x1.ffffffffffffcp+51");
check 0, 1, hex_float("-0x1.ffffffffffffdp+51");
check 1, 1, hex_float("-0x1.ffffffffffffep+51");
check 0, 1, hex_float("-0x1.fffffffffffffp+51");
check 1, 1, hex_float("-0x1.0000000000000p+52");
check 1, 1, hex_float("-0x1.0000000000001p+52");
check 1, 1, hex_float("-0x1.0000000000002p+52");

check 1, 1, hex_float("-0x1.ffffffffffffep+52");
check 1, 1, hex_float("-0x1.fffffffffffffp+52");
check 1, 1, hex_float("-0x1.0000000000000p+53");
check 1, 1, hex_float("-0x1.0000000000001p+53");
check 1, 1, hex_float("-0x1.0000000000002p+53");

check 1, 1, hex_float("-0x1.ffffffffffffep+62");
check 1, 1, hex_float("-0x1.fffffffffffffp+62");
check 1, 1, hex_float("-0x1.0000000000000p+63");
check 0, 1, hex_float("-0x1.0000000000001p+63");
check 0, 1, hex_float("-0x1.0000000000002p+63");

check 0, 1, hex_float("-0x1.ffffffffffffep+63");
check 0, 1, hex_float("-0x1.fffffffffffffp+63");
check 0, 1, hex_float("-0x1.0000000000000p+64");
check 0, 1, hex_float("-0x1.0000000000001p+64");
check 0, 1, hex_float("-0x1.0000000000002p+64");

check 0, 1, hex_float("-0x1.ffffffffffffep+64");
check 0, 1, hex_float("-0x1.fffffffffffffp+64");
check 0, 1, hex_float("-0x1.0000000000000p+65");
check 0, 1, hex_float("-0x1.0000000000001p+65");
check 0, 1, hex_float("-0x1.0000000000002p+65");

1;
