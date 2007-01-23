use Test::More tests => 25;

use Data::Float 0.000 qw(have_signed_zero have_nan have_infinite);

BEGIN { use_ok "Scalar::Number", qw(sclnum_is_natint sclnum_is_float); }

sub check($$$) {
	my($expect_natint, $expect_float, $value) = @_;
	my $desc = sprintf("status of %s (%.1f)", my $cval = $value, $value);
	is !!sclnum_is_natint($value), !!$expect_natint, "integer $desc";
	is !!sclnum_is_float($value), !!$expect_float, "float $desc";
}

if(have_signed_zero) {
	check 1, 0, 0;
	check 0, 1, +0.0;
	check 0, 1, -0.0;
} else {
	check 1, 1, 0;
	SKIP: { skip "no signed zeroes", 4; }
}

SKIP: {
	skip "no NaN available", 2 unless have_nan;
	check 0, 1, Data::Float::nan;
}

SKIP: {
	skip "no infinities", 4 unless have_infinite;
	check 0, 1, Data::Float::pos_infinity;
	check 0, 1, Data::Float::neg_infinity;
}

check 1, 1, 1;
check 1, 1, -1;
check 0, 1, 0.5;
check 0, 1, -0.5;
check 0, 1, 1.5;
check 0, 1, -1.5;
