#include <stdio.h>
int sum(int x, int y)
{ if (x>0) return x+y;
  else return x-y;
}
int main() {
int r = sum(3, 4);
if (r>0) 
    printf("Jr = %d\n", r);
else 
    printf("Rr = %d\n", r);
return 0;
}
