#include<stdio.h>

int a[100],b[100],i,j,len,k,count = 0;

//Generator polynomial : g(x) = x^16 + x^12 + x^5 + 1
int gp[] = {1,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,1};

main()
{	
	void div();
	system("clear");
	printf("Enter the length of the Data format\n");
	scanf("%d",&len);
	printf("Enter the Message\n");				
	for ( i = 0; i < len; ++i)
	{
		scanf("%d",&a[i]);
	}

	//Append r(16) degree zeros to Msg bits
	for (i = 0; i < 16; ++i)
	{
	
		a[len++] = 0;
	}
	
	for ( i = 0; i < len; ++i)
	{
	
		b[i] = a[i];
	}
	//No. of times to be divided i.e Msg length	

	k = len - 16;
	
	div();

	for (i = 0; i < len; ++i)
	{
	
		b[i] = b[i]^a[i];
	}
	printf("Data to be tansmitted:\n");
	for ( i = 0; i < len; ++i)
	{
	
		printf("%2d",b[i] );
	}
	printf("\nEnter the recieved data:");
	for (i = 0; i < len; ++i)
	{
	
		scanf("%d",&a[i]);
	}

	div();
	
	for ( i = 0; i < len; ++i)
	{
		if (a[i]!=0)
		{

			printf("\nError in Recieved Data\n");
			printf("\nError is %d th bit\n", i+1 );
			goto END;
		}
	}
	printf("\nData  Recieved is Error Free\n");
		

	END: printf("\nRemainder is:\n");
	for (i = (len-16); i < len; ++i)
	{
			printf("%2d", a[i]);
	}
		printf("\n");

	
}
void div(){
	for ( i = 0; i < k; ++i)
	{
	
		if (a[i] == gp[0])
		{
	
			for ( j = i; j < 17+i; ++j)
			{
	
				a[j] = a[j]^gp[count++];
			}
			count = 0;
		}
	}
}

