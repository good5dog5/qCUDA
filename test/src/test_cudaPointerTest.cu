#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <fcntl.h>
#include <sys/types.h>
#include <sys/stat.h>

#define COLOR_RED     "\x1b[31m"
#define COLOR_RESET   "\x1b[0m"


unsigned int BKDRHash(char *ptr, int size)
{
    unsigned int hash = 0;
    for(int i=0; i<size; i++)
        hash = (hash<<5) - hash + (*ptr++);
    return (hash);
}
void dump_proc_maps(void)
{
  pid_t PID = getpid();
  char cmd[1000];
  sprintf(cmd, "cat /proc/%d/maps", (int)PID);
  system(cmd);
}

void count_proc_maps(void)
{
  pid_t PID = getpid();
  char buf[1000];
  FILE *f;
  sprintf(buf, "/proc/%d/maps", (int)PID);

  f = fopen(buf, "rt");

  while (fgets(buf, 1000, f)) {
      unsigned int from, to, pgoff, major, minor;
      unsigned long ino;
      char flags[4];
      char info[200] = {0};
      int ret = sscanf(buf, "%x-%x %4c %x %x:%x %lu %100c ", &from, &to, flags, &pgoff, &major, &minor, &ino, info);

      // VMA that includes mmap allocated
      if (strcmp(info, "/dev/qcuda\n") == 0) {
          
          /* printf("%s", info); */
          printf("%x-%x %4c %x %x:%x %lu %s   ", from, to, flags, pgoff, major, minor, ino, "/dev/qcuda");
          printf("Size:%7d   #pages(/4096):%5d\n", to-from, (to-from)/4096);
      }
        

      /* printf("%") */
      if (ret > 8)
          break;
  }
  printf("\n\n\n");
}

int main(int argc, char * argv[])
{

  unsigned long SIZE; 
  int freezeSec; 
  void * value;
  void **ptr2;

  SIZE      = atoi(argv[1]);
  freezeSec = atoi(argv[2]);
  ptr2      = &value;


  /* printf("Before cudaHostAlloc's maps\n"); */
  /* dump_proc_maps(); */
  /* printf(COLOR_RED     "This text is RED!"     COLOR_RESET "\n"); */
  printf(COLOR_RED "Allocated %ld Kbytes" COLOR_RESET "\n", SIZE/1024);
  /* for(int i=0; i<SIZE; i++) {value[i] = 799;} */
  /* printf(COLOR_RED "[Before] hash val is %u" COLOR_RESET "\n", BKDRHash((char*)value, sizeof(int)*SIZE)); */

  cudaHostAlloc(ptr2, SIZE, 0);
  for (int i =0; i<SIZE/4; i++) {
    printf("%c", *((char*)(value+i)));
  }
  printf("\n");
  printf("After cudaHostAlloc's maps\n");
  count_proc_maps();
  /* dump_proc_maps(); */
  sleep(freezeSec);


  /* printf(COLOR_RED "[After] hash val is %u" COLOR_RESET "\n", BKDRHash((char*)value, sizeof(int)*SIZE)); */
  /* free(value); */
  /* for(int i=0; i<SIZE; i++) {printf("%d ", value[i]);} */
  printf("PASSED\n");
  return 0;
}
