#!/usr/bin/perl

use strict;
use warnings;

# this code isn't meant to be run.  Just a list of sample code that I'll be
# making use of/building off of

#############################################################33

# Look up the resource file
my $filename = get_local_path($id);
if (-f $filename) {

    # Open and slurp up the file and output the resource
    open my $bookfh, $filename
    or barf 500, "I Am Broke", "Cannot open $filename: $!";

    print $q->header('text/yaml');
    print do { local $/; <$bookfh> };
}

# No such resource exists
else {
    barf 404, "Where is What?", "Book for $id does not exist.";
}



# Check to make sure the input book is sane
my $book = check_book( $q->param('POSTDATA') );

# If we have an ISBN (some books don't!), then die if we already have
# it because we don't permit POST cannot for updates!
if ($book->{isbn} and -f get_local_path($book->{isbn})) {
    barf 500, 'Not Gonna Do It',
        'A POST may not be used to update an existing book.';
}

# Our data is sane!









# thinking of using nginx as a reverse proxy to apache
# got code snippets from
# http://www.onlamp.com/pub/a/onlamp/2008/02/19/developing-restful-
# web-services-in-perl.html?page=2
