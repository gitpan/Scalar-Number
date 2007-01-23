use ExtUtils::MakeMaker;

WriteMakefile(
	NAME => "Scalar::Number",
	VERSION_FROM => "lib/Scalar/Number.pm",
	PREREQ_PM => {
		Data::Float => "0.004",
		Data::Integer => "0.000",
	},
);
