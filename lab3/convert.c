#include <stdio.h>
#include <string.h>
#include <stdlib.h>

void convert_to_octal (char input[2][33], char **output) {
  // implement your code here
  *output = malloc(100);
  
}

int main() {
  char input[2][33];
  char *output;
  // implement your code here
  printf("Enter two binary strings to convert: \n");
  scanf("%s %s", input[0], input[1]);

  printf("thing: %s\n", input[0]);

  printf("The starting memory address of the input is: %p\n", &input);
  printf("The starting memory address of the output is: %p\n",&output);
  //  printf("The results in octal are: __\n", output);
  return 0;
}
