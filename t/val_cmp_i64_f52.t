use Test::More;

use Data::Integer 0.000 qw(natint_bits);
use Data::Float 0.005 qw(have_nan significand_bits hex_float);

plan skip_all => "tests not designed for these word sizes"
	unless natint_bits == 64 && significand_bits == 52;
plan tests => 24649;
require_ok "Scalar::Number";
Scalar::Number->import(qw(sclnum_val_cmp));

eval do { local $/; <DATA>; } or die $@;
__DATA__
local $SIG{__DIE__};

no warnings "portable";

my @values = (
	# around -2^65
	hex_float("-0x20000000000004000"),
	hex_float("-0x20000000000002000"),
	hex_float("-0x20000000000000000"),
	hex_float("-0x1fffffffffffff000"),
	hex_float("-0x1ffffffffffffe000"),

	# around -2^64
	hex_float("-0x10000000000002000"),
	hex_float("-0x10000000000001000"),
	hex_float("-0x10000000000000000"),
	hex_float("-0xfffffffffffff800"),
	hex_float("-0xfffffffffffff000"),

	# around -2^63
	hex_float("-0x8000000000001000"),
	hex_float("-0x8000000000000800"),
	hex_float("-0x8000000000000000"),
	-0x7fffffffffffffff,
	-0x7ffffffffffffffe,
	hex_float("-0x7ffffffffffffc00"),
	hex_float("-0x7ffffffffffff800"),

	# around -2^53
	hex_float("-0x20000000000004"),
	-0x20000000000003,
	hex_float("-0x20000000000002"),
	-0x20000000000001,
	hex_float("-0x20000000000000"),
	hex_float("-0x1fffffffffffff"),
	hex_float("-0x1ffffffffffffe"),

	# around -2^52
	hex_float("-0x10000000000002"),
	hex_float("-0x10000000000001"),
	hex_float("-0x10000000000000"),
	hex_float("-0xfffffffffffff.8"),
	hex_float("-0xfffffffffffff.0"),
	hex_float("-0xffffffffffffe.8"),
	hex_float("-0xffffffffffffe.0"),

	# around -2^33
	hex_float("-0x200000002.0"),
	hex_float("-0x200000001.8"),
	hex_float("-0x200000001.0"),
	hex_float("-0x200000000.8"),
	hex_float("-0x200000000.0"),
	hex_float("-0x1ffffffff.8"),
	hex_float("-0x1ffffffff.0"),
	hex_float("-0x1fffffffe.8"),
	hex_float("-0x1fffffffe.0"),

	# around -2^32
	hex_float("-0x100000002.0"),
	hex_float("-0x100000001.8"),
	hex_float("-0x100000001.0"),
	hex_float("-0x100000000.8"),
	hex_float("-0x100000000.0"),
	hex_float("-0xffffffff.8"),
	hex_float("-0xffffffff.0"),
	hex_float("-0xfffffffe.8"),
	hex_float("-0xfffffffe.0"),

	# around -2^31
	hex_float("-0x80000002.0"),
	hex_float("-0x80000001.8"),
	hex_float("-0x80000001.0"),
	hex_float("-0x80000000.8"),
	hex_float("-0x80000000.0"),
	hex_float("-0x7fffffff.8"),
	hex_float("-0x7fffffff.0"),
	hex_float("-0x7ffffffe.8"),
	hex_float("-0x7ffffffe.0"),

	# around -2^24
	hex_float("-0x1000002.0"),
	hex_float("-0x1000001.8"),
	hex_float("-0x1000001.0"),
	hex_float("-0x1000000.8"),
	hex_float("-0x1000000.0"),
	hex_float("-0xffffff.8"),
	hex_float("-0xffffff.0"),
	hex_float("-0xfffffe.8"),
	hex_float("-0xfffffe.0"),

	# around -2^16
	hex_float("-0x10002.0"),
	hex_float("-0x10001.8"),
	hex_float("-0x10001.0"),
	hex_float("-0x10000.8"),
	hex_float("-0x10000.0"),
	hex_float("-0xffff.8"),
	hex_float("-0xffff.0"),
	hex_float("-0xfffe.8"),
	hex_float("-0xfffe.0"),


	# around +2^16
	hex_float("+0xfffe.0"),
	hex_float("+0xfffe.8"),
	hex_float("+0xffff.0"),
	hex_float("+0xffff.8"),
	hex_float("+0x10000.0"),
	hex_float("+0x10000.8"),
	hex_float("+0x10001.0"),
	hex_float("+0x10001.8"),
	hex_float("+0x10002.0"),

	# around +2^24
	hex_float("+0xfffffe.0"),
	hex_float("+0xfffffe.8"),
	hex_float("+0xffffff.0"),
	hex_float("+0xffffff.8"),
	hex_float("+0x1000000.0"),
	hex_float("+0x1000000.8"),
	hex_float("+0x1000001.0"),
	hex_float("+0x1000001.8"),
	hex_float("+0x1000002.0"),

	# around +2^31
	hex_float("+0x7ffffffe.0"),
	hex_float("+0x7ffffffe.8"),
	hex_float("+0x7fffffff.0"),
	hex_float("+0x7fffffff.8"),
	hex_float("+0x80000000.0"),
	hex_float("+0x80000000.8"),
	hex_float("+0x80000001.0"),
	hex_float("+0x80000001.8"),
	hex_float("+0x80000002.0"),

	# around +2^32
	hex_float("+0xfffffffe.0"),
	hex_float("+0xfffffffe.8"),
	hex_float("+0xffffffff.0"),
	hex_float("+0xffffffff.8"),
	hex_float("+0x100000000.0"),
	hex_float("+0x100000000.8"),
	hex_float("+0x100000001.0"),
	hex_float("+0x100000001.8"),
	hex_float("+0x100000002.0"),

	# around +2^33
	hex_float("+0x1fffffffe.0"),
	hex_float("+0x1fffffffe.8"),
	hex_float("+0x1ffffffff.0"),
	hex_float("+0x1ffffffff.8"),
	hex_float("+0x200000000.0"),
	hex_float("+0x200000000.8"),
	hex_float("+0x200000001.0"),
	hex_float("+0x200000001.8"),
	hex_float("+0x200000002.0"),

	# around +2^52
	hex_float("+0xffffffffffffe.0"),
	hex_float("+0xffffffffffffe.8"),
	hex_float("+0xfffffffffffff.0"),
	hex_float("+0xfffffffffffff.8"),
	hex_float("+0x10000000000000"),
	hex_float("+0x10000000000001"),
	hex_float("+0x10000000000002"),

	# around +2^53
	hex_float("+0x1ffffffffffffe"),
	hex_float("+0x1fffffffffffff"),
	hex_float("+0x20000000000000"),
	+0x20000000000001,
	hex_float("+0x20000000000002"),
	+0x20000000000003,
	hex_float("+0x20000000000004"),

	# around +2^63
	hex_float("+0x7ffffffffffff800"),
	hex_float("+0x7ffffffffffffc00"),
	+0x7ffffffffffffffe,
	+0x7fffffffffffffff,
	hex_float("+0x8000000000000000"),
	+0x8000000000000001,
	+0x8000000000000002,
	hex_float("+0x8000000000000800"),
	hex_float("+0x8000000000001000"),

	# around +2^64
	hex_float("+0xfffffffffffff000"),
	hex_float("+0xfffffffffffff800"),
	+0xfffffffffffffffe,
	+0xffffffffffffffff,
	hex_float("+0x10000000000000000"),
	hex_float("+0x10000000000001000"),
	hex_float("+0x10000000000002000"),

	# around +2^65
	hex_float("+0x1ffffffffffffe000"),
	hex_float("+0x1fffffffffffff000"),
	hex_float("+0x20000000000000000"),
	hex_float("+0x20000000000002000"),
	hex_float("+0x20000000000004000"),
);

SKIP: {
	skip "NaN not available", 2*@values unless have_nan;
	my $nan = &{"Data::Float::nan"};
	foreach(@values) {
		is sclnum_val_cmp($nan, $_), undef;
		is sclnum_val_cmp($_, $nan), undef;
	}
}

for(my $ia = @values; $ia--; ) {
	for(my $ib = @values; $ib--; ) {
		SKIP: {
			my $a = $values[$ia];
			my $b = $values[$ib];
			skip "special value not available", 1
				unless defined($a) && defined($b);
			is sclnum_val_cmp($a, $b), ($ia <=> $ib),
				eval { sprintf("%s (%.1f) <=> %s (%.1f)",
						$a, $a, $b, $b) } || "";
		}
	}
}

1;
