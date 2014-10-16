#!/usr/bin/perl
use Data::Dumper;
use Sys::Hostname;

$host = hostname;
$time=time();
$filename=$host."_".$time.".log";
open(my $fh, '>', $filename) or die "Could not open file '$filename' $!";

#print headers
print $fh "#time,cpu_used_percentage,\n";

while(1) {
    print $fh time();
    print $fh ",";
    print $fh getcpu();



    print $fh "\n";
    exit;
}




sub getcpu() {
    my $line=`top -b -n 1 | grep Cpu`;
    my $used;
    if($line=~/ (\S+?) id/s) {
	my $idle=$1;
	$used=100-$idle;
    }
    else {
	return "err";
    }
    return $used;

}






