#!/usr/bin/perl -CS
#  Write a program that reads /etc/passwd to produce this output:
#  $ ./exercise-7.pl
#  The user ID of root is 0
#  The user ID of daemon is 1
#  The user ID of bin is 2
#  ...
#  
#  Hint: you have to read these fields:
#  root:x:0:0:root:/root:/bin/bash

use strict;
use warnings;

if (!open(IFILE, "/etc/passwd"))   {
    print "Input error: The file /etc/passwd could not be opened for reading!\n";
    exit 1;
}
my @inputfile = <IFILE>;
close(IFILE);

foreach (@inputfile)    {
    if ($_ =~ /^([^:]+):x:([0-9]+):[0-9]+:[^:]*:[^:]*:[^:]*$/)  {
        printf "The user ID of %s is %d\n", $1, $2; 
    }
}
 
