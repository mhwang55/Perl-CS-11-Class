#!/usr/bin/perl

# The objective of this set is to create a shell.  The shell needs to be able
# to read from standard input, parse the command string into a program and
# args, and execute it.

# It should also be able to read in text files. (bonus maybe?)

# To exit out of the shell, just hit Ctrl-C

use strict;
use warnings;
use Term::ReadLine;

# no arguments to shell.  Just run it
sub shell
{
  print(">> ");
  while (<>)
  {
    print(">> ");
    chomp;

    # if just an enter, skip the rest of the loop
    next if (!$_);

    # get the command and the arguments to the command
    my @input = split / /, $_;

    # get the command as a var and the arguments in an array
    my $command = shift(@input);

    my $pid = fork();
    if ($pid == 0)
    {
      # child process
      die("lsh") if (exec($command, @input) == -1);
    }
    elsif ($pid < 0)
    {
      # error forking
      printf("Error forking");
    }
    else
    {
      # parent process
      wait;
    }
  }
}

&shell();
