#!/usr/bin/perl
# Write a program that copies a file into another, reversing the lines. Print the number of lines at the end.

use strict;
use warnings;

if ($#ARGV+1 ne 2) {
    printf "Parameter number error:
    - input file name must be entered as first parameter
    - output file name must be entered as second parameter\n";
    exit 1;
}

my $inputfile = $ARGV[0];
my $outputfile = $ARGV[1];
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

my $answer;
if (-e $outputfile) {
    printf "File \"%s\" exists already. Do you want to overwrite it? (yes/no) ", $outputfile;
    $answer = <STDIN>;
    if ($answer !~ /^yes$/i)    {
        printf "Operation aborted\n";
        exit 2;
    }
}


if (!open(OFILE, ">$outputfile"))   {
    printf "Output error: The file %s could not be opened for writing!\n", $outputfile ;
    exit 1;
}
print OFILE reverse @inputfile;
printf "\nDone! The file had %d lines!\n", $#inputfile+1;

