#!/usr/bin/perl

# The objective of this set is to introduce students to SQLite and how it
# meshes with Perl's functionality.  This one will be a bit shorter than the
# rest, as it relies mostly on Perl's regexes (covered in hw1) and the commands
# from SQLite.

use DBI;
use strict;
use warnings;

my $driver   = "SQLite";
my $database = "test.db";
my $dsn = "DBI:$driver:dbname=$database";
my $userid = "";
my $password = "";
my $dbh = DBI->connect($dsn, $userid, $password, { RaiseError => 1 })
                      or die $DBI::errstr;
print "Opened database successfully\n";

my $stmt = qq(CREATE TABLE COMPANY
      (ID INT PRIMARY KEY     NOT NULL,
       NAME           TEXT    NOT NULL,
       AGE            INT     NOT NULL,
       ADDRESS        CHAR(50),
       SALARY         REAL););
my $rv = $dbh->do($stmt);
if($rv < 0){
   print $DBI::errstr;
} else {
   print "Table created successfully\n";
}
$dbh->disconnect();

# Use commands like these to create a database, haven't yet decided of what,
# maybe from wikipedia
# Will be tying in with the webcrawler portion
# https://www.tutorialspoint.com/sqlite/sqlite_perl.htm
