#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <math.h>

int convert_to_int(char* input) {
  char tmp[2];
  tmp[1] = '\0';
  int decimal = 0;

  int counter = 31;
  int i;

  strncpy(tmp, input, 1);
  if(strncmp(tmp, "1",1) == 0){
    decimal  += -(pow(2, counter));
    counter--;
  } else {
    counter--;
  }

  for(i = 1; i < strlen(input); i++) {
    strncpy(tmp, input + i, 1);

    if(strncmp(tmp, "0", 1) == 0) {
      counter--;
      continue;
    }
    decimal += pow(2, counter);
    counter--;
  }
  printf("decimal = %d\n", decimal);
  return decimal;
}

float convert_to_float(char *input){
  char tmp[2];
  tmp[1] = '\0';

  //Calculate the sign bit
  float sign = 0;
  strncpy(tmp, input, 1);
  if(strncmp(tmp, "1", 1) == 0) {
    sign = -1;
  } else {
    sign = 1;
  }

  float exponent = 0;
  int power = 7;
  int i;
  for(i = 1; i < 9; i++) {
    strncpy(tmp, input + i, 1);
    if(strncmp(tmp, "0", 1) == 0) {
      power--;
      continue;
    } else {
      exponent += pow(2, power);
      power--;
    }
  }

  float fraction = 1;
  power = -1;
  for(i = 9; i < 32; i++) {
    strncpy(tmp, input + i, 1);
    if(strncmp(tmp, "0", 1) == 0) {
      power--;
      continue;
    } else {
      fraction += pow(2, power);
      power--;
    }
  }

  return sign * fraction * (pow(2, exponent - 127));
}

int performCalculation_for_int(char* calculation, int dec1, int dec2) {
  //Check for add, sub, mul, div
  int value = 0;
  if(strncmp(calculation, "add", 3) == 0) {
    value = dec1 + dec2;
  } 
  else if(strncmp(calculation, "sub", 3) == 0) {
    value = dec1 - dec2;
  }
  else if(strncmp(calculation, "mul", 3) == 0) {
    value = dec1 * dec2;
  }
  else if(strncmp(calculation, "div", 3) == 0) {
    value = dec1 / dec2;
  }
  return value;
}

float performCalculation_for_float(char* calculation, float dec1, float dec2) {
  //Check for add, sub, mul, div
  float value = 0;
  if(strncmp(calculation, "add", 3) == 0) {
    value = dec1 + dec2;
  } 
  else if(strncmp(calculation, "sub", 3) == 0) {
    value = dec1 - dec2;
  }
  else if(strncmp(calculation, "mul", 3) == 0) {
    value = dec1 * dec2;
  }
  else if(strncmp(calculation, "div", 3) == 0) {
    value = dec1 / dec2;
  }
  return value;
}

void convert_float_to_binary(char* fString, float f){
  int dec = *((int*)((char*)&f));

  int i;
  for (i = 0; i < 32; i++) { 
    int bit = (dec >> (31-i)) & 1;
    if(bit) {
      fString[i] = '1';
    } else {
      fString[i] = '0';
    }
  }
}

void convert_int_to_binary(char* iString, int dec){
  int i;
  for (i = 0; i < 32; i++) { 
    int bit = (dec >> (31-i)) & 1;
    if(bit) {
      iString[i] = '1';
    } else {
      iString[i] = '0';
    }
  }
}

void binary_to_octal(char* oct, char* bin) {
  char tmp[4];
  tmp[3] = '\0';

  char padBin[34];
  padBin[33] = '\0';
  padBin[0] = '0';
  int x;
  for(x = 0; x < 32; x++) {
    padBin[x+1] = bin[x];
  }

  int i;
  for(i = 0; i < 11; i++) {
    strncpy(tmp, padBin + (i*3), 3);
    if(strncmp(tmp, "000", 3) == 0) {
     oct[i] = '0';
    }
    else if(strncmp(tmp, "001", 3) == 0) {
     oct[i] = '1';
    }
    else if(strncmp(tmp, "010", 3) == 0) {
     oct[i] = '2';
    }
    else if(strncmp(tmp, "011", 3) == 0) {
     oct[i] = '3';
    }
    else if(strncmp(tmp, "100", 3) == 0) {
     oct[i] = '4';
    }
    else if(strncmp(tmp, "101", 3) == 0) {
     oct[i] = '5';
    }
    else if(strncmp(tmp, "110", 3) == 0) {
     oct[i] = '6';
    }
    else if(strncmp(tmp, "111", 3) == 0) {
     oct[i] = '7';
    }
  }
}

int binary_to_decimal(char* bin) {
  int sum = 0;
  int i;
  int power = 31;
  int bit = 0;
  for(i = 0; i < strlen(bin); i++) {
    if(bin[i] == '0'){
      bit = 0;
    } else {
      bit = 1;
    }
    sum += bit * pow(2, power);
    power--;
  }
  return sum;
}

void binary_to_hex(char* hex, char* bin) {
  char tmp[5];
  tmp[4] = '\0';

  int i;
  for(i = 0; i < 11; i++) {
    strncpy(tmp, bin + (i*4), 4);
    if(strncmp(tmp, "0000", 4) == 0) {
      hex[i] = '0';
    }
    else if(strncmp(tmp, "0001", 4) == 0) {
      hex[i] = '1';
    }
    else if(strncmp(tmp, "0010", 4) == 0) {
      hex[i] = '2';
    }
    else if(strncmp(tmp, "0011", 4) == 0) {
      hex[i] = '3';
    }
    else if(strncmp(tmp, "0100", 4) == 0) {
      hex[i] = '4';
    }
    else if(strncmp(tmp, "0101", 4) == 0) {
      hex[i] = '5';
    }
    else if(strncmp(tmp, "0110", 4) == 0) {
      hex[i] = '6';
    }
    else if(strncmp(tmp, "0111", 4) == 0) {
      hex[i] = '7';
    }
    else if(strncmp(tmp, "1000", 4) == 0) {
      hex[i] = '8';
    }
    else if(strncmp(tmp, "1001", 4) == 0) {
      hex[i] = '9';
    }
    else if(strncmp(tmp, "1010", 4) == 0) {
      hex[i] = 'A';
    }
    else if(strncmp(tmp, "1011", 4) == 0) {
      hex[i] = 'B';
    }
    else if(strncmp(tmp, "1100", 4) == 0) {
      hex[i] = 'C';
    }
    else if(strncmp(tmp, "1101", 4) == 0) {
      hex[i] = 'D';
    }
    else if(strncmp(tmp, "1110", 4) == 0) {
      hex[i] = 'E';
    }
    else if(strncmp(tmp, "1111", 4) == 0) {
      hex[i] = 'F';
    }
  }
}

int main() {
  char input[2][33];
  char* output;
  // implement your code here
  printf("Enter the first number in binary format:\n");
  scanf("%s", input[0]);
  printf("Enter the second number in binary format:\n");
  scanf("%s", input[1]);

  char* numFormat;
  printf("Enter the binary numeric format(int or float):\n");
  scanf("%s", numFormat);

  char tmp[2];
  tmp[1] = '\0';
  strncpy(tmp, numFormat, 1);

  char calculation[4];
  printf("Enter the calculation to perform(add, sub, mul, div):\n");
  scanf("%s", calculation);
  char calcSymbol[2];
  calcSymbol[1] = '\0';
  if (calculation[0] == 'a')
  {
    calcSymbol[0] = '+';
  } else if(calculation[0] == 's') {
    calcSymbol[0] = '-';
  } else if(calculation[0] == 'm') {
    calcSymbol[0] = '*';
  } else if(calculation[0] == 'd') {
    calcSymbol[0] = '/';
  }

  int i1;
  int i2;
  float f1;
  float f2;

  int v1;
  float v2;

  //If i, then convert to int, else convert to float
  if(strncmp(tmp, "i", 1) == 0) {
    i1 = convert_to_int(input[0]);
    i2 = convert_to_int(input[1]);

    v1 = performCalculation_for_int(calculation, i1, i2);

    char iBin[33];
    iBin[32] ='\0';
    convert_int_to_binary(iBin, v1);

    char iOct[12];
    iOct[11] = '\0';
    binary_to_octal(iOct, iBin);

    int iDec = binary_to_decimal(iBin);

    char iHex[9];
    iHex[8] = '\0';
    binary_to_hex(iHex, iBin);

    printf("The result for %d %s %d is: \n", i1, calcSymbol, i2);
    printf("binary = %s\n", iBin);
    printf("octal = %s\n", iOct);
    printf("decimal = %d\n", iDec);
    printf("hex = %s\n", iHex);
  } 
  else {
    f1 = convert_to_float(input[0]);
    f2 = convert_to_float(input[1]);

    printf("f1 = %f\n", f1);
    printf("f2 = %f\n", f2);

    v2 = performCalculation_for_float(calculation, f1, f2);

    char fBin[33];
    fBin[32] = '\0';
    convert_float_to_binary(fBin,v2);

    char fOct[12];
    fOct[11] = '\0';
    binary_to_octal(fOct, fBin);

    char fDec = binary_to_decimal(fBin);

    char fHex[9];
    fHex[8] = '\0';
    binary_to_hex(fHex, fBin);
    
    printf("The result for %f %s %f is: \n", f1, calcSymbol, f2);
    printf("binary = %s\n", fBin);
    printf("octal = %s\n", fOct);
    printf("decimal = %+f\n", f1 / f2);
    printf("hex = %s\n", fHex);
  }
  printf("Goodbye");
  return 0;
}
