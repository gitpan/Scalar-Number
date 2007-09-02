use Test::More;

use Data::Integer 0.000 qw(natint_bits);
use Data::Float 0.005 qw(significand_bits hex_float);

plan skip_all => "tests not designed for these word sizes"
	unless natint_bits == 32 && significand_bits == 52;
plan tests => 301;

require_ok "Scalar::Number";
Scalar::Number->import(qw(sclnum_is_natint sclnum_is_float));

sub check($$$) {
	my($expect_natint, $expect_float, $value) = @_;
	my $desc = eval { sprintf(" of %s (%.1f)",
				my $sval = $value, my $fval = $value) } || "";
	is !!sclnum_is_natint($value), !!$expect_natint, "integer status$desc";
	is !!sclnum_is_float($value), !!$expect_float, "float status$desc";
}

eval do { local $/; <DATA>; } or die $@;
__DATA__
local $SIG{__DIE__};

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
check 0, 1, hex_float("+0x1.0000000000000p+32");
check 0, 1, hex_float("+0x1.0000000000001p+32");
check 0, 1, hex_float("+0x1.0000000080000p+32");
check 0, 1, hex_float("+0x1.0000000100000p+32");
check 0, 1, hex_float("+0x1.0000000180000p+32");
check 0, 1, hex_float("+0x1.0000000200000p+32");

check 0, 1, hex_float("+0x1.fffffffe00000p+32");
check 0, 1, hex_float("+0x1.ffffffff00000p+32");
check 0, 1, hex_float("+0x1.fffffffffffffp+32");
check 0, 1, hex_float("+0x1.0000000000000p+33");
check 0, 1, hex_float("+0x1.0000000000001p+33");
check 0, 1, hex_float("+0x1.0000000080000p+33");
check 0, 1, hex_float("+0x1.0000000100000p+33");

check 0, 1, hex_float("+0x1.ffffffffffffcp+51");
check 0, 1, hex_float("+0x1.ffffffffffffep+51");
check 0, 1, hex_float("+0x1.fffffffffffffp+51");
check 0, 1, hex_float("+0x1.0000000000000p+52");
check 0, 1, hex_float("+0x1.0000000000001p+52");
check 0, 1, hex_float("+0x1.0000000000002p+52");

check 0, 1, hex_float("+0x1.ffffffffffffep+52");
check 0, 1, hex_float("+0x1.fffffffffffffp+52");
check 0, 1, hex_float("+0x1.0000000000000p+53");
check 0, 1, hex_float("+0x1.0000000000001p+53");
check 0, 1, hex_float("+0x1.0000000000002p+53");

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
check 0, 1, hex_float("-0x1.0000000200000p+31");
check 0, 1, hex_float("-0x1.0000000300000p+31");
check 0, 1, hex_float("-0x1.0000000400000p+31");

check 0, 1, hex_float("-0x1.fffffffc00000p+31");
check 0, 1, hex_float("-0x1.fffffffe00000p+31");
check 0, 1, hex_float("-0x1.fffffffffffffp+31");
check 0, 1, hex_float("-0x1.0000000000000p+32");
check 0, 1, hex_float("-0x1.0000000000001p+32");
check 0, 1, hex_float("-0x1.0000000100000p+32");
check 0, 1, hex_float("-0x1.0000000200000p+32");

check 0, 1, hex_float("-0x1.fffffffe00000p+32");
check 0, 1, hex_float("-0x1.ffffffff00000p+32");
check 0, 1, hex_float("-0x1.fffffffffffffp+32");
check 0, 1, hex_float("-0x1.0000000000000p+33");
check 0, 1, hex_float("-0x1.0000000000001p+33");
check 0, 1, hex_float("-0x1.0000000080000p+33");
check 0, 1, hex_float("-0x1.0000000100000p+33");

check 0, 1, hex_float("-0x1.ffffffffffffcp+51");
check 0, 1, hex_float("-0x1.ffffffffffffep+51");
check 0, 1, hex_float("-0x1.fffffffffffffp+51");
check 0, 1, hex_float("-0x1.0000000000000p+52");
check 0, 1, hex_float("-0x1.0000000000001p+52");
check 0, 1, hex_float("-0x1.0000000000002p+52");

check 0, 1, hex_float("-0x1.ffffffffffffep+52");
check 0, 1, hex_float("-0x1.fffffffffffffp+52");
check 0, 1, hex_float("-0x1.0000000000000p+53");
check 0, 1, hex_float("-0x1.0000000000001p+53");
check 0, 1, hex_float("-0x1.0000000000002p+53");

1;
