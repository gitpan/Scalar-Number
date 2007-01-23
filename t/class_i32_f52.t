use Test::More;

use Data::Integer 0.000 qw(natint_bits);
use Data::Float 0.000 qw(significand_bits);

plan skip_all => "tests not designed for these word sizes"
	unless natint_bits == 32 && significand_bits == 52;
plan tests => 251;

require_ok "Scalar::Number";
Scalar::Number->import(qw(sclnum_is_natint sclnum_is_float));

sub check($$$) {
	my($expect_natint, $expect_float, $value) = @_;
	my $desc = sprintf("status of %s (%.1f)", my $cval = $value, $value);
	is !!sclnum_is_natint($value), !!$expect_natint, "integer $desc";
	is !!sclnum_is_float($value), !!$expect_float, "float $desc";
}

check 0, 1, -1.5;

# around +2^16
check 1, 1, +65534;
check 0, 1, +65534.5;
check 1, 1, +65535;
check 0, 1, +65535.5;
check 1, 1, +65536;
check 0, 1, +65536.5;
check 1, 1, +65537;
check 0, 1, +65537.5;

# around -2^16
check 1, 1, -65534;
check 0, 1, -65534.5;
check 1, 1, -65535;
check 0, 1, -65535.5;
check 1, 1, -65536;
check 0, 1, -65536.5;
check 1, 1, -65537;
check 0, 1, -65537.5;

# around +2^24
check 1, 1, +16777214;
check 0, 1, +16777214.5;
check 1, 1, +16777215;
check 0, 1, +16777215.5;
check 1, 1, +16777216;
check 0, 1, +16777216.5;
check 1, 1, +16777217;
check 0, 1, +16777217.5;

# around -2^24
check 1, 1, -16777214;
check 0, 1, -16777214.5;
check 1, 1, -16777215;
check 0, 1, -16777215.5;
check 1, 1, -16777216;
check 0, 1, -16777216.5;
check 1, 1, -16777217;
check 0, 1, -16777217.5;

# around +2^31
check 1, 1, +2147483646;
check 0, 1, +2147483646.5;
check 1, 1, +2147483647;
check 0, 1, +2147483647.5;
check 1, 1, +2147483648;
check 0, 1, +2147483648.5;
check 1, 1, +2147483649;
check 0, 1, +2147483649.5;

# around -2^31
check 1, 1, -2147483646;
check 0, 1, -2147483646.5;
check 1, 1, -2147483647;
check 0, 1, -2147483647.5;
check 1, 1, -2147483648;
check 0, 1, -2147483648.5;
check 0, 1, -2147483649;
check 0, 1, -2147483649.5;

# around +2^32
check 1, 1, +4294967294;
check 0, 1, +4294967294.5;
check 1, 1, +4294967295;
check 0, 1, +4294967295.5;
check 0, 1, +4294967296;
check 0, 1, +4294967296.5;
check 0, 1, +4294967297;
check 0, 1, +4294967297.5;

# around -2^32
check 0, 1, -4294967294;
check 0, 1, -4294967294.5;
check 0, 1, -4294967295;
check 0, 1, -4294967295.5;
check 0, 1, -4294967296;
check 0, 1, -4294967296.5;
check 0, 1, -4294967297;
check 0, 1, -4294967297.5;

# around +2^33
check 0, 1, +8589934590;
check 0, 1, +8589934590.5;
check 0, 1, +8589934591;
check 0, 1, +8589934591.5;
check 0, 1, +8589934592;
check 0, 1, +8589934592.5;
check 0, 1, +8589934593;
check 0, 1, +8589934593.5;

# around -2^33
check 0, 1, -8589934590;
check 0, 1, -8589934590.5;
check 0, 1, -8589934591;
check 0, 1, -8589934591.5;
check 0, 1, -8589934592;
check 0, 1, -8589934592.5;
check 0, 1, -8589934593;
check 0, 1, -8589934593.5;

# around +2^51
check 0, 1, +2251799813685246;
check 0, 1, +2251799813685246.5;
check 0, 1, +2251799813685247;
check 0, 1, +2251799813685247.5;
check 0, 1, +2251799813685248;
check 0, 1, +2251799813685248.5;
check 0, 1, +2251799813685249;
check 0, 1, +2251799813685249.5;

# around -2^51
check 0, 1, -2251799813685246;
check 0, 1, -2251799813685246.5;
check 0, 1, -2251799813685247;
check 0, 1, -2251799813685247.5;
check 0, 1, -2251799813685248;
check 0, 1, -2251799813685248.5;
check 0, 1, -2251799813685249;
check 0, 1, -2251799813685249.5;

# around +2^52
check 0, 1, +4503599627370494;
check 0, 1, +4503599627370494.5;
check 0, 1, +4503599627370495;
check 0, 1, +4503599627370495.5;
check 0, 1, +4503599627370496;
check 0, 1, +4503599627370497;

# around -2^52
check 0, 1, -4503599627370494;
check 0, 1, -4503599627370494.5;
check 0, 1, -4503599627370495;
check 0, 1, -4503599627370495.5;
check 0, 1, -4503599627370496;
check 0, 1, -4503599627370497;

# around +2^53
check 0, 1, +9007199254740990;
check 0, 1, +9007199254740991;
check 0, 1, +9007199254740992;
check 0, 1, +9007199254740994;

# around -2^53
check 0, 1, -9007199254740990;
check 0, 1, -9007199254740991;
check 0, 1, -9007199254740992;
check 0, 1, -9007199254740994;

# around +2^54
check 0, 1, +18014398509481980;
check 0, 1, +18014398509481982;
check 0, 1, +18014398509481984;
check 0, 1, +18014398509481988;

# around -2^54
check 0, 1, -18014398509481980;
check 0, 1, -18014398509481982;
check 0, 1, -18014398509481984;
check 0, 1, -18014398509481988;
