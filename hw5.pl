#!/usr/bin/perl

# This set introduces threading.

use strict;
use warnings;
use threads;
use Config;

# creates a thread every 2 seconds.  Each thread lasts 5 seconds

#############################################################

# checks whether this version of perl was compiled with thread support
$Config{useithreads} or
    die('Recompile Perl with threads to run this program.');

# creates the thread
sub createThread
{
  my $threadId = threads->self->tid;
  print "Starting thread $threadId\n";
  sleep 5; 
  print "Ending thread $threadId\n";
  threads->detach(); #End thread.
}

while (1)
{
  threads->create(\&createThread);
  sleep 2;
}

# used code from this site: http://perldoc.perl.org/perlthrtut.html

# semaphores for thread-unsafe modules
# http://perldoc.perl.org/perlthrtut.html#Basic-semaphores
