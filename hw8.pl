#!/usr/bin/perl

# The objective of this set is to continue building on the basic shell.  The
# shell will have file globbing and has a history
# To exit out of the shell, just hit Ctrl-D

use strict;
use warnings;
use Term::ReadLine;

my $origCommand;
my $saveCmd;

# no arguments to shell.  Just run it
sub shell
{
  $SIG{INT} = 'IGNORE';
  my $prompt = ">> ";
  my $term = Term::ReadLine->new('Simple Perl shell');
  $term->Attribs->ornaments(0);
  open WHISTORY, '>>', ".history";
  while (1)
  {
    print(">> ");
    $_ = $term->readline($prompt);
    if(!defined $_ or $_ eq 'exit')
    {
      close WHISTORY;
      exit;
    }

    # if just an enter, skip the rest of the loop
    next if (!$_);
    my @input = ();
    my $command;
    unless (/^!/ or /\Ahistory\z/)
    {
      # save original command
      $origCommand = $_;

      # get the command and the arguments to the command
      @input = split / /, $_;

      # get the command as a var and the arguments in an array
      $command = shift(@input);
    }
    elsif (/\Ahistory\z/)
    {
      open RHISTORY, '<', ".history";
      while(<RHISTORY>)
      {
        print("$_");
      }
      close RHISTORY;
      next;
    }
    else
    {
      my $num = 1;
      my $line;
      $_ =~ s/!(.*)/$1/;
      $_ =~ s/!(.*)/$1/;
      $line = $_;
      print("$_\n");
      open RHISTORY, '<', ".history";
      while(<RHISTORY>)
      {
        if($num != $line)
        {
          $num++;
        }
        else
        {
          chomp;
          $saveCmd = $_;
          $origCommand = $saveCmd;
          last;
        }
      }
      close RHISTORY;
      print("*$saveCmd\n");
      # get the command and the arguments to the command
      @input = split / /, $saveCmd;

      # get the command as a var and the arguments in an array
      $command = shift(@input);
    }

    my @fInput = ();
    foreach my $str (@input)
    {
      push @fInput, glob($str);
    }

    my $pid = fork();
    if ($pid == 0)
    {
      print(WHISTORY "$origCommand\n");
      # child process
      die("lsh") if (exec($command, @fInput) == -1);
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
