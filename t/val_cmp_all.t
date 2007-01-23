use Test::More tests => 257;

use Data::Float 0.000 qw(have_infinite have_signed_zero have_nan pow2);

BEGIN { use_ok "Scalar::Number", qw(sclnum_val_cmp); }

my @values = (
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

SKIP: {
	skip "NaN not available", 31 unless have_nan;
	my $nan = &{"Data::Float::nan"};
	is sclnum_val_cmp($nan, $nan), undef;
	foreach(@values) {
		SKIP: {
			skip "special value not available", 2 unless defined;
			is sclnum_val_cmp($nan, $_), undef;
			is sclnum_val_cmp($_, $nan), undef;
		}
	}
}

for(my $ia = @values; $ia--; ) {
	for(my $ib = @values; $ib--; ) {
		SKIP: {
			my $a = $values[$ia];
			my $b = $values[$ib];
			skip "special value not available", 1
				unless defined($a) && defined($b);
			my $expect = ($ia <=> $ib);
			$expect = 0
				if $ia >= 6 && $ia < 9 && $ib >= 6 && $ib < 9;
			is sclnum_val_cmp($a, $b), $expect;
		}
	}
}
