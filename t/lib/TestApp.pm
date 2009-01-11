package 
  TestApp;

use strict;
use warnings;

use Catalyst::Runtime '5.70';

use parent qw/Catalyst/;

__PACKAGE__->config( name => 'TestApp' );

__PACKAGE__->setup();

1;
