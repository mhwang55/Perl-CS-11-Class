#!/usr/bin/perl

# The objective of this set is to create a parser for a shell

use strict;
use warnings;

# below is c pseudocode

sub init_info # args are parseInfo
{
  initialize parseInfo array or hash
}

# parse a single command
sub parse_command # args are command, comm
{
}

#  parse commandline for space separated commands
sub parseInfo #args are cmdline
{
  foreach cmd in cmdline
  {
    if (cmd == command)
    {
      parse_command(cmd, type)
    }
  }
}

# prints out parse struct
sub print_info #args are info
{
  foreach type in info
  {
    print "type_name: type"
  }
}  
