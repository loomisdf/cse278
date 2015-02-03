#include <stdio.h>

int year = 2020;

int calc_age(int birth_year) {
  // implement your code here
  return year - birth_year;
}

int main() {
  // implement your code here
  int birthYear;
  
  printf("Enter the year you were born: ");

  scanf("%d", &birthYear);
  int age = calc_age(birthYear);
  printf("In the year %d, you will be %d years old\n", 2020, age);

  return 0;
}
