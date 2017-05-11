#!/usr/bin/perl

# The objective of this set is to create a shell.  The shell needs to be able
# to read from standard input, parse the command string into a program and
# args, and execute it.

# It should also be able to read in text files. (bonus maybe?)

use strict;
use warnings;

# below is c pseudocode
sub shell # args are num, lstArgs (is a list)
{
  while (1)
  {
    my $childPid;
    my ref cmdLine;
    printPrompt();
    cmdLine = readCommandLine();
    chomp(cmdLine);
    cmd = parseCommand(cmdLine);

    record command in history list
 
    if ( isBuiltInCommand(cmd) )
    {
      executeBuiltInCommand(cmd);
    }
    else
    {		
      childPid = fork();
      if (childPid == 0)
      {
        executeCommand(cmd); # calls execvp or perl equivalent
      }
      else
      {
        if (isBackgroundJob(cmd))
        {
          record in list of background jobs
        }
        else
        {
          waitpid (childPid);
        }
      }
    }
  }
}

