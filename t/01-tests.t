#!perl

use Test::More tests => 11;

use Catalyst::View::JavaScript;

use lib qw(t/lib);

use ok 'TestApp';

use Test::WWW::Mechanize::Catalyst 'TestApp';
my $mech = Test::WWW::Mechanize::Catalyst->new;

my %tests = ("body" => "var foo=2;", "key" => "var foo=1;", "compress" => "var foo=2;", "decompress" => "var foo = 2;", "copyright" => "/* foobar */\x{0a}var foo=1;");

while(my($k,$v) = each %tests) {
  $mech->get_ok('http://localhost/'.$k, 'get page '.$k);
  $mech->content_is($v, 'content matches');
}


