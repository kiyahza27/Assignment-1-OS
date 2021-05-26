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