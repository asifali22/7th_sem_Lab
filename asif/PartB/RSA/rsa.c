#include<math.h>
#include<stdlib.h>
#include<stdio.h>
#include<string.h>
int gcd(long m,long n)
{
  while(n!=0)
  {
    long r=m%n;
    m=n;
    n=r;
  }
  return m;
}
int rsa(char message[])
{
  long p=0,q=0,n=0,e=0,d=0,phi=0;
  long nummes[100]={0};
  long encrypted[100]={0},decrypted[100]={0};
  long i=0,j=0,nofelem=0;
  
  printf("\nEnter value of p and q : ");
  scanf("%ld%ld",&p,&q);
  
  n=p*q;

  phi=(p-1)*(q-1);
  
  for(i=2;i<phi;i++)
   if(gcd(i,phi)==1)
    break;
  e=i;
  
  for(i=2;i<phi;i++)
   if((e*i-1)%phi==0)
    break;
  d=i;
  
  for(i=0;i<strlen(message);i++)
   nummes[i]=message[i]-96;
  nofelem=strlen(message);

  for(i=0;i<nofelem;i++)
  {
    encrypted[i]=1;
    for(j=0;j<e;j++)
     encrypted[i]=(encrypted[i]*nummes[i])%n;
  }
  printf("\nEncrypted message : ");
  for(i=0;i<nofelem;i++)
   printf("%ld",encrypted[i]);

  for(i=0;i<nofelem;i++)
  {
    decrypted[i]=1;
    for(j=0;j<d;j++)
      decrypted[i]=(decrypted[i]*encrypted[i])%n;
  }
  printf("\nDecrypted message : ");
  for(i=0;i<nofelem;i++)
   printf("%c",(char)(decrypted[i]+96));
  printf("\n"); 
  return 0;
}
int main()
{
  char msg[100];
  printf("\nEnter the message to be encrypted : ");
  scanf("%s", msg);
  rsa(msg);
} 
