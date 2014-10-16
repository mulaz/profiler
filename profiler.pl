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
    sleep 1;
} 




sub getcpu() {
    my $line=`top -b -n 1 | head | grep Cpu`;
    my $used;
    if($line=~/ (\S+?) id/s) {
	my $idle=$1;
	$used=100-$idle;
    }
    else {
	return "-1";
    }
    return $used;

}






