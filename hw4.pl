#!/usr/bin/perl

# This set introduces the module WWW::Mechanize.  This module can be downloaded
# off of CPAN.  The module lets Perl perform web crawling operations.  A basic
# version is introduced, followed by some code that does actual stuff.

use strict;
use warnings;
use WWW::Mechanize;
use feature 'say';

# this code isn't meant to be run.  Just a list of sample code that I'll be
# making use of/building off of

#############################################################33

my $mech1 = WWW::Mechanize->new();
my $url1 = "https://wikipedia.org";
$mech1->get($url1);
$mech1->follow_link( url => 'https://insertPageNameHere.com' );
if ($mech1->success())
{
  print("Successful Connection");
}
else
{
  print("Not a successful connection");
}

# beginning of web crawler assignment
# will be using mechanize, though maybe I'll also add wget



# More complete version of what Mechanize can do.  Used high school competition
# stuff cuz why not
# (note urls and other things can be replaced with whatever you want)

my $date = `date \t`;
$date =~ s/.*([\d]{4}).*/$1/;
chomp(my $year = $date);
my $yearN = $year + 1;

my $mech = WWW::Mechanize->new(agent => "Mozilla/5.0 (Windows NT 5.1; rv:30.0) Gecko/20100101 Firefox/30.0");

#url variables
--
#math
my $urlMAA;
#science
my $urlSiemens;
my $urlIntel = "";
my $urlPhys = "";
my $urlChem = "";
my $urlBio;
#liberal arts
my $urlNHSMTA;
my $urlNationalSpeech_Debate;
my $urlNormanMailer;

#system command to make a directory name competitions
#`md competitions`;

#url for Mathematical Association of America
$urlMAA = "http://www.maa.org/math-competitions/about-amc/events-calendar";

open(MAA, ">", "competitions/maa.html");

$mech->get($urlMAA);

my $content = $mech->content();

#will get all instances of AMC AIME USAMO IMO dates of competitions
$content =~ s/\A.*(<td width.*?><strong>AMC 8 Contest.*?$year<\/td>).*(<td width.*?><strong>AMC 10 A.*?$yearN<\/td>).*(<td width.*?><strong>AIME I{1,2}.*?$yearN<\/td>).*(<td width.*?><strong>USAMO.*?$yearN<\/td>).*(<td valign.*?><strong>MOSP.*?$yearN<\/td>).*(<td width.*?><strong>IMO.*?$yearN<\/td>).*/$1<br><br>$2<br><br>$3<br><br>$4<br><br>$5<br><br>$6/s;

$content =~ s/<!--.*?-->//sg;
$content =~ s/\s{3,}.*?(?=[\w<])//g;
$content =~ s/>/>\n/g;
$content =~ s/</\n</g;
$content =~ s/>\n{2}</>\n</g;
$content =~ s/\A\n//;

print MAA $content;
close(MAA);

$urlSiemens = "https://siemenscompetition.discoveryeducation.com/about/competition-schedule";

open(SIEMENS, ">", "competitions/siemens3.html");

$mech->get($urlSiemens);

$content = $mech->content();

#will get dates of Siemens events
$content =~ s/\A.*(<table id="competitionScheduleTable".*Competition Schedule<\/th>.*<\/strong>.*?<\/td>.*?<\/tr>.*?<\/tbody>.*?<\/table><\/div>).*/$1/s;
$content =~ s/(<tbody>.*?<tr class="row.*?<\/tr>)/$1<br><br>/gs;

print SIEMENS $content;
close(SIEMENS);

$urlBio = "http://www.cee.org/event-calendar";

open(BIO, ">", "competitions/bio2.html");

$mech->get($urlBio);

$content = $mech->content();

#will get dates of biology olympiad events
$content =~ s/\A.*(<div class="date-heading">.*?<\/div>.*?<div class="month-view">.*?<\/table>.*?<\/div>).*/$1/s;

print BIO $content;
close(BIO);

#liberal arts
$urlNHSMTA = "http://nhsmta.com/pages/participating-theaters";

open(NHSMTA, ">", "competitions/NHSMTA3.html");

$mech->get($urlNHSMTA);

$content = $mech->content();

#will get dates of NHSMTA events
$content =~ s/\A.*(<table width=.*?<th>Award Program<\/th>.*?<\/table>).*/$1/s;
$content =~ s/<br\s*\/>/<br>/gs;
$content =~ s/\r//gs;
#$content =~ s/(<tr>.*?<\/tr>)/$1<tr>-<\/tr>/gs;

print NHSMTA $content;
close(NHSMTA);

$urlNationalSpeech_Debate = "http://www.speechanddebate.org/nationals";

open(SPEECH_DEBATE, ">", "competitions/speechDebate1.html");

$mech->get($urlNationalSpeech_Debate);

$content = $mech->content();

#will get dates of National Speech and Debate Tournament events
#$content =~ s/\A.*()//s;

print SPEECH_DEBATE $content;
close(SPEECH_DEBATE);

$urlNormanMailer = "http://nmcenter.org/events_calendar";

open(NORMAIL, ">", "competitions/normanMailer2.html");

$mech->get($urlNormanMailer);

$content = $mech->content();

#will get dates of Norman Mailer Competition events
$content =~ s/\A.*(div id="calendar".*?<\/table>.*?<\/div>.*?<\/div>.*)/$1/s;

print NORMAIL $content;
close(NORMAIL);
exit;


#end of script
