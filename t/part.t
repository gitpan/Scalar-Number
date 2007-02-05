use Test::More tests => 21;

BEGIN { use_ok "Scalar::Number", qw(scalar_num_part sclnum_id_cmp); }

sub match($$) {
	ok sclnum_id_cmp(scalar_num_part($_[0]), $_[1]) == 0;
}

match 0, 0;
match +0.0, +0.0;
match -0.0, -0.0;
match 1, 1;
match 1.5, 1.5;
match -3, -3;
match -3.25, -3.25;
match "123abc", 123;
match "1.25", 1.25;

ok scalar_num_part("00") == 0;
ok scalar_num_part("0 but true") == 0;
ok scalar_num_part("xyz") == 0;

SKIP: {
	eval { require Scalar::Util };
	skip "dualvar() not available", 5 if $@ ne "";
	match Scalar::Util::dualvar(123, "xyz"), 123;
	match Scalar::Util::dualvar(123, "456"), 123;
	match Scalar::Util::dualvar(0, "456"), Scalar::Util::dualvar(0, 0);
	match Scalar::Util::dualvar(+0.0, "456"),
		Scalar::Util::dualvar(+0.0, +0.0);
	match Scalar::Util::dualvar(-0.0, "456"),
		Scalar::Util::dualvar(-0.0, -0.0);
}

foreach my $nzero (0, +0.0, -0.0) {
	my $tzero = $nzero;
	scalar_num_part($tzero);
	is sprintf("%+.f%+.f%+.f", $tzero, -$tzero, - -$tzero),
	   sprintf("%+.f%+.f%+.f", $nzero, -$nzero, - -$nzero);
}
