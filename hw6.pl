#!/usr/bin/perl

# The objective of this set is to breakdown to components of the grep shell
# command.

# Initial version of grep.  Can process one file at a time.  Returns the line
# number upon which the pattern matched along with the line itself.  Will add
# multi-file functionality later, along with possible options.  Already have
# help option.


# Note: a file called test.txt is included in order to test out the
# functionality of this program, but you can use any file you want.  The only
# prerequisite is that the file is in the same directory as this grep program.


use strict;
use warnings;

# file reading subroutine using arguments from ARGV
#=begin comment
sub readFile
{
  my %lines = ();

  # arg contains pattern then filename, split on whitespace to get them in
  # different variables
  my $pattern = $_[0];
  my $filename = $_[1];
  {
    my $x = 0;

    # open filehandle, then while not EOF, get each line in the file
    open FILE, '<', $filename;
    while(<FILE>)
    {
      $x++;
      chomp;

      # check to see whether line we're on matches the pattern.  If match,
      # save that line and line number
      if ($_ =~ m/$pattern/)
      {
        $lines{$x} = $_;
      }
    }
    close FILE;
  }
  return %lines;
}
#=end comment
#=cut



=begin comment
# file reading subroutine
sub readFile
{
  my %lines = ();

  # arg contains pattern then filename, split on whitespace to get them in
  # different variables
  my @exp = split / /, $_[0];
  my $pattern = shift @exp;
  foreach (@exp)
  {
    my $x = 0;

    # open filehandle, then while not EOF, get each line in the file
    open FILE, '<', $_;
    while(<FILE>)
    {
      $x++;
      chomp;

      # check to see whether line we're on matches the pattern.  If match,
      # save that line and line number
      if ($_ =~ m/$pattern/)
      {
        $lines{$x} = $_;
      }
    }
    close FILE;
  }
  return %lines;
}
=end comment
=cut

my %results = ();

# this line for testing the file itself
=begin comment
#chomp(my $line = <STDIN>);

if ($line =~ /\A[\s]*grep --help/ or $line =~ /\A[\s]*grep[\s]*\z/)
{
  print("Command usage\n");
  print("grep PATTERN [filename1]\n");
  print("Anything inside [] is optional\n");
}
elsif ($line =~ /\A[\s]*grep[\s]+[\w\d]+[\s]+[\w\d]+/)
{
  $line =~ s/\A[\s]*grep[\s]+([\w\d]+)[\s]+([\w\d]+)/$1 $2/;
  %results = &readFile($line);

  # we want sorted results, so need to sort keys numerically
  for my $key (sort keys %results)
  {
    print("Line $key: $results{$key}\n");
  }
}
else
{
  print("Incorrect command or invalid filename\n");
}
=end comment
=cut



# to connect with actual shell, take from @ARGV
#=begin comment
if ($ARGV[0] =~ /--help/)
{
  print("Command usage\n");
  print("grep PATTERN [filename1]\n");
  print("Anything inside [] is optional\n");
}
elsif ($ARGV[0] =~ /[\w\d]+/ and $ARGV[1] =~ /[\w\d]+/)
{
  %results = &readFile($ARGV[0], $ARGV[1]);

  # we want sorted results, so need to sort keys numerically
  for my $key (sort keys %results)
  {
    print("Line $key: $results{$key}\n");
  }
}
else
{
  print("Incorrect command or invalid filename\n");
}
exit;
#=end comment
#=cut
