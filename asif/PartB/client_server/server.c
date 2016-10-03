/*
	SERVER File	
*/

#include<stdio.h>
#include<sys/types.h>
#include<sys/socket.h>
#include<netinet/in.h>
#include<arpa/inet.h>
#include<fcntl.h>
#include<string.h>
#include<stdlib.h>

#define SERV_TCP_PORT 6880
#define SERV_HOST_ADDR "127.0.0.1"

int main()
{
    	
    int sockfd, newsockfd, clilen, fd;
    int  n, m = 0;
    struct sockaddr_in cli_addr, serv_addr;
    char filename[25], buf[1000];
   
	if((sockfd=socket(AF_INET,SOCK_STREAM,0))<0)
		printf("\nServer:cant open stream socket\n");
	else
		printf("\nServer:stream socket opened successfully\n");
	serv_addr.sin_family=AF_INET;
	serv_addr.sin_addr.s_addr=htonl(INADDR_ANY);
	serv_addr.sin_port=htons(SERV_TCP_PORT);
	if((bind(sockfd,(struct sockaddr *)&serv_addr,sizeof(serv_addr)))<0)
		printf("\nServer:cant bind local address\n");
	else
		printf("\nServer:bound to local address\n");
	listen(sockfd,5);
	printf("\n SERVER : Waiting for client...\n");
	for(;;)
	{
		clilen = sizeof(cli_addr);
		newsockfd = accept(sockfd,(struct sockaddr *)&cli_addr,&clilen);
		if (newsockfd < 0)
			printf("\nServer: Accept Error\n");
		else
			printf("\nServer: Accepted\n");
		n = read(newsockfd,filename,25);
		filename[n] = '\0';
		printf("\nServer: %s is found and ready to transfer\n",filename );
		fd = open(filename,O_RDONLY);
		n = read(fd, buf, 1000);
		buf[n] = '\0';
		write(newsockfd,buf,n);
		printf("Transfer success\n");
		close(newsockfd);
		exit(0);
		
	}

	return 0;
}