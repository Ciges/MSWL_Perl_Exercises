#!/usr/bin/perl -CS
#  Write a program that prints the contents of a file, omitting the lines starting with “Hide” and replacing “this” for “that”

use strict;
use warnings;

if ($#ARGV+1 ne 1) {
    printf "Parameter number error, input file name must be entered as first parameter\n";
    exit 1;
}

my $inputfile = $ARGV[0];
if (!-e $inputfile) {
    printf "Input error:  Input file %s does not exists!\n", $inputfile;
    exit 1;
}

if (!open(IFILE, $inputfile))   {
    printf "Input error: The file %s could not be opened for reading!\n", $inputfile ;
    exit 1;
}
my @inputfile = <IFILE>;
close(IFILE);

foreach (@inputfile)    {
    if ($_ !~ /^Hide/)  {
        $_ =~ s/this/that/;
        print $_;
    }
}