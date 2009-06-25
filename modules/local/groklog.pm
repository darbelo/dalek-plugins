package modules::local::groklog;
use strict;
use warnings;
use base 'modules::local::githubparser';


=head1 NAME

    modules::local::groklog

=head1 DESCRIPTION

This is a subclass of modules::local::githubparser.  It adds a parser to emit
grok commits.

Moritz++ requested that grok commits be emitted to #perl6.  So here it is.


=head1 METHODS

=head2 init

This is a pseudo-method called by botnix when the module is first loaded.  It
hands the URL to the github parser module and tells it to emit to freenode's
#perl6.  (If a grok parser was already configured, it will consolidate the
config and simply add the freenode channel to the list of targets.)

=cut

my $url = 'http://github.com/hinrik/grok/';

sub init {
    modules::local::githubparser->try_link($url, ['freenode', '#perl6']);
}

1;
