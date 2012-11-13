#!/usr/bin/perl -CS
#  Write a program that displays the top 10 artists from any Last.fm user.
#  http://ws.audioscrobbler.com/2.0/?method=user.getInfo&user=ciges&api_key=8a582bb6d13858f90c9d5d83d21400c1
use strict;
use warnings;
use LWP::Simple;
use XML::Simple qw(:strict);

#  API Key for Ciges last.fm user
my $api_key="8a582bb6d13858f90c9d5d83d21400c1";
#  URL for REST API access
my $rest_url="http://ws.audioscrobbler.com/2.0/";

# Get the top 10 artists from the Last.fm user given as parameter
sub getTop10ArtistsFromUser() {
    my $user = shift(@_);
    my $url = $rest_url.'?method=user.gettopartists&user='.$user.'&limit=10&api_key='.$api_key;
    my $xml = get($url);
    if (!defined($xml)) {
        printf "Web Service Error: Nothing returned for URL %s\n", $url;
        exit 1;
    }

    my $artistsData = XMLin($xml, KeyAttr => [], ForceArray => 0);
    my @toptenartists = ();
    if ($artistsData->{'status'} eq 'ok')   {
        my $aux = $artistsData->{'topartists'}->{'artist'};
        foreach my $artist (@{$aux})   {
            push @toptenartists, $artist->{'name'};
        }
    }

    return @toptenartists;
}


if ($#ARGV+1 ne 1) {
    printf "Parameter error, user name must be entered as parameter!\n";
    exit 1;
}

my $user = $ARGV[0];
my @artists = &getTop10ArtistsFromUser($user);
printf "Number of artists got for user %s: %d artists\n\n", $user, $#artists+1;

foreach (@artists)  {
    printf "%s\n", $_;
}