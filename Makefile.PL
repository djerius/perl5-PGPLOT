use strict;

use Alien::Base::Wrapper 'WriteMakefile';

# See lib/ExtUtils/MakeMaker.pm for details of how to influence
# the contents of the Makefile that is written.
WriteMakefile(
    'NAME'	=> 'PGPLOT',
    alien_requires => { 'Alien::PGPLOT' => '5.2.2.4' },
    CONFIGURE_REQUIRES => { 'Alien::Base::Wrapper' },
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
