#!/usr/bin/perl
use Data::Dumper;
use Sys::Hostname;
$host = hostname;
$time=time();
$break=0;

$SIG{INT} = sub { $break=1; };


$filename=$host."_".$time.".log";
open(my $fh, '>', $filename) or die "Could not open file '$filename' $!";

#print headers
print $fh "#time,cpu_used_percentage,\n";

while(1) {
    if($break) { 
	close $fh;
	die "ctrl c\n"; }

    print $fh time();
    print $fh ",";
    print $fh getcpu();



    print $fh "\n";
    print "*";
} 




sub getcpu() {
    my $percentage=`sh getcpu.sh`;
    chomp $percentage;
    return $percentage;
}






