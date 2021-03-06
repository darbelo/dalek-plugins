package t::util;
use strict;
use warnings;
use Perl6::Export::Attrs;

my $module;
my $inst;
sub load_plugin :Export(:DEFAULT) {
    $module = shift;
    my $rv = do "modules/local/$module.pm";
    return warn "Couldn't parse $module: $@\n" if $@;
    return warn "Couldn't do $module: $!\n" unless defined $rv;
    return warn "$module did not return a true value.\n" unless $rv;
    $module = "modules::local::$module";
    $inst   = $module;
    call_func('init');
}

sub call_func :Export(:DEFAULT) {
    my $func = shift;
    return $inst->$func(@_);
}

my @output;

sub output :Export(:DEFAULT) {
    my $line = shift;
    return @output unless defined $line;
    return undef unless exists $output[$line];
    return $output[$line];
}

sub reset_output :Export(:DEFAULT) {
    @output = ();
}


package main;

# stubs
sub create_timer { my ($timername, $self, $functionname, $timeout) = @_; }
sub lprint { my $line = shift; }

# gather output for test
sub send_privmsg {
    my ($net, $chan, $text) = @_;
    push(@output, { net => $net, chan => $chan, text => $text });
}

1;
