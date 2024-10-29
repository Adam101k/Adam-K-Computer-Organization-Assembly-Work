#/bin/bash

#Program name "Array System"
#Author: Adam Kaci
#This file is the script file that accompanies the "Array System" program.
#Prepare for execution in normal mode (not gdb mode).

#Delete some un-needed files
rm *.o
rm *.out

nasm -f elf64 -l manager.lis -o manager.o manager.asm

nasm -f elf64 -o isfloat.o isfloat.asm

nasm -f elf64 -o input_array.o input_array.asm

nasm -f elf64 -o compute_mean.o compute_mean.asm

gcc  -m64 -Wall -no-pie -o main.o -std=c2x -c main.c
gcc -m64 -Wall -no-pie -o output_array.o -std=c2x -c output_array.c
g++ -c -o compute_variance.o compute_variance.cpp

g++ -m64 -no-pie -o learn.out isfloat.o manager.o input_array.o main.o output_array.o compute_variance.o compute_mean.o -std=c++2a -Wall -z noexecstack -lm

chmod +x learn.out
./learn.out