#/bin/bash

#Program name "Compute Triangle"
#Author: Adam Kaci
#This file is the script file that accompanies the "Compute Triangle" program.
#Prepare for execution in normal mode (not gdb mode).

#Delete some un-needed files
rm *.o
rm *.out

nasm -f elf64 -l compute_triangle.lis -o compute_triangle.o compute_triangle.asm

nasm -f elf64 -o isfloat.o isfloat.asm

gcc  -m64 -Wall -no-pie -o main.o -std=c2x -c main.c

gcc -m64 -no-pie -o learn.out isfloat.o compute_triangle.o main.o -std=c2x -Wall -z noexecstack -lm

chmod +x learn.out
./learn.out

