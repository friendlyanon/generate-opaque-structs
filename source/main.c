#include <stdlib.h>

#include "lib.h"

int main(void)
{
  const struct example example = init_example();
  return peek_example(&example) ? EXIT_SUCCESS : EXIT_FAILURE;
}
