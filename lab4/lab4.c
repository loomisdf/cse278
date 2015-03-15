#include <stdio.h>
int array[10];
int main() {
    int sum = 0;
    // write a for loop to fill the array starting at 5 and incrementing each element by 5
    // so array[0] = 5, array[1] = 10, and so on
    // write a second for loop that takes calculates the sum of the array
    int i;
    for(i = 1; i < 11; i++) {
    	array[i-1] = i*5;	
    }
    for(i = 0; i < 10; i++) {
	sum += array[i];
    }
    printf("The sum is %d\n", sum);
    return 0;
}
