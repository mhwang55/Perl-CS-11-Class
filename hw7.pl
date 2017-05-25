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

    # MIKE NOTES
    # Need to find the command (first word on line) in the user's PATH
    # variable.  Then invoke that with the appropriate arguments
    # (all the other words on the line).  Use a fork/exec model.
    # Fork creates a new process which is a clone of the existing one.
    # Exec replaces the existing process with the new process.
    # Both fork() and exec() are built-in functions.
    # Need to learn about how fork() handles PIDs (process IDs).
    
    # This all needs to be re-written/eliminated:
    while(<FILE>)
    {
      chomp;

      # get the name of the command, the corresponding executable, and the
      # number of expected arguments
      my ($cmdName, $script, $argNum, $usageFile) = split / /, $_;
      if ($input[0] eq $cmdName)
      {
        my $args = "";
        shift @input;

        # if the inputs are less than the expected number of arguments, print
        # out the usage file instead
        if ($argNum > @input)
        {
          system("vim $usageFile");
#          open USAGE, '<', $usageFile;
#          while(<USAGE>)
#          {
#            print($_);
#          }
#          close USAGE;
          next;
        }

        # if command name is found, then concatenate the input arguments
        # together and then run a system command
        for (my $x = 0; $x < $argNum; $x++)
        {
          $args .= " $input[$x]";
        }
        print("$args\n");
        system("./$script$args");
      }
    }
    close FILE;
  }
}

&shell();
