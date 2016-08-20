#include <stdio.h>

#define DEBUG

#ifdef DEBUG
#	define log(f,...)		({ fprintf(stderr, "%s,%s():%d: " f, __FILE__, __func__, __LINE__, ##__VA_ARGS__); })
#endif
