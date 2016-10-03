BEGIN{
#include<stdio.h>

tcp=0;
udp=0;
}

{
if($1 == "r" && $3== "2" && $4 =="3" && $5 == "tcp")
tcp++;

if($1 =="r" && $3 == "2" && $4 == "3" && $5 =="cbr")
udp++;

}

END{
printf("\n Total number of brackets sent by TCP: %d\n",tcp);
printf("\nTotal number of packets sent by udp:%d\n", udp);
}

