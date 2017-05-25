#!/usr/bin/perl -w

# This set introduces the module WWW::Mechanize.  This module can be downloaded
# off of CPAN.  The module lets Perl perform web crawling operations.  A basic
# version is introduced, followed by some code that does actual stuff.

use strict;
use warnings;
use WWW::Mechanize;

# Example version of what Mechanize can do.  Used high school competition
# stuff cuz why not (note urls and other things can be replaced with whatever
# you want)

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
sub editFile
{
  if ($_[1] eq "math")
  {
    open(FILE, ">", "competitions/maa.html");
  }
  elsif ($_[1] eq "bio")
  {
    open(FILE, ">", "competitions/bio2.html");
  }
  elsif ($_[1] eq "speech")
  {
    open(FILE, ">", "competitions/speechDebate1.html");
  }
  elsif ($_[1] eq "norman")
  {
    open(FILE, ">", "competitions/normanMailer2.html");
  }

  $mech->get($_[0]);

  my $content = $mech->content();

  # will get all instances of dates of competitions
  $content =~ s/$_[2]/$_[3]/s;

  if ($_[1] eq "math")
  {
    $content =~ s/$_[4]//sg;
    $content =~ s/$_[5]//g;
    $content =~ s/$_[6]/$_[7]/g;
    $content =~ s/$_[8]/$_[9]/g;
    $content =~ s/$_[10]/$_[11]/g;
    $content =~ s/$_[12]//;
  }

  print FILE $content;
  close(FILE);
  # done with this file
}


# url for Mathematical Association of America
$urlMAA = "http://www.maa.org/math-competitions/about-amc/events-calendar";
# will get dates of biology olympiad events
$urlBio = "http://www.cee.org/event-calendar";
# liberal arts
$urlNationalSpeech_Debate = "http://www.speechanddebate.org/nationals";
# will get dates of Norman Mailer Competition events
$urlNormanMailer = "http://nmcenter.org/events_calendar";


# expression to match on
my $exp1 = "\A.*(<td width.*?><strong>AMC 8 Contest.*?$year<\/td>).*
            (<td width.*?><strong>AMC 10 A.*?$yearN<\/td>).*
            (<td width.*?><strong>AIME I{1,2}.*?$yearN<\/td>).*
            (<td width.*?><strong>USAMO.*?$yearN<\/td>).*
            (<td valign.*?><strong>MOSP.*?$yearN<\/td>).*
            (<td width.*?><strong>IMO.*?$yearN<\/td>).*";
# expression to save
my $exp1S = "$1<br><br>$2<br><br>$3<br><br>$4<br><br>$5<br><br>$6";

my $exp2 ="<!--.*?-->";          # expression to substitute on
my $exp3 = "\s{3,}.*?(?=[\w<])"; # expression to substitute on
my $exp4 = ">/";                 # expression to substitute on
my $exp4S =">\n";                # expression to save
my $exp5 = "<";                  # expression to substitute on
my $exp5S ="\n<";                # expression to save
my $exp6 = ">\n{2}<";            # expression to substitute on
my $exp6S =">\n<";               # expression to save
my $exp7 = "\A\n";               # expression to substitute on


&editFile($urlMAA, "math", $exp1, $exp1S, $exp2, $exp3, $exp4, $exp4S, $exp5,
          $exp5S, $exp6, $exp6S, $exp7);


# expression to match on
$exp1 = "\A.*(<div class=\"date-heading\">.*?<\/div>.*?
         <div class=\"month-view\">.*?<\/table>.*?<\/div>).*";
# expression to save
$exp1S = "$1";
# edit the file
&editFile($urlBio, "bio", $exp1, $exp1S);


# expression to substitute on
$exp1 = "\A.*()";

# expression to save
$exp1S = "";

# edit the file
&editFile($urlNationalSpeech_Debate, "speech", $exp1, $exp1S);


# expression to substitute on
$exp1 = "\A.*(div id=\"calendar\".*?<\/table>.*?<\/div>.*?<\/div>.*)";

# expression to save
$exp1S = "$1";

# edit the file
&editFile($urlNormanMailer, "norman", $exp1, $exp1S);

exit;
#end of script
