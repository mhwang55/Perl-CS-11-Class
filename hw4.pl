#!/usr/bin/perl

use strict;
use warnings;
use WWW::Mechanize;

# this code isn't meant to be run.  Just a list of sample code that I'll be
# making use of/building off of

#############################################################33

my $mech = WWW::Mechanize->new();
my $url = "https://wikipedia.org";
$mech->get($url);
$mech->follow_link( url => 'https://insertPageNameHere.com' );
if ($mech->success())
{
  print("Successful Connection");
}
else
{
  print("Not a successful connection");
}







# beginning of web crawler assignment
# will be using mechanize, though maybe I'll also add wget
