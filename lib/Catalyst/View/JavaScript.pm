package Catalyst::View::JavaScript;
use warnings;
use strict;
use Class::C3;
use Carp;
use utf8;
use JavaScript::Minifier::XS qw(minify);
use base qw|Catalyst::View|;
__PACKAGE__->mk_accessors(qw(compress disable_if_debug stash key output _cache copyright));
our $VERSION = '0.99';
$VERSION = eval $VERSION;

=head1 NAME

Catalyst::View::JavaScript - Cache and/or compress JavaScript output

=head1 VERSION

Version 0.99

=cut

=head1 SYNOPSIS

This module fetches JavaScript either from the stash or from C<< $c->output >>. 
By default the JavaScript code is read from C<< $c->stash->{js} >> and compressed.
The content type is set to C<text/javascript>.

=head1 METHODS

=head2 cache

If C<$c> is able to cache (i. e. C<< if $c->can('cache') >>) the value of C<cache> is used as key to cache the JavaScript output.

=head2 compress

Set this to a true value to enable compression of the code. See L<JavaScript::Minifier::XS> for more information on how this minification works. Defaults to 1.

=head2 copyright

This string will be displayed on the top of the output enclosed in a commentary tag.

=head2 disable_if_debug

If you set the debug flag on your application caching and compressing is disabled. Defaults to 0.

=head2 output

If this is set to a true value this module fetches the JavaScript code from C<< $c->output >> and ignores the value of L</stash>. Defaults to 0.

=head2 key

This module looks in the stash for this value for JavaScript if L</stash> is enabled. Defaults to C<js>.

=head2 stash

Set this to a true value if the JavaScript code is on the stash. Set the stash value with L</key>. Defaults to C<1>.

=cut

sub new {
	my $self = shift->next::method(@_);
	my ( $c, $arguments ) = @_;
	my %config = ( compress => 1, stash => 1, key => "js", %$arguments );
	for my $field ( keys %config ) {
		if ( $self->can($field) ) {
			$self->$field( $config{$field} );
		} else {
			$c->log->debug("Unknown config parameter '$field'");
		}
	}
	return $self;
}

sub cache {
	my $self = shift;
	$self->_cache(@_);
	return $self;
}

sub process {
	my ( $self, $c ) = @_;
	my $data = '';
	my $cached = 0;
	if($self->disable_if_debug && $c->debug) {
		$self->_cache('');
		$self->compress(0);
	}
	if ( $self->_cache && 
		 $c->can('cache') &&
		 ( $data = $c->cache->get($self->_cache) ) ) {
		$cached = 1;
	} elsif ( $self->output ) {
		$data = $c->res->output;
	} elsif ( $self->stash && $self->key ) {
		$data = $c->stash->{ $self->key };
	}
	unless ($cached) {
		$data = minify($data) if ( $self->compress );
		$data = "/* " . $self->copyright . " */\n" . $data
		  if ( $self->copyright );
	}
	
	$c->res->content_type("text/javascript");
	$c->res->output($data);
	$c->cache->set($self->_cache, $data)
	  if($c->can('cache'));
}

=head1 AUTHOR

Moritz Onken, C<< <onken at houseofdesign.de> >>

=head1 BUGS

Please report any bugs or feature requests to C<bug-catalyst-view-javascript at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=Catalyst-View-JavaScript>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.





=head1 COPYRIGHT & LICENSE

Copyright 2009 Moritz Onken, all rights reserved.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.


=cut
1;    # End of Catalyst::View::JavaScript
