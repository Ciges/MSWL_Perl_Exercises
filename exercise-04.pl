#!/usr/bin/perl
#  Given the following code:
#  @a = (
#  { name => "Manolo", age => 25 },
#  { name => "Sara", age => 34 }
#  );
#  
#  Write a program to produce this output by
#  reading @a:
#  Manolo is 25 years old
#  Sara is 34 years old
#  
#  It should still work no matter the number of elements in @a.

use strict;
use warnings;

my @a = (
    { name => "Manolo", age => 25 },
    { name => "Sara", age => 34 }
);

foreach my $person (@a)  {
    my %hash_person = %{$person};
    printf "%s is %d years old\n", $hash_person{name}, $hash_person{age};
}

