#!/usr/bin/perl

# The objective of this set is to create a shell.  The shell needs to be able
# to read from standard input, parse the command string into a program and
# args, and execute it.

# It should also be able to read in text files. (bonus maybe?)

use strict;
use warnings;

use Parse::Lex;
@token = (
  qw(
     ADDOP    [-+]
     LEFTP    [\(]
     RIGHTP   [\)]
     INTEGER  [1-9][0-9]*
     NEWLINE  \n
     
    ),
  qw(STRING),   [qw(" (?:[^"]+|"")* ")],
  qw(ERROR  .*), sub {
    die qq!can\'t analyze: "$_[1]"!;
  }
);

Parse::Lex->trace;  # Class method
$lexer = Parse::Lex->new(@token);
$lexer->from(\*DATA);
print "Tokenization of DATA:\n";

TOKEN:while (1) {
  $token = $lexer->next;
  if (not $lexer->eoi) {
    print "Line $.\t";
    print "Type: ", $token->name, "\t";
    print "Content:->", $token->text, "<-\n";
  } else {
    last TOKEN;
  }
}

__END__
#1+2-5
#"a multiline
#string with an embedded "" in it"
#an invalid string with a "" in it"
