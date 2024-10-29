//****************************************************************************************************************************
//Program name: "Average Speed". This program serves to fulfill the requirements of assignment 1. This program computes      *
//the average speed, total speed, and total distance of a driver.  Copyright (C) 2024  Adam Kaci.                            *
//                                                                                                                           *
//This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License  *
//version 3 as published by the Free Software Foundation.  This program is distributed in the hope that it will be useful,   *
//but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See   *
//the GNU General Public License for more details A copy of the GNU General Public License v3 is available here:             *
//<https://www.gnu.org/licenses/>.                                                                                           *
//****************************************************************************************************************************

//Author: Adam Kaci
//Author email: adamkaci3@csu.fullerton.edu
//Program name: Average Speed
//Programming languages: One module in C, one in X86, and one in bash.
//Date program began: 2024-Jan-15
//Date of last update: 2024-Feb-03
//Files in this program: main.c, average_speed.asm, r.sh, and rg.sh.
//Testing: Alpha testing completed.  All functions are correct.
//Status: Ready for release to the customers

//Purpose of this program:
//  This program is a starting point for those learning to program in x86 assembly

//This file
//  File name: main.c
//  Language: C language, 202x standardization where x will be a decimal digit.
//  Max page width: 124 columns
//  Compile: gcc  -m64 -Wall -no-pie -o main.o -std=c2x -c main.c
//  Link: gcc -m64 -g -no-pie -o done.out average_speed.o main.o -std=c2x -Wall -z noexecstack

#include <stdio.h>

extern void name_title_inputs();
extern double average_speed();

int main() {
    printf("Welcome to Average Driving Time program maintained by Adam Kaci\n");
    name_title_inputs();

    double count = average_speed();
    printf("\nThe driver has received this number %1.8f and will keep it for future use.\n", count);
    printf("Have a great day.\n");
    printf("\nA zero will be sent to the operating system as a signal of a successful execution.\n");

    return 0;
}
