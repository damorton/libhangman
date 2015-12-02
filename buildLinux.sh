# Build script for Linux systems

gcc -c -Wall -Werror -fpic hangman.c
gcc -shared -o libs/libhangman.so hangman.o -L../libsocket/libs -lsocket
sudo cp libs/libhangman.so /usr/lib
