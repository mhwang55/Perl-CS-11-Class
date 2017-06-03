#!/usr/bin/perl

# The objective of this set is to breakdown to components of the grep and cat
# shell commands.

# Initial version of grep.  Can process one file at a time.  Returns the line
# number upon which the pattern matched along with the line itself.  Will add
# multi-file functionality later, along with possible options.  Already have
# help option.

# Cat just prints out file in question

# Note: a file called test.txt is included in order to test out the
# functionality of this program, but you can use any file you want.  The only
# prerequisite is that the file is in the same directory as this program.


use strict;
use warnings;

package simi
{
  use Moose;

#  has 'name' =>
#  (
#    is => 'rw',
#    init_arg => '1',
#  );

  sub readFile
  {
    my %lines = ();

    # arg contains pattern then filename, split on whitespace to get them in
    # different variables
    # first argument is self, second to end args are true arguments to method
    my @exp = split / /, $_[1];
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

  sub readFileCat
  {
    my @exp = split / /, $_[1];
    foreach (@exp)
    {
      my $x = 0;

      # open filehandle, then while not EOF, get each line in the file
      open FILE, '<', $_;
      while(<FILE>)
      {
        print("$_");
      }
      close FILE;
    }
  }
}

my $grep = simi->new;
my $cat = simi->new;

my %results = ();

# this line for testing the file itself
chomp(my $line = <STDIN>);

if ($line =~ /\A[\s]*grep --help/ or $line =~ /\A[\s]*grep[\s]*\z/)
{
  print("Command usage\n");
  print("grep PATTERN [filename1]\n");
  print("Anything inside [] is optional\n");
}
elsif ($line =~ /\A[\s]*grep[\s]+[\w\d]+[\s]+[\w\d]+/)
{
  $line =~ s/\A[\s]*grep[\s]+([\w\d]+)[\s]+([\w\d]+)/$1 $2/;
  %results = $grep->readFile($line);

  # we want sorted results, so need to sort keys numerically
  for my $key (sort keys %results)
  {
    print("Line $key: $results{$key}\n");
  }
}
elsif ($line =~ /\A[\s]*cat --help/ or $line =~ /\A[\s]*cat[\s]*\z/)
{
  print("Command usage\n");
  print("cat [filename1]\n");
  print("Anything inside [] is optional\n");
}
elsif ($line =~ /\A[\s]*cat[\s]+[\w\d]+/)
{
  $line =~ s/\A[\s]*cat[\s]+([\w\d]+)[\s]+([\w\d]+)/$1 $2/;
  %results = $cat->readFileCat($line);
}
else
{
  print("Incorrect command or invalid filename\n");
}

#print($grep->name, "\n");


