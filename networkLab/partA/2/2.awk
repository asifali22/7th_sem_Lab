BEGIN{
	#include<stdio.h>
	tcp =0;
	udp =0;
}
{
	if($1 == "r" && $3 == "2" && $4=="3" && $5=="cbr")
		udp++;
	if($1 == "r" && $3 == "2" && $4=="3" && $5=="tcp")
		tcp++;
}
END{
	printf("UDP = %d\n", udp);
	printf("TCP = %d\n", tcp);
}