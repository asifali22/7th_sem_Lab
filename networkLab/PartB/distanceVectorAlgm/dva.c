#include<stdio.h>

struct node
{
	unsigned dist[20];
	unsigned from[20]; 
}rt[10];

int main()
{
	int dmat[20][20];
	int n=0,i=0,j=0,k=0,count=0;
	printf("Enter the no. of nodes\n");
	scanf("%d",&n);
	printf("Enter the cost of matrix\n");
	for ( i = 0; i < n; ++i)
	{
		for ( j = 0; j < n; ++j)
		{
			scanf("%d",&dmat[i][j]);
			dmat[i][i] = 0;
			rt[i].dist[j] = dmat[i][j];
			rt[i].from[j] = j;
		}
	}
	printf("\n\nCalculating...\n\n");
	do
	{
		count = 0;
		for ( i = 0; i < n; ++i)
			for ( j = 0; j < n; ++j)
				for ( k = 0; k < n; ++k)
					if (rt[i].dist[j] > dmat[i][k] + rt[k].dist[j])
					{
						rt[i].dist[j] = dmat[i][k] + rt[k].dist[j];
						rt[i].from[j] = k;
						count++;
					}
	} while (count!=0);

	for ( i = 0; i < n; ++i)
	{
		printf("State value for router %d is \n", i);
		for ( j = 0; j < n; ++j)
		{
			printf("\tvia %2d distance %2d\n",rt[i].from[j], rt[i].dist[j] );
		}
	}

	return 0;
}