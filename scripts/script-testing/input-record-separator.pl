#!/usr/bin/perl

$FILE = "testfile.txt";
open (INFILE, $FILE) or die ("Not able to open the file");
$/ = ":";
while ($record = <INFILE>) {
        print "$record \n";
}
