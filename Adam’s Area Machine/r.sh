#/bin/bash

#Program name "Adam’s Area Machine"
#Author: Adam Kaci
#This file is the script file that accompanies the "Adam’s Area Machine" program.
#Prepare for execution in normal mode (not gdb mode).

# Delete un-needed files
rm *.o
rm *.out

# Compiling my assembly code
nasm -f elf64 -l atof.lis -o atof.o atof.asm
nasm -f elf64 -l sin.lis -o sin.o sin.asm
nasm -f elf64 -l producer.lis -o producer.o producer.asm

g++ -c -o ftoa.o ftoa.cpp

# Compile the main c file
gcc -m64 -Wall -no-pie -o director.o -std=c2x -c director.c

# Link everything executable
g++ -m64 -no-pie -o learn.out atof.o ftoa.o sin.o producer.o director.o

chmod +x learn.out
./learn.out