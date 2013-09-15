#include <stdio.h>
#include <stdlib.h>
#include <fcntl.h>
#include "kgpio.h"

#define WHITE_PORT 17
#define RED_PORT   18

int main (int argc, char **argv) {
	if (argc != 2) {
		fprintf(stderr, "Usage: %s white|red|off\n", argv[0]);
		exit(EXIT_FAILURE);
	}

	unsigned int red, white;
	if (strcasecmp(argv[1], "red") == 0) {
		red = 1;
		white = 0;
	} else if (strcasecmp(argv[1], "white") == 0) {
		red = 0;
		white = 1;
	} else if (strcasecmp(argv[1], "off") == 0) {
		red = 0;
		white = 0;
	} else {
		fprintf(stderr, "Unknown option \"%s\"\n", argv[1]);
		exit(EXIT_FAILURE);
	}

	int gpio_dev;
	if ((gpio_dev = open("/dev/gpio", O_RDONLY)) == -1) {
		perror("Failed to open /dev/gpio");
		exit(EXIT_FAILURE);
	}

	galois_gpio_data_t port_state;
	port_state.mode = GPIO_MODE_DATA_OUT;

	port_state.port = WHITE_PORT;
	port_state.data = white;
	if (ioctl(gpio_dev, GPIO_IOCTL_SET, &port_state) == -1)
		perror("Failed to set white LED direction");
	if (ioctl(gpio_dev, GPIO_IOCTL_WRITE, &port_state) == -1)
		perror("Failed to set white LED state");

	port_state.port = RED_PORT;
	port_state.data = red;
	if (ioctl(gpio_dev, GPIO_IOCTL_SET, &port_state) == -1)
		perror("Failed to set red LED direction");
	if (ioctl(gpio_dev, GPIO_IOCTL_WRITE, &port_state) == -1)
		perror("Failed to set red LED state");

	return EXIT_SUCCESS;
}

