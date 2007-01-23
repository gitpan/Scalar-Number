use Test::More tests => 257;

use Data::Float 0.000 qw(have_infinite have_signed_zero have_nan pow2);

BEGIN { use_ok "Scalar::Number", qw(sclnum_id_cmp); }

my @values = (
	sub { have_nan ? &{"Data::Float::nan"} : undef },
	sub { have_infinite ? &{"Data::Float::neg_infinity"} : undef },
	-pow2(100),
	-1000,
	-123.25,
	-1,
	-0.125,
	sub { have_signed_zero ? &{"Data::Float::neg_zero"} : undef },
	0,
	sub { have_signed_zero ? &{"Data::Float::pos_zero"} : undef },
	+0.125,
	+1,
	+123.25,
	+1000,
	+pow2(100),
	sub { have_infinite ? &{"Data::Float::pos_infinity"} : undef },
);

foreach(@values) {
	$_ = $_->() if ref($_) eq "CODE";
}

for(my $ia = @values; $ia--; ) {
	for(my $ib = @values; $ib--; ) {
		SKIP: {
			my $a = $values[$ia];
			my $b = $values[$ib];
			skip "special value not available", 1
				unless defined($a) && defined($b);
			is sclnum_id_cmp($a, $b), ($ia <=> $ib);
		}
	}
}
