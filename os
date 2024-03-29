1...
#include<stdio.h>
#include<stdlib.h>
#include<unistd.h>
#include<sys/wait.h>
int main()
{
pid_t child_pid;char ch[3];
child_pid=fork();
if(child_pid==-1)
{
perror("fork");
exit(EXIT_FAILURE);
}
if(child_pid==0)
{
printf("child process(PID:%d)id running.\n",getpid());
execl("/bin/date","date",NULL);
exit(0);
}
else{
printf("Parent process is(PID:%d) waiting for child process to terminate.\n",getpid());
int status;
wait(&status);
printf("parent resumes");
if(WIFEXITED(status))
{
printf("child process(PID:%d) terminated with status %d\n",child_pid,WEXITSTATUS(status));
}
else if(WIFSIGNALED(status)){
printf("child process(PID:%d) terminated with status %d\n",child_pid,WTERMSIG(status));
}
else
{
printf("child process(PID:%d) terminated with abnormally",child_pid);
}
}
return 0;
}

2...
//FCFS
#include<stdio.h> int main()
{
int bt[20], wt[20], tat[20], i, n; 
float wtavg, tatavg;
printf("\nEnter the number of processes -- ");
scanf("%d", &n);
for(i=0;i<n;i++)
{
printf("\nEnter Burst Time for Process %d -- ", i);
scanf("%d", &bt[i]);
}
wt[0] = wtavg = 0; 
tat[0] = tatavg = bt[0];
for(i=1;i<n;i++)
{
wt[i] = wt[i-1] +bt[i-1];
tat[i] = tat[i-1] +bt[i]; 
wtavg = wtavg + wt[i];
tatavg = tatavg + tat[i];
}
printf("\t PROCESS \tBURST TIME \t WAITING TIME\t TURNAROUND TIME\n");
for(i=0;i<n;i++)
printf("\n\t P%d \t\t %d \t\t %d \t\t %d", i, bt[i], wt[i], tat[i]);
printf("\nAverage Waiting Time -- %f", wtavg/n);
printf("\nAverage Turnaround Time -- %f", tatavg/n);
}
//SJF
#include<stdio.h> int main()
{
int p[20], bt[20], wt[20], tat[20], i, k, n, temp; 
float wtavg, tatavg;
printf("\nEnter the number of processes -- ");
scanf("%d", &n);
for(i=0;i<n;i++)
{
p[i]=i;
printf("Enter Burst Time for Process %d -- ", i); 
scanf("%d", &bt[i]);
}
for(i=0;i<n;i++)
for(k=i+1;k<n;k++) 
if(bt[i]>bt[k])
{
temp=bt[i];
bt[i]=bt[k];
bt[k]=temp;
temp=p[i];
p[i]=p[k];
p[k]=temp;
}
wt[0] = wtavg = 0;
tat[0] = tatavg = bt[0];
for(i=1;i<n;i++)
{
wt[i] = wt[i-1] +bt[i-1];
tat[i] = tat[i-1] +bt[i];
wtavg = wtavg + wt[i];
tatavg = tatavg + tat[i];
}
printf("\n\t PROCESS \tBURST TIME \t WAITING TIME\t TURNAROUND TIME\n");
for(i=0;i<n;i++)
printf("\n\t P%d \t\t %d \t\t %d \t\t %d", p[i], bt[i], wt[i], tat[i]);
printf("\nAverage Waiting Time -- %f", wtavg/n);
printf("\nAverage Turnaround Time -- %f", tatavg/n);
}

//Round Robin
#include<stdio.h>
int main()
{
int i,j,n,bu[10],wa[10],tat[10],t,ct[10],max;
float awt=0,att=0,temp=0;
printf("Enter the no of processes -- ");
scanf("%d",&n);
for(i=0;i<n;i++)
{
printf("\nEnter Burst Time for process %d -- ", i+1);
scanf("%d",&bu[i]);
ct[i]=bu[i];
}
printf("\nEnter the size of time slice -- ");
scanf("%d",&t);
max=bu[0];
for(i=1;i<n;i++)
if(max<bu[i])
max=bu[i];
for(j=0;j<(max/t)+1;j++)
for(i=0;i<n;i++) 
if(bu[i]!=0)
if(bu[i]<=t)
{
tat[i]=temp+bu[i];
temp=temp+bu[i];
bu[i]=0;
}
else
{
bu[i]=bu[i]-t;
temp=temp+t;
}
for(i=0;i<n;i++)
{
wa[i]=tat[i]-ct[i];
att+=tat[i]; 
awt+=wa[i];
}
printf("\nThe Average Turnaround time is -- %f",att/n);
printf("\nThe Average Waiting time is -- %f ",awt/n);
printf("\n\tPROCESS\t BURST TIME \t WAITING TIME\tTURNAROUND TIME\n");
for(i=0;i<n;i++)
printf("\t%d \t %d \t\t %d \t\t %d \n",i+1,ct[i],wa[i],tat[i]);
}

//Priority
#include<stdio.h> 
int main()
{
int p[20],bt[20],pri[20], wt[20],tat[20],i, k, n, temp;
float wtavg, tatavg;
printf("Enter the number of processes --- ");
scanf("%d",&n);
for(i=0;i<n;i++)
{
p[i] = i;
printf("Enter only positive numbers\n");
printf("Enter the Burst Time & Priority of Process %d --- ",i);
scanf("%d %d",&bt[i], &pri[i]);
}
for(i=0;i<n;i++)
for(k=i+1;k<n;k++) 
if(pri[i] > pri[k])
{
temp=p[i];
p[i]=p[k];
p[k]=temp;
temp=bt[i]; 
bt[i]=bt[k];
bt[k]=temp;
temp=pri[i];
pri[i]=pri[k];
pri[k]=temp;
}
wtavg = wt[0] = 0;
tatavg = tat[0] = bt[0];
for(i=1;i<n;i++)
{
wt[i] = wt[i-1] + bt[i-1];
tat[i] = tat[i-1] + bt[i]; 
wtavg = wtavg + wt[i];
tatavg = tatavg + tat[i];
}
printf("\nPROCESS\t\tPRIORITY\tBURST TIME\tWAITING TIME\tTURNAROUND TIME");
for(i=0;i<n;i++)
printf("\n%d \t\t %d \t\t %d \t\t %d \t\t %d ",p[i],pri[i],bt[i],wt[i],tat[i]);
printf("\nAverage Waiting Time is --- %f",wtavg/n);
printf("\nAverage Turnaround Time is --- %f",tatavg/n);
}

3......

//producer consumer
#include<stdio.h>
#include <stdlib.h>
int mutex = 1;
int full = 0;
int empty = 3, x = 0;
void producer()
{
--mutex;
++full;
--empty;
x++;
printf("\nProducer produces item %d",x);
++mutex;
}
void consumer()
{
--mutex;
--full;
++empty;
printf("\nConsumer consumes item %d",x); x--;
++mutex;
}
int main()
{
int n, i;
printf("\n1. Press 1 for Producer" "\n2. Press 2 for Consumer" "\n3. Press 3 for Exit"); 
for (i = 1; i > 0; i++) {
printf("\nEnter your choice:");
scanf("%d", &n);
// Switch Cases switch (n) {
case 1:
if ((mutex == 1) && (empty != 0))
{
producer();
}
else
{
printf("Buffer is full!");
}
break;
case 2:
if ((mutex == 1)&& (full != 0))
{
consumer();
}
else
{
printf("Buffer is empty!");
}
break;
case 3: 
exit(0); 
break;
}
}
}


4.......
#include <stdio.h> 
#include <fcntl.h> 
#include <sys/stat.h> 
#include <sys/types.h> 
#include <unistd.h>
int main()
{
int fd;
char buf[1024]="Hello BIT";
char * myfifo = "/tmp/guest-uivabk/Desktop/tmp"; 
mkfifo(myfifo, 0666);
printf("Run Reader process to read the FIFO File\n"); 
fd = open(myfifo, O_WRONLY); 
write(fd,buf,sizeof(buf));
close(fd);
unlink(myfifo);
return 0;
}
/* Reader Process */

#include <fcntl.h> 
#include <sys/stat.h>
#include <sys/types.h>
#include <unistd.h>
#include <stdio.h> 
#define MAX_BUF 1024
int main()
{
int fd;
char *myfifo = "/tmp/guest-uivabk/Desktop/tmp"; 
char buf[MAX_BUF];
fd = open(myfifo, O_RDONLY);
read(fd, buf, MAX_BUF);
printf("Reader process has read : %s\n", buf);
close(fd);
return 0;
}

5......

#include<stdio.h> 
struct file
{
int all[10];
int max[10];
int need[10];
int flag;
};
void main()
{
struct file f[10];
int fl;
int i, j, k, p, b, n, r, g, cnt=0, id, newr;
int avail[10],seq[10];
printf("Enter number of processes -- ");
scanf("%d",&n);
printf("Enter number of resources -- "); 
scanf("%d",&r);
for(i=0;i<n;i++)
{
printf("Enter details for P%d",i);
printf("\nEnter allocation\t -- \t"); 
for(j=0;j<r;j++)
scanf("%d",&f[i].all[j]);
printf("Enter Max\t\t -- \t"); 
for(j=0;j<r;j++) 
scanf("%d",&f[i].max[j]);
f[i].flag=0;
}
printf("\nEnter Available Resources\t -- \t");
for(i=0;i<r;i++)
scanf("%d",&avail[i]);
for(i=0;i<n;i++)
{
for(j=0;j<r;j++)
{
f[i].need[j]=f[i].max[j]-f[i].all[j]; 
if(f[i].need[j]<0)
f[i].need[j]=0;
}
}
cnt=0;
fl=0;
while(cnt!=n)
{ 
g=0;
for(j=0;j<n;j++)
{
if(f[j].flag==0)
{ 
b=0;
for(p=0;p<r;p++)
{
if(avail[p]>=f[j].need[p]) 
b=b+1;
else
b=b-1;
}
if(b==r)
{
printf("\nP%d is visited",j);
seq[fl++]=j; 
f[j].flag=1; 
for(k=0;k<r;k++)
avail[k]=avail[k]+f[j].all[k]; 
cnt=cnt+1;
printf("(");
for(k=0;k<r;k++)
printf("%3d",avail[k]);
printf(")"); 
g=1;
}
}
}
if(g==0)
{
printf("\n REQUEST NOT GRANTED -- DEADLOCK OCCURRED"); 
printf("\n SYSTEM IS IN UNSAFE STATE");
goto y;
}
}
printf("\nSYSTEM IS IN SAFE STATE");
printf("\nThe Safe Sequence is -- ("); 
for(i=0;i<fl;i++)
printf("P%d ",seq[i]);
printf(")");
y: printf("\nProcess\t\tAllocation\t\tMax\t\t\tNeed\n"); 
for(i=0;i<n;i++)
{
printf("P%d\t",i); 
for(j=0;j<r;j++) 
printf("%6d",f[i].all[j]);
for(j=0;j<r;j++)
printf("%6d",f[i].max[j]);
for(j=0;j<r;j++)
printf("%6d",f[i].need[j]);
printf("\n");
}
}

6.......
//**********FIRST FIT********** #include<stdio.h>
#define max 25
void main()
{
int frag[max],b[max],f[max],i,j,nb,nf,temp; static int bf[max],ff[max];
printf("\n\tMemory Management Scheme - First Fit"); 
printf("\nEnter the number of blocks:"); 
scanf("%d",&nb);
printf("Enter the number of files:");
scanf("%d",&nf);
printf("\nEnter the size of the blocks:-\n");
for(i=1;i<=nb;i++)
{
printf("Block %d:",i);
scanf("%d",&b[i]);
}
printf("Enter the size of the files :-\n"); 
for(i=1;i<=nf;i++)
{
printf("File %d:",i);
scanf("%d",&f[i]);
}
for(i=1;i<=nf;i++)
{
for(j=1;j<=nb;j++)
{
if(bf[j]!=1)
{
temp=b[j]-f[i]; 
if(temp>=0)
{
ff[i]=j; 
break;
}
}
}
frag[i]=temp; 
bf[ff[i]]=1;
}
printf("\nFile_no:\tFile_size :\tBlock_no:\tBlock_size:\tFragement"); 
for(i=1;i<=nf;i++)
printf("\n%d\t\t%d\t\t%d\t\t%d\t\t%d",i,f[i],ff[i],b[ff[i]],frag[i]);
//getch();
}
BEST FIT
#include<stdio.h> 
#define max 25
void main()
{
int frag[max],b[max],f[max],i,j,nb,nf,temp,lowest=10000;
static int bf[max],ff[max];
printf("\n\tMemory Management Scheme - Best Fit"); 
printf("\nEnter the number of blocks:");
scanf("%d",&nb);
printf("Enter the number of files:"); 
scanf("%d",&nf);
printf("\nEnter the size of the blocks:-\n"); 
for(i=1;i<=nb;i++)
{
printf("Block %d:",i);
scanf("%d",&b[i]);
}
printf("Enter the size of the files :-\n");
for(i=1;i<=nf;i++)
{
printf("File %d:",i);
scanf("%d",&f[i]);
}
for(i=1;i<=nf;i++)
{
for(j=1;j<=nb;j++)
{
if(bf[j]!=1)
{
temp=b[j]-f[i]; 
if(temp>=0)
if(lowest>temp)
{
ff[i]=j;
lowest=temp;
}
}
}
frag[i]=lowest;
bf[ff[i]]=1; 
lowest=10000;
}
printf("\nFile No\tFile Size \tBlock No\tBlock Size\tFragment"); 
for(i=1;i<=nf && ff[i]!=0;i++)
printf("\n%d\t\t%d\t\t%d\t\t%d\t\t%d",i,f[i],ff[i],b[ff[i]],frag[i]);
//getch();
}

WORST FIT

#include<stdio.h>
#define max 25 
void main()
{
int frag[max],b[max],f[max],i,j,nb,nf,temp,highest=0; 
static int bf[max],ff[max];
printf("\n\tMemory Management Scheme - Worst Fit");
printf("\nEnter the number of blocks:"); 
scanf("%d",&nb);
printf("Enter the number of files:");
scanf("%d",&nf);
printf("\nEnter the size of the blocks:-\n"); 
for(i=1;i<=nb;i++)
{
printf("Block %d:",i);
scanf("%d",&b[i]);
}
printf("Enter the size of the files :-\n"); 
for(i=1;i<=nf;i++)
{
printf("File %d:",i);
scanf("%d",&f[i]);
}
for(i=1;i<=nf;i++)
{
for(j=1;j<=nb;j++)
{
if(bf[j]!=1) 
{
temp=b[j]-f[i]; 
if(temp>=0) 
if(highest<temp)
{
ff[i]=j; 
highest=temp;
}
}
}
frag[i]=highest; 
bf[ff[i]]=1; 
highest=0;
}
printf("\nFile_no:\tFile_size :\tBlock_no:\tBlock_size:\tFragement"); 
for(i=1;i<=nf;i++)
printf("\n%d\t\t%d\t\t%d\t\t%d\t\t%d",i,f[i],ff[i],b[ff[i]],frag[i]);
}


7......
//FIFO #include<stdio.h> void main()
{
int i, j, k, f, pf=0, count=0, rs[25], m[10], n;
printf("\n Enter the length of reference string -- "); 
scanf("%d",&n);
printf("\n Enter the reference string -- "); 
for(i=0;i<n;i++)
scanf("%d",&rs[i]);
printf("\n Enter no. of frames -- "); 
scanf("%d",&f);
for(i=0;i<f;i++)
m[i]=-1;
printf("\n The Page Replacement Process is -- \n");
for(i=0;i<n;i++)
{
for(k=0;k<f;k++)
{
if(m[k]==rs[i]) 
break;
}
if(k==f)
{
m[count++]=rs[i]; 
pf++;
}
for(j=0;j<f;j++)
printf("\t%d",m[j]); 
if(k==f)
printf("\tPF No. %d",pf);
printf("\n"); 
if(count==f) 
count=0;
}
printf("\n The number of Page Faults using FIFO are %d",pf);
}

//LRU
#include<stdio.h>
int main()
{
int i, j , k, min, rs[25], m[10], count[10], flag[25], n, f, pf=0, next=1;
printf("Enter the length of reference string -- ");
scanf("%d",&n);
printf("Enter the reference string -- "); 
for(i=0;i<n;i++)
{
scanf("%d",&rs[i]); 
flag[i]=0;
}
printf("Enter the number of frames -- "); 
scanf("%d",&f);
for(i=0;i<f;i++)
{
count[i]=0;
m[i]=-1;
}
printf("\nThe Page Replacement process is -- \n"); 
for(i=0;i<n;i++)
{
for(j=0;j<f;j++)
{
if(m[j]==rs[i])
{
flag[i]=1; 
count[j]=next; 
next++;
}
}
if(flag[i]==0)
{
if(i<f)
{
m[i]=rs[i]; 
count[i]=next; 
next++;
}
else
{
min=0; 
for(j=1;j<f;j++)
if(count[min] > count[j]) 
min=j;
m[min]=rs[i];
count[min]=next;
next++;
}
pf++;
}
for(j=0;j<f;j++) 
printf("%d\t", m[j]); 
if(flag[i]==0)
printf("PF No. -- %d" , pf); 
printf("\n");
}
printf("\nThe number of page faults using LRU are %d",pf);
}


8.......

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#define MAX_FILES 10
#define MAX_FILENAME_LENGTH 10
char directoryName[MAX_FILENAME_LENGTH];
char filenames[MAX_FILES][MAX_FILENAME_LENGTH];
int fileCount = 0;
void createFile() {
if (fileCount < MAX_FILES) {
char filename[MAX_FILENAME_LENGTH]; printf("Enter the name of the file: ");
scanf("%s", filename); strcpy(filenames[fileCount], filename); 
fileCount++;
printf("File %s created.\n", filename);
}
else {
printf("Directory is full, cannot create more files.\n");
}
}
void deleteFile() { 
if (fileCount == 0)
{
printf("Directory is empty, nothing to delete.\n"); 
return;
}
char filename[MAX_FILENAME_LENGTH];
printf("Enter the name of the file to delete: ");
scanf("%s", filename);
int found = 0;
for (int i = 0; i < fileCount; i++) 
{
if (strcmp(filename, filenames[i]) == 0) 
{ found = 1;
printf("File %s is deleted.\n", filename); 
strcpy(filenames[i], filenames[fileCount - 1]); 
fileCount--;
break;
}
}
if (!found) {
printf("File %s not found.\n", filename);
}
}
void displayFiles() { 
if (fileCount == 0) {
printf("Directory is empty.\n");
} else
{
printf("Files in the directory %s:\n", directoryName); 
for (int i = 0; i < fileCount; i++) {
printf("\t%s\n", filenames[i]);
}
}
}
int main() {
printf("Enter the name of the directory: "); 
scanf("%s", directoryName);
while (1) {
printf("\n1. Create File\t2. Delete File\t3. Search File\n4. Display Files\t5. Exit\nEnter your choice:"); 
int choice;
scanf("%d", &choice); 
switch (choice) {
case 1:
createFile(); 
break;
case 2:
deleteFile(); 
break;
case 3:
printf("Enter the name of the file: ");
char searchFilename[MAX_FILENAME_LENGTH];
scanf("%s", searchFilename);
int found = 0;
for (int i = 0; i < fileCount; i++) {
if (strcmp(searchFilename, filenames[i]) == 0) 
{ found = 1;
printf("File %s is found.\n", searchFilename); 
break;
}
}
if (!found) {
printf("File %s not found.\n", searchFilename);
}
break; 
case 4:
displayFiles();
break;
case 5:
exit(0); 
default:
printf("Invalid choice, please try again.\n");
}
}
return 0;
}


9......
#include <stdio.h> 
#include <stdlib.h> 
int main(){
int f[50], p, i, st, len, j, c, k, a, fn=0;
for (i = 0; i < 50; i++) f[i] = 0;
/* printf("Enter how many blocks already allocated: "); 
scanf("%d", &p);
printf("Enter blocks already allocated: ");
for (i = 0; i < p; i++) {
scanf("%d", &a);
f[a] = 1;
}*/
x:
fn=fn+1;
printf("Enter index starting block and length: "); 
scanf("%d%d", &st, &len);
k = len;
if (f[st] == 0)
{
for (j = st; j < (st + k); j++)
{ 
if (f[j] == 0)
{
f[j] = fn;
printf("%d ------ >%d\n", j, f[j]);
}
else{
printf("%d Block is already allocated \n", j);
k++;
}
}
}
else
printf("%d starting block is already allocated \n", st);
printf("Do you want to enter more file(Yes - 1/No - 0)");
scanf("%d", &c);
if (c == 1)
goto x;
else
exit(0); 
return 0;
}

10......
#include<stdio.h>
int main()
{
int t[20], d[20], h, i, j, n, temp, k, atr[20], tot, p, sum=0;
printf("enter the no of tracks to be traveresed"); 
scanf("%d'",&n);
printf("enter the position of head"); 
scanf("%d",&h);
t[0]=0;
t[1]=h;
printf("enter the tracks"); 
for(i=2;i<n+2;i++) 
scanf("%d",&t[i]);
for(i=0;i<n+2;i++)
{
for(j=0;j<(n+2)-i-1;j++)
{
if(t[j]>t[j+1])
{
temp=t[j];
t[j]=t[j+1]; 
t[j+1]=temp;
}
}
}
for(i=0;i<n+2;i++)
if(t[i]==h)
{
j=i; 
k=i;
p=0;
}
while(t[j]!=0)
{
atr[p]=t[j];
j--;
p++;
}
atr[p]=t[j];
for(p=k+1;p<n+2;p++,k++)
atr[p]=t[k+1];
printf("seek sequence is:");
for(j=0;j<n+1;j++)
{
if(atr[j]>atr[j+1])
d[j]=atr[j]-atr[j+1]; 
else
d[j]=atr[j+1]-atr[j]; 
sum+=d[j]; 
printf("\n%d", atr[j]);
}
printf("\nTotal head movements:%d",sum);
}
