#!/usr/bin/env perl
use CPAN::Meta::YAML qw /LoadFile/;
use warnings;
use strict;
use autodie;
use 5.016;

=head1 NAME

print-perl-modules

=head1 DESCRIPTION

Print perl modules to screen.
Used for updateing perlbrew version manually.

Like this:
 perlbrew switch perl-5.26.0
 ./print-perl-modules.pl | perlbrew exec --with perl-5.26.0 cpanm

=cut

my $yaml = CPAN::Meta::YAML::LoadFile("$ENV{HOME}/git/ansible-perlbrew/vars/main.yml");
for my $val (@{$yaml->{perlmodules}}) {
	say $val;
}
say "#installed with force";
for my $val (@{$yaml->{perlforcemodules}}) { # utf8 AB before AA
	say $val;
}
if (exists $yaml->{pianotrainer}) {
	say "#only piano-trainer";
	for my $val (@{$yaml->{pianotrainer}}) { # utf8 AB before AA
		say $val;
	}
}