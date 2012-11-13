#!/usr/bin/perl -CS
#  Exercise description
#  Given the following code:
#  #!/usr/bin/perl -w
#  $a = [ 10, 45, 13, 53, 62 ];
#
#  Complete the program to count the number of elements in the list to produce this output:
#  The number of elements in $a is 5

use strict;
use warnings;

my $a = [ 10, 45, 13, 53, 62 ];
my @array_a = @{$a};
printf "The number of elements in \$a is %d\n", $#array_a+1;
 
