#!/usr/bin/perl
#  Given the following piece of code:
#  #!/usr/bin/perl -w
#  $a = 10;
#  $b = 20;
#  
#  Complete the program so that it multiplies $a by
#  $b to produce the following output:
#  $a multiplied by $b is 200

use strict;
use warnings;

$a = 10;
$b = 20;

printf "%d multiplied by %d is %d\n", $a, $b, $a*$b
