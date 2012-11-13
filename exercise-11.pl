#!/usr/bin/perl -CS
#  Type a Last.fm user
#  Get that user's first 5 neighbours
#  Get top 10 artists from each neighbour
#  Display a list of all artists. If an artist is repeated, display it only once along with the number of occurrences.
#  The list must be sorted. Most popular artists must appear first

use strict;
use warnings;
use LWP::Simple;
use XML::Simple qw(:strict);
use Data::Dumper;

#  API Key for Ciges last.fm user
my $api_key="8a582bb6d13858f90c9d5d83d21400c1";
#  URL for REST API access
my $rest_url="http://ws.audioscrobbler.com/2.0/";

# Send a query to last.fm, process XML and returns data
sub sendQueryToLastfm() {
    my $url = shift(@_);
    my $xml = get($url);
    if (!defined($xml)) {
        printf "Web Service Error: Nothing returned for URL %s\n", $url;
        exit 1;
    }

    my $data = XMLin($xml, KeyAttr => [], ForceArray => 0);
    return $data;
}

# Get the last.fm user's first five neighbours
sub getFirst5NeighboursFromUser() {
    my $user = shift(@_);
    my $data = &sendQueryToLastfm($rest_url.'?method=user.getneighbours&user='.$user.'&limit=5&api_key='.$api_key);
    my @neighbours = ();
    if ($data->{'status'} eq 'ok')   {
        my @aux = @{$data->{'neighbours'}->{'user'}};
        for (my $i = 1; $i <= $#aux; $i++) {    # First array item is user's name
            push(@neighbours, $aux[$i]->{'name'});
        }
    }
 
    return @neighbours;
}

# Get the top 10 artists from the Last.fm user given as parameter
sub getTop10ArtistsFromUser() {
    my $user = shift(@_);
    my $data = &sendQueryToLastfm($rest_url.'?method=user.gettopartists&user='.$user.'&limit=10&api_key='.$api_key);
    my @toptenartists = ();
    if ($data->{'status'} eq 'ok')   {
        my $aux = $data->{'topartists'}->{'artist'};
        foreach my $artist (@{$aux})   {
            push @toptenartists, $artist->{'name'};
        }
    }

    return @toptenartists;
}

printf "Type a Last.fm user: ";
#my $user = <STDIN>;
my $user = "babi_queiroz";
printf "%s\n", $user;

printf "\n%s\'s first 5 neighbours are: \n", $user;
my @neighbours = &getFirst5NeighboursFromUser($user);
foreach my $neighbour (@neighbours) {
    printf "\t%s\n", $neighbour;
}

my %artists = ();
printf "\nTop 10 artists from each neighbour are: \n";
foreach my $neighbour (@neighbours) {
    printf "%s:\n", $neighbour;
    my @topartists = &getTop10ArtistsFromUser($neighbour);
    foreach my $artist (@topartists)    {
        printf "\t$artist\n";
        # Save number of ocurrences by artist
        if (!exists($artists{$artist})) {
            $artists{$artist} = 1;
        }
        else {
            $artists{$artist}++;
        }
    }
}

# Print artist list sorted by number of ocurrences from most popular to less popular. For the same number of ocurrences the order is by name alphabetically
printf "\nArtist list sorted from most popular to less popular\n";
my @sorted_artists = sort { $artists{$b} cmp $artists{$a} } sort keys %artists;
foreach my $artist (@sorted_artists) {
    printf "\t%s (%d hits)\n", $artist, $artists{$artist};
}