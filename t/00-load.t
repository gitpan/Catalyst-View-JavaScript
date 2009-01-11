#!perl -T

use Test::More tests => 1;

BEGIN {
	use_ok( 'Catalyst::View::JavaScript' );
}

diag( "Testing Catalyst::View::JavaScript $Catalyst::View::JavaScript::VERSION, Perl $], $^X" );
