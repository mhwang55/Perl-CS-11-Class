#!/usr/bin/perl

# The objective of this set is to introduce various Perl concepts.  What's the
# difference blocks compare similar expressions and how small differences in
# syntax create big differences.  There are some exercises from Learning Perl
# by O'Reilly included.  There are also questions asking what various code
# blocks do and how to solve seemingly solved problems.

use strict;
use warnings;

my @arr = ();
push(@arr, 5);
push(@arr, 120);

# what's the difference between
print(@arr+2,"\n");
# and
print("@arr+2\n");
print("\n");


my @arr2 = (1, 34, "hello", -3243, "world");
# what's the difference between
for my $x (@arr2)
{
  print("$x ");
}
print("\n");
# and
print("@arr2\n");
# and
print($_, " ") foreach @arr2;
print("\n");

my $str = "hello world";

#what's the difference between
print("$1\n") if ($str =~ /(^.*o)/);
# and
print("$1\n") if ($str =~ /(^.*?o)/);

#how would you capture the string orld using greedy vs non-greedy
print("$1\n") if ($str =~ /^.*(o.*)/);

# Excercise 7.1
# Excercise 9.5

my $x = 5;
my $y = 10;

# these do the same thing, or do they?
print("$x\n") if ($y > $x);
print("$x\n") unless ($x > $y);



for $x (1,2,3,4,5)
{
  print($x, "\n") unless ($x < 3);
}
print("\n");
print("\n");

# fill in the ??? (only 1 word is necessary)
#my @words = qw{ fred barney pebbles dino wilma betty };
my @words = qw{  };
my $errors = 0;
foreach (@words) {
  print "Type the word '$_': ";
  chomp(my $try = <STDIN>);
  if ($try ne $_) {
    print "Sorry - That's not right.\n\n";
    $errors++;
    # ???
    redo; # jump back up to the top of the loop
  }
}
print "You've completed the test, with $errors errors.\n";

# what does this do?
#@ARGV = ();
while (<>) {
  chomp;
  print("$_\n") if ($_ =~ /\d/);
}
print("\n");


my @someNumbers = qw{ 1.40 1.1 1.10 1.2 1.30 1.0 1.31 1.4 1.3 };
# version numbers
my @numbers = sort { $a <=> $b } @someNumbers;
# what's the problem?
print("$_\n") foreach @numbers;
# how to fix? can be done in a 1-line for loop
# want 1.0 1.1 1.2 1.3 1.4 1.10 1.30 ...
