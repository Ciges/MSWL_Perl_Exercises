#!/usr/bin/perl -CS
#  Write a program that creates a backup of a directory storing the date in the file name:
#  $ ./exercise-8.pl
#  Backup done!
#  $ ls /tmp/backups
#  backup-31-07-2008.tar.gz
#  backup-01-08-2008.tar.gz
#  
#  Hint: to backup a directory using tar...
#  $ tar -C /some/dir -czf /tmp/backups/out.tar.gz .
#  
#  Hint: to get the current date...
#  $ date +%d-%m-%Y

use strict;
use warnings;
use Cwd;

if ($#ARGV+1 gt 1) {
    printf "Parameter number error, write no parameters for current directory or directory path\n";
    exit 1;
}

my $dirname;
if ($#ARGV+1 eq 0) {
    $dirname = getcwd;
} elsif ($#ARGV+1 eq 1) {
    $dirname = $ARGV[0];
}

my $date = `date +%d-%m-%Y`; chomp($date);
my $backupdir = "/tmp/backups";
if (!-d $backupdir) {
    if (!mkdir $backupdir)  {
        printf "Filesystem error: Backup directory \"$backupdir\" creation not possible!\n";
        exit 1;
    }
}

my $backupfile = "backup-$date.tar.gz";
printf "tar -C %s -czf %s/%s .\n", $dirname, $backupdir, $backupfile;
if (system(sprintf("tar -C %s -czvf %s/%s .\n", $dirname, $backupdir, $backupfile)) != 0)  {
    printf "Tar command error: \"$backupdir/$backupfile\" creation not possible!\n";
    exit 1;
}
