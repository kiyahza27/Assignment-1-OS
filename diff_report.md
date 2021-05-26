<h1 align="center"> CODE  MODIFICATION REPORT </h1> 

## Makefile
- #### Line 3
```
CS333_PROJECT ?= 2
```

## defs.h
- #### Line 12
```
struct uproc; // CS333_P2
```
- #### Line 134 - 141
```
#ifdef CS333_P2
uint            getuid(void);
uint            getgid(void);
uint            getppid(void);
int             setuid(uint);
int             setgid(uint);
int		getprocs(uint max, struct uproc * table);
#endif // CS333_P2
```

## param.h
- #### Line 19 - 22
```
#ifdef CS333_P2
#define DEFAULT_UID  0   // default uid
#define DEFAULT_GID  0   // default gid
#endif // CS333_P2
```

## proc. c
- #### Line 9
```
#include "uproc.h" //CS333_P2
```
- #### Line 156 - 159
```
#ifdef CS333_P2
  p->cpu_ticks_total = 0;
  p->cpu_ticks_in = 0;
#endif //CS333_P2
```
- #### Line 188 - 192
```
#ifdef CS333_P2
  p->parent = p;
  p->uid = DEFAULT_UID;
  p->gid = DEFAULT_GID;
#endif //CS333_P2
```
- #### Line 254 - 257
```
#ifdef CS333_P2
  np->uid = curproc->uid;
  np->gid = curproc->gid;
#endif // CS333_P2
```
- #### Line 413 - 415
```
#ifdef CS333_P2
	  p->cpu_ticks_in = ticks;
#endif // CS333_P2
```
- #### Line 458 - 460
```
#ifdef CS333_P2
  p->cpu_ticks_total += ticks - p->cpu_ticks_in;
#endif // CS333_P2
```

- #### Line 585 - 618
```
#if defined(CS333_P2)
void
procdumpP2P3P4(struct proc *p, char *state_string)
{
  // cprintf("TODO for Project 2, delete this line and implement procdumpP2P3P4() in proc.c to print a row\n");
  
  uint elapsed;
  uint millsec;
  uint sec;
  uint cpu;
  uint cpu_sec;
  uint cpu_millsec;
  uint ppid;
  
  if(p->parent)
  {
    ppid = p->parent->pid;
  }
  else
  {
    ppid = p->pid;
  }
  
  elapsed = ticks - p->start_ticks;
  sec = elapsed / 1000;
  millsec = elapsed % 1000;
  cpu = p->cpu_ticks_total;
  cpu_sec = cpu/1000;
  cpu_millsec = cpu%1000;

  cprintf("%d\t%s\t\t%d\t%d\t%d\t%d.%d\t%d.%d\t%s\t%d\t", p->pid, p->name, p->uid, p->gid, ppid,  sec, millsec, cpu_sec, cpu_millsec, state_string, p->sz);
  return;
}
#endif //CS333_P2
```
- #### Line 690 - 720
```
int
getprocs(uint max, struct uproc* table)
{
  int count = 0;
  struct proc* p = ptable.proc;

  acquire(&ptable.lock);
  while(p < &ptable.proc[NPROC] && count < max) {
    if(p->state != UNUSED && p->state != EMBRYO) {
      table->pid = p->pid;
      table->uid = p->uid;
      table->gid = p->gid;
      ++count;
      if(p->parent)
        table->ppid = p->parent->pid;
      else
        table->ppid = p->pid;
      table->elapsed_ticks = (ticks - p->start_ticks);
      table->CPU_total_ticks = p->cpu_ticks_total;
      safestrcpy(table->state, states[p->state], STRMAX);
      table->size = p->sz;
      safestrcpy(table->name, p->name, STRMAX);
      ++table;
    }
    ++p;
  }
  release(&ptable.lock);
  return count;
}
#endif // CS333_P2
```

## proc.h
- #### Line 56 - 61
```
#ifdef CS333_P2
  uint gid;
  uint uid;
  uint cpu_ticks_total;//elapsed ticks in cpu
  uint cpu_ticks_in; // scheduled ticks
#endif //CS333_P2
```

## ps.c (file baru)
```
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
```

## runoff.list
- #### Line 95 - 97
```
testsetuid.c
ps.c
time.c
```

## syscall.c
- #### Line 12 - 19
```
#ifdef CS333_P2
extern int sys_getuid(void);
extern int sys_getgid(void); 
extern int sys_getppid(void);
extern int sys_setuid(void);
extern int sys_setgid(void);
extern int sys_getprocs(void);
#endif //CS333_P2
```
- #### Line 149 - 156
```
#ifdef CS333_P2
[SYS_getuid]    sys_getuid,
[SYS_getgid]    sys_getgid,
[SYS_getppid]   sys_getppid,
[SYS_setuid]    sys_setuid,
[SYS_setgid]    sys_setgid,
[SYS_getprocs]  sys_getprocs,
#endif //CS333_P2
```
- #### Line 188 - 195
```
#ifdef CS333_P2
  [SYS_getuid]    "getuid",
  [SYS_getgid]    "getgid",
  [SYS_getppid]   "getppid",
  [SYS_setuid]    "setuid",
  [SYS_setgid]    "setgid",
  [SYS_getprocs]  "getprocs",
#endif //CS333_P2
```

## syscall.h
- #### Line 26 - 32
```
// CS333_P2
#define SYS_getuid	SYS_date+1
#define SYS_getgid	SYS_getuid+1
#define SYS_getppid	SYS_getgid+1
#define SYS_setuid	SYS_getppid+1
#define SYS_setgid	SYS_setuid+1
#define SYS_getprocs  SYS_setgid+1
```

## sysproc.c
- #### Line 9
```
#include "uproc.h" // CS333_P2
```

- #### Line 117 - 178
```
#ifdef CS333_P2
uint
sys_getuid(void)
{
  return myproc()->uid;
}

uint
sys_getgid(void)
{
  return myproc()->gid;
}

uint
sys_getppid(void)
{
  return myproc()->parent->pid;
}

int
sys_setuid(void)
{
  int n;
  if(argint(0, &n) < 0){
    return -1;
  }
  if(n < 0 || n > 32767){
    return -1;
  }
  myproc()->uid = n;
  return 0;
}

int
sys_setgid(void)
{
  int n;
  if(argint(0, &n) < 0){
    return -1;
  }
  if(n < 0 || n > 32767){
    return -1;
  }
  myproc()->gid = n;
  return 0;
}

int
sys_getprocs(void)
{
  int max;
  struct uproc* table;

  if(argint(0, &max) < 0){
    return -1;
  }
  if(argptr(1, (void*) &table, sizeof(struct uproc) * max) < 0){
    return -1;
  }
  return getprocs(max,table);
}
#endif // CS333_P2
```

## testsetuid.c (tambahan file baru)
```
#ifdef CS333_P2
#include "types.h"
#include "user.h"

int
main(int argc, char *argv[])
{
  printf(1, "***** In %s: my uid is %d\n\n", argv[0], getuid());
  exit();
}
#endif
```

## time.c (file baru)
```
#ifdef CS333_P2
#include "types.h"
#include "user.h"

int
main(int argc, char * argv[])
{
    if (argc <= 0) {
        exit();
    }
    uint start_time = 0, end_time = 0, pid = 0,
         elapsed = 0, sec = 0, millsec_ten = 0, millsec_hund = 0, millsec_thou = 0;
    if (argc == 1) {
        printf(1, "%s ran in 0.000 seconds\n", argv[0]);
        exit();
    }
    start_time = uptime(); 
    pid = fork(); 
    if (pid > 0) {
        pid = wait();
    }
    else if (pid == 0) {
        exec(argv[1], (argv+1));
        exit();
    }
    end_time = uptime(); 
    elapsed= (end_time - start_time); 
    sec = (elapsed / 1000);
    millsec_ten = ((elapsed %= 1000) / 100); 
    millsec_hund = ((elapsed %= 100) / 10);
    millsec_thou = (elapsed %= 10);

    printf(1, "%s ran in %d.%d%d%d seconds\n", argv[1], sec, millsec_ten, millsec_hund, millsec_thou);
    exit();
}
#endif //CS333_P2
```

## user.h
- #### Line 49 - 56
```
#ifdef  CS333_P2
uint getuid(void);//UID of the current process 
uint getgid(void);//GID of the current process
uint getppid(void);//process ID of the parent process 
int setuid(uint);//set UID
int setgid(uint);//set GID
int getprocs(uint, struct uproc*);
#endif //CS333_P2
```

## usys.S
- #### Line 34 - 39
```
SYSCALL(getuid)
SYSCALL(getgid)
SYSCALL(getppid)
SYSCALL(setuid)
SYSCALL(setgid)
SYSCALL(getprocs)
```


