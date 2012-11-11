#!/usr/bin/perl
#  Ask the user to type some numbers, and sort them.

use strict;
use warnings;

print "How many numbers will you enter?: ";
my $n = <STDIN>; chomp($n);

if ($n !~ /^[0-9]+$/)   {
    print "You must enter a number!\n";
    exit 1;
}

$n = $n+0;  # To be sure $n is treated as a integer
if ($n eq 0)    {
    print "Really? Ok\n";
    exit 0;
}

my @list = ();
for (my $i = 1; $i <= $n; $i++)    {
    print "Enter the number: ";
    my $item = <STDIN>; chomp($item);
    if ($item !~ /^[0-9]+$/)   {
        print "You must enter a number!\n";
        exit 1;
    }
    push @list, $item+0;
}

printf "The numbers sorted are %s\n", join(" ", sort { $a <=> $b } @list);

