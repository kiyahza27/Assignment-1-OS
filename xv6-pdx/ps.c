#ifdef CS333_P2
#include "types.h"
#include "user.h"
#include "uproc.h"

int 
main(void)
{
  uint max = 72;
  struct uproc* table = malloc(sizeof(struct uproc) * max);
  int count = getprocs(max, table);
  uint elapsed;
  uint millsec;
  uint sec;
  uint cpu;
  uint cpu_sec;
  uint cpu_millsec;

  if(count < 0) {
    printf(2, "\nFailure: an error occurred while creating the user process table.\n");
  } else {
    printf(1, "\nPID\tName\tUID\tGID\tPPID\tElapsed\tCPU\tState\tSize\n");

    for(int i = 0; i < count; ++i) {
      // process time
      elapsed = table[i].elapsed_ticks;
	  sec = (elapsed / 1000);
      millsec = (elapsed % 1000);
      // CPU time
      cpu = table[i].CPU_total_ticks;
	  cpu_sec = (cpu/1000);
      cpu_millsec = (cpu % 1000);
      
      // Print pid, name
      printf(1, "%d\t%s\t", table[i].pid, table[i].name);
      // Print uid, gid, ppid, elapsed (seconds)
      printf(1, "%d\t%d\t%d\t%d.", table[i].uid, table[i].gid, table[i].ppid, sec);
      // Print elapsed (millsec), cpu (seconds)
      printf(1, "%d\t%d.", millsec, cpu_sec);
	  // Print cpu (millsec), state, size
      printf(1, "%d\t%s\t%d\n", cpu_millsec, table[i].state, table[i].size);
    }
  }
  free(table);
  exit();
}
#endif // CS333_P2