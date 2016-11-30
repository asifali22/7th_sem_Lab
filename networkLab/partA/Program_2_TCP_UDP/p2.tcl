set ns [new Simulator]

#open the name trace file
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

#connecting nodes and vary the crap out of it

$ns duplex-link $n0 $n2 5Mb 2ms DropTail
$ns duplex-link $n1 $n2 5Mb 2ms DropTail
$ns duplex-link $n2 $n3 5Mb 2ms DropTail

set udp0 [new Agent/UDP]
$ns attach-agent $n1 $udp0
set cbr0 [new Application/Traffic/CBR]
$cbr0 attach-agent $udp0
set null0 [new Agent/Null]
$ns attach-agent $n1 $udp0
set cbr0 [new Application/Traffic/CBR]
$cbr0 attach-agent $udp0
set null0 [new Agent/Null]
$ns attach-agent $n3 $null0
$ns connect $udp0 $null0
$ns at 1.1 "$cbr0 start"
set tcp [new Agent/TCP]
set sink [new Agent/TCPSink]
$ns attach-agent $n0 $tcp
$ns attach-agent $n3 $sink
$ns connect $tcp $sink
set ftp [new Application/FTP]
$ftp attach-agent $tcp
$ns at 1.2 "$ftp start"
$ns at 20.0 "finish"
proc finish {} {
global ns nf tf
$ns flush-trace
close $tf
close $nf
puts "Running nam..."
puts "TCP packets"
puts "UDP packets"
exec nam pal.nam &
exit 0
}
$ns run
