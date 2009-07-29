
use strict;
use warnings;

use ExtUtils::MakeMaker;

WriteMakefile(
  DISTNAME  => 'Catalyst-View-JavaScript',
  NAME      => 'Catalyst::View::JavaScript',
  AUTHOR    => 'Moritz\ Onken\ \<onken\@netcubed\.de\>',
  ABSTRACT  => 'Cache\ and\/or\ compress\ JavaScript\ output',
  VERSION   => '0.991',
  EXE_FILES => [ qw() ],
  (eval { ExtUtils::MakeMaker->VERSION(6.31) } ? (LICENSE => 'perl') : ()),
  PREREQ_PM    => {
    "JavaScript::Minifier::XS" => '> 0',
    "Test::WWW::Mechanize::Catalyst" => '> 0',
    "Catalyst::Runtime" => '0',
    "Class::C3" => '0',
  },
);
