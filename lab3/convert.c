#include <stdio.h>
#include <string.h>
#include <stdlib.h>

void convert_to_octal (char input[2][33], char **output) {
  // implement your code here
  printf("Performing the malloc\n");
  *output = malloc(1000);

  printf("Declaring the tmp\n");
  char tmp[4];

  printf("adding the null termination\n");
  tmp[3] = '\0'; 

  printf("Declaring i and j\n");
  int i;
  int j;
  int counter = 0;
  for(j = 0; j < 1; j++) {
    for(i = 0; i < 11; i++){
      printf("inputy%d\n",i);
      strncpy(tmp, input[j] + (i*3), 3);
      
      if(strncmp(tmp, "000", 3) == 0) {
	*output[counter] = 0;
      }
      else if(strncmp(tmp, "001", 3) == 0) {
	*output[counter] = 1;
      }
      else if(strncmp(tmp, "010", 3) == 0) {
	*output[counter] = 2;
      }
      else if(strncmp(tmp, "011", 3) == 0) {
	*output[counter] = 3;
      }
      else if(strncmp(tmp, "100", 3) == 0) {
	*output[counter] = 4;
      }
      else if(strncmp(tmp, "101", 3) == 0) {
	*output[counter] = 5;
      }
      else if(strncmp(tmp, "110", 3) == 0) {
	*output[counter] = 6;
      }
      else if(strncmp(tmp, "111", 3) == 0) {
	*output[counter] = 7;
      }
      counter++;
    }
    printf("place the space\n");
    *output[counter] = ' ';
    printf("wipe\n");
    counter++;
  }
  *output[counter+1] = '\0';
}

int main() {
  char input[2][33];
  char *output;
  // implement your code here
  printf("Enter two binary strings to convert: \n");
  scanf("%s %s", input[0], input[1]);

  printf("The starting memory address of the input is: %p\n", input);
  printf("the pre output\n");
  printf("The starting memory address of the output is: %p\n", output);
  
  printf("totalling calling the method now\n");
  convert_to_octal(input, &output);
  printf("The results in octal are: %d\n", output[0]);
  return 0;
}
