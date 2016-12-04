set ns [new Simulator]

set tf [open 1.tr w]
$ns trace-all $tf

set nf [open 1.nam w]
$ns namtrace-all $nf

set n0 [$ns node]
set n1 [$ns node]
set n2 [$ns node]
set n3 [$ns node]

$ns color 1 "red"
$ns color 2 "blue"

$n0 label "source/udp0"
$n1 label "source/udp1"
$n2 label "router"
$n3 label "destination/null3"


$ns duplex-link $n0 $n2 10mb 300ms DropTail
$ns duplex-link $n1 $n2 10mb 300ms DropTail
$ns duplex-link $n2 $n3 0.5mb 300ms DropTail

$ns set queue-limit $n0 $n2 10
$ns set queue-limit $n1 $n2 10
$ns set queue-limit $n2 $n3 5


set udp0 [new Agent/UDP]
$ns attach-agent $n0 $udp0
set cbr0 [new Application/Traffic/CBR]
$cbr0 attach-agent $udp0

set udp1 [new Agent/UDP]
$ns attach-agent $n1 $udp1
set cbr1 [new Application/Traffic/CBR]
$cbr1 attach-agent $udp1

set null3 [new Agent/Null]
$ns attach-agent $n3 $null3


$ns connect $udp0 $null3
$ns connect $udp1 $null3

$udp0 set class_ 1
$udp1 set class_ 2

$udp1 set packetsize_ 500mb
$udp1 set interval_ 0.005

proc finish { } {
	global nf ns tf
	$ns flush-trace
	exec nam 1.nam &
	close $tf
	close $nf
	exit 0
} 

$ns at 0.1 "$cbr0 start"
$ns at 0.1 "$cbr1 start"
$ns at 10.0 "finish"

$ns run