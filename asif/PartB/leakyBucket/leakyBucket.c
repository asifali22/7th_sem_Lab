#include <stdio.h>
int min(int x, int y){
	if(x<y)
		return x;
	else
		return y;
}

int main(){

	int drop=0, mini, nsec, cap, count=0, i, inp[25], process;
	system("clear");
	printf("Enter the bucket size\n");
	scanf("%d", &cap);
	printf("Enter the transmission rate\n");
	scanf("%d",&process);
	printf("Enter the no. of seconds you want to simulate\n");
	scanf("%d",&nsec);
	for(i=0;i<nsec;i++){
		printf("Enter the size of the packet entering at %d sec\n",i+1 );
		scanf("%d",&inp[i]);
	}
	printf("\nSecond|Packet Rec|Packet Sent|Packet left | Packet Dropped\n");
	printf("-----------------------------------------------\n");
	for (i = 0; i < nsec; ++i)
	{
		count+=inp[i];
		if(count>cap){
			drop = count - cap;
			count = cap;
		}
		printf("%d",i+1 );
		printf("\t%d",inp[i] );
		mini = min(count, process);
		printf("\t\t%d",mini);
		count-=mini;
		printf("\t\t%d",count );
		printf("\t\t%d\n",drop );
		drop =0 ;
	}
	for (; count!=0; ++i)
	{
		if (count > cap)
		{
			drop = count - cap;
			count = cap;
		}
		printf("%d",i+1 );
		printf("\t0");
		mini = min(count, process);
		printf("\t\t%d",mini);
		count -= mini;
		printf("\t\t%d",count);
		printf("\t\t%d\n",drop);
	}
}