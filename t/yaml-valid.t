use Test::More;
use Test::YAML::Valid;
use Mojo::File 'path';
for my $ymlfile (path('.')->list_tree->grep( qr/\.yml$/ )->each ) {
    my $fh = $ymlfile->open('<');
    my $containsdata = 0;
    while(<$fh>) {
        next if $_ =~/^\s*\#/;
        next if $_ =~/^\-\-\-/;
        $containsdata = 1;
        last;
    }
    next if ! $containsdata;
    yaml_file_ok("$ymlfile", "$ymlfile ok");
}
done_testing;

=head1 HELP

To find what is wrong you may do:

perl -MYAML::Tiny -e"YAML::Tiny->read('PATH/main.yml')"

