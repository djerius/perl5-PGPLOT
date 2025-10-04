use strict;
use warnings;

use Alien::Base::Wrapper 'WriteMakefile';

my @prereq;
my %min_version = (
  'PDL' => '2.089', # broadcast_define, no PGPLOT
);
for my $opt_dep (sort keys %min_version) {
  (my $file = $opt_dep) =~ s#::#/#g;
  next if !eval { require "$file.pm"; 1 }; # not installed, fine
  next if eval { $opt_dep->VERSION($min_version{$opt_dep}); 1 };
  push @prereq, $opt_dep => $min_version{$opt_dep};
}


WriteMakefile(
    MIN_PERL_VERSION => '5.010001',
    'NAME'	=> 'PGPLOT',
    alien_requires => { 'Alien::PGPLOT' => '5.2.2.4' },
    CONFIGURE_REQUIRES => { 'Alien::Base::Wrapper' => 2.8.4 },
    'TEST_REQUIRES' => { 'Test::More' => '0.88' },
    PREREQ_PM => { @prereq },
    'VERSION_FROM'	=> 'lib/PGPLOT.pm',
    'dist'      => { COMPRESS=>"gzip", SUFFIX=>"gz" },
    'depend'    => { '$(OBJECT)' => q[pgfun.c arrays.c PGPLOT.c]},
    'META_MERGE' => {
       "meta-spec" => { version => 2 },
       resources => {
          bugtracker  => {web=>'https://github.com/PDLPorters/perl5-PGPLOT/issues'},
          repository  => {
             url => 'git://github.com/PDLPorters/perl5-PGPLOT.git',
             type => 'git',
             web => 'https://github.com/PDLPorters/perl5-PGPLOT',
          },
       },
       prereqs => {
          develop => {
             requires => {
                'CPAN::Changes' => '0',
             },
          },
          runtime => {
             recommends => \%min_version,
             requires => {},
          },
       },
       x_IRC => 'irc://irc.perl.org/#pdl',
    },
    LICENSE        => 'perl_5',
    'TEST_REQUIRES' => { 'Test::More' => '0.88' },

);
