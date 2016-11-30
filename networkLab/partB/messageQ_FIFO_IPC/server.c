#include <stdio.h>
#include <fcntl.h>
#include <stdlib.h>
#include <string.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <unistd.h>
int main()
{
	
	char filename[100], buf[100], buf1[100];
	int num, num2, n, filesize, f1, fd, fd2;
	mknod("fifo1", S_IFIFO | 0666,0);
	mknod("fifo2", S_IFIFO | 0666,0);
	printf("\nServer online\n");
	fd = open("fifo1", O_RDONLY);
	printf("\nClient Queue! waiting for request...\n");
	while(1){
		num  = read(fd, filename, 100);
		filename[num] = '\0';
		f1 = open(filename,O_RDONLY);
		printf("\nServer: %s is found!\nTranferring the contents: ",filename );
		filesize = lseek(f1, 0, 2);
		printf("File size is %d\n",filesize);
		lseek(f1, 0, 0);
		n = read(f1, buf1, filesize);
		buf1[n] = '\0';
		fd2 = open("fifo2",O_WRONLY);
		write(fd2, buf1, strlen(buf1));
		printf("Server: Transfer completed\n");
		exit(1);
	}
	unlink("fifo1");
	unlink("fifo2");
	
	return 0;
}