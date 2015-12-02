# Build script for OSX systems

gcc -dynamiclib hangman.c -L../libsocket/libs -o libs/libhangman.dylib -lsocket
sudo cp libs/libhangman.dylib /usr/lib
