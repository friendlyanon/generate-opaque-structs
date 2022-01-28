#include <macos.h>

#include <stddef.h>
#include <string.h>
#include <structs.h>

struct example init_example(void)
{
  const struct example_impl result_impl = {NULL};

  struct example result;
  memcpy(&result, &result_impl, EXAMPLE_SIZE);
  return result;
}

bool peek_example(const struct example* example)
{
  const struct example_impl* example_impl =
      (const struct example_impl*)example;
  return example_impl->string == NULL;
}
