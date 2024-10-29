#/bin/bash

#Program name "average_speed"
#Author: Adam Kaci
#This file is the script file that accompanies the "average_speed" program.
#Prepare for execution in normal mode (not gdb mode).

#Delete some un-needed files
rm *.o
rm *.out

nasm -f elf64 -l average_speed.lis -o average_speed.o average_speed.asm

gcc  -m64 -Wall -no-pie -o main.o -std=c2x -c main.c

gcc -m64 -no-pie -o learn.out average_speed.o main.o -std=c2x -Wall -z noexecstack

chmod +x learn.out
./learn.out

