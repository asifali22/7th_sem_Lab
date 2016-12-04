set val(chan)	Channel/WirelessChannel;
set val(ll) 	LL;
set val(ifq)	Queue/DropTail/PriQueue;
set val(ifqLength)	50;
set val(mac)	802_11;
set val(prop)	Propagation/TwoRayGround;
set val(phy)	Phy/WirelessPhy;
set val(ant)	Antenna/OmniAntenna;

set ns [new Simulator]

set tf [open 6.tr w]
$ns trace-all $tf

set nf [open 6.nam w]
$ns namtrace-all-wireless $nf 100 100

$ns node-config 	-llType $val(ll)\
					-macType $val(mac)\
					-ifqType $val(ifq)\
					-ifqLen $val(ifqLength)\
					-antType $val(ant)\
					-propType $val(prop)\
					-phyType $val(phy)\
					-channelType $val(chan)\

set n0 [$ns node]
set n1 [$ns node]
set n2 [$ns node]
set n3 [$ns node]
set n4 [$ns node]
set n5 [$ns node]

set lan [$ns newLan "$n0 $n1 $n2 $n3 $n4 $n5" 0.5mb 300ms LL Queue/DropTail Mac/802_11 Channel/WirelessChannel]

set tcp0 [new Agent/TCP]
$ns attach-agent $n0 $tcp0
set ftp0 [new Application/FTP]
$ftp0 attach-agent $tcp0
set sink5 [new Agent/TCPSink]
$ns attach-agent $n5 $sink5

$ns connect $tcp0 $sink5

$ns at 5.000000 "$ftp0 start"

proc finish { } {
	global ns nf tf
	$ns flush-trace
	exec nam 6.nam &
	close $nf
	close $tf
	exit 0
}


$ns at 60.000 "finish"
$ns run