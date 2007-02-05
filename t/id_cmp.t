use Test::More tests => 353;

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
			my $a_is_z = ($ia >= 7 && $ia < 10) ? 1 : 0;
			my $b_is_z = ($ib >= 7 && $ib < 10) ? 1 : 0;
			skip "special value not available", 1+$a_is_z+$b_is_z
				unless defined($a) && defined($b);
			my $na = $a;
			my $nb = $b;
			is sclnum_id_cmp($a, $b), ($ia <=> $ib);
			is sprintf("%+.f%+.f%+.f", $a, -$a, - -$a),
			   sprintf("%+.f%+.f%+.f", $na, -$na, - -$na)
				if $a_is_z;
			is sprintf("%+.f%+.f%+.f", $b, -$b, - -$b),
			   sprintf("%+.f%+.f%+.f", $nb, -$nb, - -$nb)
				if $b_is_z;
		}
	}
}
