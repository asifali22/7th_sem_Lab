set ns [new Simulator]

set tf [open 3.tr w]
$ns trace-all $tf

set nf [open 3.nam w]
$ns namtrace-all $nf

set n0 [$ns node]
set n1 [$ns node]
set n2 [$ns node]
set n3 [$ns node]
set n4 [$ns node]
set n5 [$ns node]

$ns duplex-link $n0 $n1 0.01mb 10ms DropTail
$ns duplex-link $n1 $n2 0.01mb 10ms DropTail
$ns duplex-link $n2 $n3 0.01mb 10ms DropTail
$ns duplex-link $n3 $n4 0.01mb 10ms DropTail
$ns duplex-link $n4 $n5 0.01mb 10ms DropTail
$ns duplex-link $n0 $n5 0.01mb 10ms DropTail

Agent/Ping instproc recv { from $rtt } {
	$self instvar node_
	puts "node [$node_id] received ping answer  $from with rount-trip-time of $rtt ms"
}

set P(0) [new Agent/Ping]
$ns attach-agent $n0 $P(0)
set P(1) [new Agent/Ping]
$ns attach-agent $n1 $P(1)
set P(2) [new Agent/Ping]
$ns attach-agent $n2 $P(2)
set P(3) [new Agent/Ping]
$ns attach-agent $n3 $P(3)
set P(4) [new Agent/Ping]
$ns attach-agent $n4 $P(4)
set P(5) [new Agent/Ping]
$ns attach-agent $n5 $P(5)

$ns connect $P(0) $P(1)
$ns connect $P(1) $P(2)
$ns connect $P(2) $P(3)
$ns connect $P(3) $P(4)
$ns connect $P(4) $P(5)
$ns connect $P(5) $P(0)

for { set i 0 } { $i<50 } { incr i } {
	$ns at 0.2 "$P(0) send"
	$ns at 0.2 "$P(1) send"
	$ns at 0.2 "$P(2) send"
	$ns at 0.2 "$P(3) send"
	$ns at 0.2 "$P(4) send"
	$ns at 0.2 "$P(5) send"
}

proc finish { } {
	global ns tf nf
	$ns flush-trace
	exec nam 3.nam &
	close $tf
	close $nf
	exit 0
}

$ns at 2.0 "finish"
$ns run