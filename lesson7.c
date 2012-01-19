#include <stdio.h>

void say_hello()
{
printf("hello");
}

int fact(int n)
{
if (n == 1)
return 1;
else
return n * fact(n-1);
}

int main()
{
say_hello();
say_goodbye();

printf("%d", fact(4));

return 0;
}
