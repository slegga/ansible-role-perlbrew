#!/usr/bin/env perl

use Mojo::File 'path';
use CPAN::Meta::YAML;


my $lib;
BEGIN {
    my $gitdir = Mojo::File->curfile;
    my @cats = @$gitdir;
    while (my $cd = pop @cats) {
        if ($cd eq 'git') {
            $gitdir = path(@cats,'git');
            last;
        }
    }
    $lib =  $gitdir->child('utilities-perl','lib')->to_string;
};
use lib $lib;
use SH::UseLib;
use SH::ScriptX;
use Mojo::Base 'SH::ScriptX';
use open qw(:std :utf8);


#use Carp::Always;

=encoding utf8

=head1 NAME

install-all-perl-modules.pl - Read config file install modules and force install marked troublesome modules.

=head1 DESCRIPTION

Run cpanm MODULE on each choosen module.

Marked force full modules is forced installed.

Write report of trouble some modules.

=head1 ATTRIBUTES

=head2 configfile - default to $CONFIG_DIR then $HOME/etc/<<scriptname>>.yml

=cut

option 'dryrun!', 'Print to screen instead of doing changes';

sub main {
    my $self = shift;
    my $yaml = CPAN::Meta::YAML::LoadFile("$ENV{HOME}/git/ansible-perlbrew/vars/main.yml");
    for my $val (@{$yaml->{perlmodules}}) {
    	say `cpanm $val`;
    }
    if (exists $yaml->{pianotrainer}) {
    	say "#only piano-trainer";
    	for my $val (@{$yaml->{pianotrainer}}) { # utf8 AB before AA
    		say `cpanm $val`;
    	}
    }
    say "#installed with force";
    for my $val (@{$yaml->{perlforcemodules}}) { # utf8 AB before AA
    	say `cpanm --notest $val`;
    }
}

__PACKAGE__->new(options_cfg=>{extra=>1})->main();
