#include <stdio.h>
#include <string.h>
#include <stdlib.h>

void convert_to_octal (char input[2][33], char **output) {
  // implement your code here
  char* out = malloc(1000);

  char tmp[4];

  tmp[3] = '\0'; 

  int i;
  int j;
  int counter = 0;
  for(j = 0; j <= 1; j++) {
    for(i = 0; i < (strlen(input[j]) / 3); i++){
      
      strncpy(tmp, input[j] + (i*3), 3);
      
      if(strncmp(tmp, "000", 3) == 0) {
	out[counter] = '0';
      }
      else if(strncmp(tmp, "001", 3) == 0) {
	out[counter] = '1';
      }
      else if(strncmp(tmp, "010", 3) == 0) {
	out[counter] = '2';
      }
      else if(strncmp(tmp, "011", 3) == 0) {
	out[counter] = '3';
      }
      else if(strncmp(tmp, "100", 3) == 0) {
	out[counter] = '4';
      }
      else if(strncmp(tmp, "101", 3) == 0) {
	out[counter] = '5';
      }
      else if(strncmp(tmp, "110", 3) == 0) {
	out[counter] = '6';
      }
      else if(strncmp(tmp, "111", 3) == 0) {
	out[counter] = '7';
      }
      counter++;
    }
    out[counter] = ' ';
    counter++;
  }
  out[counter] = '\0';
  *output = out;
}

int main() {
  char input[2][33];
  char* output;
  // implement your code here
  printf("Enter two binary strings to convert: \n");
  scanf("%s %s", input[0], input[1]);

  printf("The starting memory address of the input is: %p\n", input);
  printf("The starting memory address of the output is: %p\n", output);
  
  convert_to_octal(input, &output);
  printf("The results in octal are: %s\n", output);
  return 0;
}
