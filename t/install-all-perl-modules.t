use Mojo::Base -strict;
use Test::More;
use Mojo::File 'path';
use open qw(:std :utf8);

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
use Test::ScriptX;


# install-all-perl-modules.pl - Read config file install modules and force install marked troublesome modules.

unlike(path('bin/install-all-perl-modules.pl')->slurp, qr{\<\<[A-Z]+\>\>},'All placeholders are changed');
my $t = Test::ScriptX->new('bin/install-all-perl-modules.pl', debug=>1);
$t->run(help=>1);
$t->stderr_ok->stdout_like(qr{install-all-perl-modules});
done_testing;
