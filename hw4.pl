#!/usr/bin/perl -w

# This set introduces the module WWW::Mechanize.  This module can be downloaded
# off of CPAN.  The module lets Perl perform web crawling operations.  A basic
# version is introduced, followed by some code that does actual stuff.

use strict;
use warnings;
use WWW::Mechanize;

# Example version of what Mechanize can do.  Used high school competition
# stuff cuz why not
# (note urls and other things can be replaced with whatever you want)
# no subroutines yet though will add when I can

my $date = `date \t`;
$date =~ s/.*([\d]{4}).*/$1/;
chomp(my $year = $date);
my $yearN = $year + 1;

my $mech = WWW::Mechanize->new(agent => "Mozilla/5.0 (Windows NT 5.1; rv:30.0) Gecko/20100101 Firefox/30.0");

# don't verify host (won't cause certificate errors)
$mech->ssl_opts( 'verify_hostname' => 0);

# url variables
--
# math
my $urlMAA;
# science
my $urlSiemens;
my $urlIntel = "";
my $urlPhys = "";
my $urlChem = "";
my $urlBio;
# liberal arts
my $urlNHSMTA;
my $urlNationalSpeech_Debate;
my $urlNormanMailer;

# system command to make a directory name competitions
#`md competitions`;

# subroutine will have format scraper(url, filName, subexp1, subexp2...)

# url for Mathematical Association of America
$urlMAA = "http://www.maa.org/math-competitions/about-amc/events-calendar";

open(MAA, ">", "competitions/maa.html");

$mech->get($urlMAA);

my $content = $mech->content();

# will get all instances of AMC AIME USAMO IMO dates of competitions
$content =~ s/\A.*(<td width.*?><strong>AMC 8 Contest.*?$year<\/td>).*(<td width.*?><strong>AMC 10 A.*?$yearN<\/td>).*(<td width.*?><strong>AIME I{1,2}.*?$yearN<\/td>).*(<td width.*?><strong>USAMO.*?$yearN<\/td>).*(<td valign.*?><strong>MOSP.*?$yearN<\/td>).*(<td width.*?><strong>IMO.*?$yearN<\/td>).*/$1<br><br>$2<br><br>$3<br><br>$4<br><br>$5<br><br>$6/s;

$content =~ s/<!--.*?-->//sg;
$content =~ s/\s{3,}.*?(?=[\w<])//g;
$content =~ s/>/>\n/g;
$content =~ s/</\n</g;
$content =~ s/>\n{2}</>\n</g;
$content =~ s/\A\n//;

print MAA $content;
close(MAA);
# done with this file



# will get dates of biology olympiad events
$urlBio = "http://www.cee.org/event-calendar";
open(BIO, ">", "competitions/bio2.html");

$mech->get($urlBio);
$content = $mech->content();

$content =~ s/\A.*(<div class="date-heading">.*?<\/div>.*?<div class="month-view">.*?<\/table>.*?<\/div>).*/$1/s;

print BIO $content;
close(BIO);
# done with this file



# liberal arts
$urlNationalSpeech_Debate = "http://www.speechanddebate.org/nationals";

open(SPEECH_DEBATE, ">", "competitions/speechDebate1.html");

$mech->get($urlNationalSpeech_Debate);

$content = $mech->content();

# will get dates of National Speech and Debate Tournament events
$content =~ s/\A.*()//s;

print SPEECH_DEBATE $content;
close(SPEECH_DEBATE);
# done with this file



# will get dates of Norman Mailer Competition events
$urlNormanMailer = "http://nmcenter.org/events_calendar";
open(NORMAIL, ">", "competitions/normanMailer2.html");

$mech->get($urlNormanMailer);
$content = $mech->content();

$content =~ s/\A.*(div id="calendar".*?<\/table>.*?<\/div>.*?<\/div>.*)/$1/s;

print NORMAIL $content;
close(NORMAIL);
# done with this file
exit;


#end of script
