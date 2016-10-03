set ns [new Simulator]

#open the nam trace file
set tf [open pal.tr w]
$ns trace-all $tf

set nf [open pal.nam w]
$ns namtrace-all $nf

#creating nodes
set n0 [$ns node]
set n1 [$ns node]
set n2 [$ns node]
set n3 [$ns node]


#give the color to the packet
$ns color 1 "red"
$ns color 2 "blue"


#assigning labels to the nodes
$n0 label "Source/udp0"
$n1 label "Source/udp1"
$n2 label "Router"
$n3 label "Destination/Null"

#connecting nodes and vary below bandwidth and see the no of packet
$ns duplex-link $n0 $n2 10Mb 300ms DropTail
$ns duplex-link $n1 $n2 10Mb 300ms DropTail
$ns duplex-link $n2 $n3 1Mb 300ms DropTail

#below code is used to set the queue size below nodes
$ns set queue-limit $n0 $n2 10
$ns set queue-limit $n1 $n2 10
$ns set queue-limit $n2 $n3 5

set udp0 [new Agent/UDP]
$ns attach-agent $n0 $udp0
set cbr0 [new Application/Traffic/CBR]
$cbr0 attach-agent $udp0
set null3 [new Agent/Null]
$ns attach-agent $n3 $null3
set udp1 [new Agent/UDP]
$ns attach-agent $n1 $udp1
set cbr1 [new Application/Traffic/CBR]
$cbr1 attach-agent $udp1
;

#below code sets the udp0 packet to red and udp1 packet to 0 blue color
$udp0 set class_ 1
$udp1 set class_ 2

#below code us used to correct the agent
$ns connect $udp0 $null3
$ns connect $udp1 $null3

#below code is used to correct the agent
$cbr1 set packetSize_ 500mb
$cbr1 set interval_ 0.005
proc finish { } {
global ns nf tf
$ns flush-trace

#execute nam on the trace file
exec nam pal.nam &

#close the trace file
close $tf
close $nf
exit 0
}

$ns at 0.1 "$cbr0 start"
$ns at 0.1 "$cbr1 start"
$ns at 10.0 "finish"
$ns run
