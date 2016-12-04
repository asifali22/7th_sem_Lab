set ns [new Simulator]

set tf [open 2.tr w]
$ns trace-all $tf

set nf [open 2.nam w]
$ns namtrace-all $nf

set n0 [$ns node]
set n1 [$ns node]
set n2 [$ns node]
set n3 [$ns node]

$ns duplex-link $n0 $n2 10mb 300ms DropTail
$ns duplex-link $n1 $n2 10mb 300ms DropTail
$ns duplex-link $n2 $n3 0.5mb 300ms DropTail

set udp1 [new Agent/UDP]
$ns attach-agent $n1 $udp1
set cbr1 [new Application/Traffic/CBR]
$cbr1 attach-agent $udp1

set null3 [new Agent/Null]
$ns attach-agent $n3 $null3

$ns connect $udp1 $null3
$ns at 0.1 "$cbr1 start"


set tcp0 [new Agent/TCP]
$ns attach-agent $n0 $tcp0
set sink3 [new Agent/TCPSink]
$ns attach-agent $n3 $sink3
set ftp0 [new Application/FTP]
$ftp0 attach-agent $tcp0

$ns connect $tcp0 $sink3
$ns at 0.1 "$ftp0 start"

proc finish { } {
	global ns tr nf
	$ns flush-trace
	exec nam 2.nam &
	close $tf
	close $nf
	exit 0
}

$ns at 10.0 "finish"

$ns run