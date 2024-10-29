#/bin/bash

#Program name "Random Products"
#Author: Adam Kaci
#This file is the script file that accompanies the "Random Products" program.
#Prepare for execution in normal mode (not gdb mode).

#Delete some un-needed files
rm *.o
rm *.out

# Compiling my assembly code
nasm -f elf64 -l executive.lis -o executive.o executive.asm
nasm -f elf64 -o fill_random_array.o fill_random_array.asm
nasm -f elf64 -o isnan.o isnan.asm
nasm -f elf64 -o normalize_array.o normalize_array.asm
nasm -f elf64 -o show_array.o show_array.asm

# Compile the main C file
gcc  -m64 -Wall -no-pie -o main.o -std=c2x -c main.c

# Compile the sorter
gcc  -m64 -Wall -no-pie -o sort.o -std=c2x -c sort.c

# Link everything to executable
gcc -m64 -no-pie -o learn.out executive.o fill_random_array.o isnan.o normalize_array.o show_array.o main.o sort.o

chmod +x learn.out
./learn.out