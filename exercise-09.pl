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

# Returns an array with /etc/passwd contents
sub getPasswdFile() {
    if (!open(IFILE, "/etc/passwd"))   {
        print "Input error: The file /etc/passwd could not be opened for reading!\n";
        exit 1;
    }
    my @passwd_file = <IFILE>;
    close(IFILE);

    return @passwd_file;
}

# Returns an array with the system user names
sub getUsers()  {
    my @passwd_file = getPasswdFile();

    my @users = ();
    foreach (@passwd_file)    {
        if ($_ =~ /^([^:]+):x:[0-9]+:[0-9]+:[^:]*:[^:]*:[^:]*$/)  {
            push @users, $1;
        }
    }

    return @users;
}

# Given a user name returns its id
sub getUserID() {
    my $username = shift(@_);
    my @userpassword_line = grep(/^$username:/, getPasswdFile());
    if ($userpassword_line[0] =~ /^$username:x:([0-9]+):/)  {
        return $1;
    }
}

foreach (getUsers())    {
     printf "The user ID of %s is %d\n", $_, &getUserID($_);
}


 
