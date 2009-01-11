use strict;
use warnings;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME                => 'Catalyst::View::JavaScript',
    AUTHOR              => 'Moritz Onken <onken@houseofdesign.de>',
    VERSION_FROM        => 'lib/Catalyst/View/JavaScript.pm',
    ABSTRACT_FROM       => 'lib/Catalyst/View/JavaScript.pm',
    PL_FILES            => {},
    PREREQ_PM => {
        'Test::More' => 0,
	'JavaScript::Minifier::XS' => 0,
	'Catalyst::Runtime' => 0,
	'Test::WWW::Mechanize::Catalyst' => 0,
    },
    dist                => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
    clean               => { FILES => 'Catalyst-View-JavaScript-*' },
);
