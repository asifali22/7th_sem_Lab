/*
	CLIENT File
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
	
	int sockfd, n;
	struct sockaddr_in serv_addr,cli_addr;
	char filename[100],buf[1000];
	serv_addr.sin_family = AF_INET;
	serv_addr.sin_addr.s_addr = inet_addr(SERV_HOST_ADDR);
	serv_addr.sin_port = htons(SERV_TCP_PORT);

	// Instructions
	printf("\n\nNote:\n 1) First run server.c in one terminal and then client.c in separate terminal\n\n 2) A file should exist in the directory whose name will be given for FILENAME\n\n");
	
	if ((sockfd = socket(AF_INET, SOCK_STREAM, 0)) < 0)
		printf("\nClient: Can't open stream socket\n");
	else
		printf("\nClient: Stream socket opened successfully\n");
	
	if(connect(sockfd,(struct sockaddr *)&serv_addr,sizeof(serv_addr))<0)
        printf("\nClient: Can't connect to server\n");
    else
    	printf("\nClient: Connected to server successfully\n");
    printf("\nEnter the filename to be displayed: ");
    scanf("%s",filename);
    write(sockfd, filename,strlen(filename));
    printf("\nFilename transfered to server\n");
    n = read(sockfd,buf,1000);
    if (n<0)
    printf("\nError reading from socket\n");

    printf("\nClient: Displaying file content of %s\n\n\n",filename );
    fputs(buf, stdout);
    printf("\n\n");

    // Instructions
    printf("Note: To execute again, close all terminals and re-run the files again on separte terminals\n\n");
    close(sockfd);
    exit(0);
    
	return 0;
}