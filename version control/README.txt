Hi Asjad,

The text file

http://fmwww.bc.edu/repec/boc/bocode/bocodex.rdf

is used by Stata's ado update command to determine whether what is installed is current. There are one or two dates for each package: Creation-Date and Revision-Date. If the second exists, it is used as Distribution-Date; otherwise the first date is used. You can search for the package name in CAPITALS and then pick off the appropriate date. 

Similar logic is used by the ssc new command, which makes use of http://repec.org/docs/smcl.php
That code also accesses npcpdey.rdf, which can be ignored.

Cheers
Kit


Also accesses bocodey.rdf…