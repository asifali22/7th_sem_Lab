set ns [new Simulator]

set tf [open 4.tr w]
$ns trace-all $tf

set nf [open 4.nam w]
$ns namtrace-all $nf

set n0 [$ns node]
set n1 [$ns node]
set n2 [$ns node]
set n3 [$ns node]
set n4 [$ns node]
set n5 [$ns node]
set n6 [$ns node]

$ns make-lan "$n0 $n1 $n2 $n3" 10mb 10ms LL Queue/DropTail Mac/802_3
$ns make-lan "$n4 $n5 $n6" 10mb 10ms LL Queue/DropTail Mac/802_3

$ns duplex-link $n2 $n6 10mb 10ms DropTail

set udp0 [new Agent/UDP]
$ns attach-agent $n0 $udp0
set cbr0 [new Application/Traffic/CBR]
$cbr0 attach-agent $udp0
set null5 [new Agent/Null]
$ns attach-agent $n5 $null5

$ns connect $udp0 $null5

set err [new ErrorModel]
$ns lossmodel $err $n2 $n6
$err set rate_ 0.2

proc finish { } {
	global ns nf tf
	$ns flush-trace
	exec nam 4.nam &
	close $tf
	close $nf
	exit 0
}

$ns at 0.1 "$cbr0 start"
$ns at 10.0 "finish"
$ns run