//****************************************************************************************************************************
//Program name: "Compute Triangle".  This program serves to compute the missing side of a triangle based on inputs provided  *
//by the user.  Copyright (C) 2024  Adam Kaci.                                                                               *
//                                                                                                                           *
//This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License  *
//version 3 as published by the Free Software Foundation.  This program is distributed in the hope that it will be useful,   *
//but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See   *
//the GNU General Public License for more details A copy of the GNU General Public License v3 is available here:             *
//<https://www.gnu.org/licenses/>.                                                                                           *
//****************************************************************************************************************************

//Author: Adam Kaci
//Author email: adamkaci3@fullerton.edu
//Program name: Compute Triangle
//Programming languages: One module in C, two in X86, and one in bash.
//Date program began: 2024-Feb-15
//Date of last update: 2024-Feb-21
//Files in this program: main.c, compute_triangle.asm, isfloat.asm, r.sh.  
//Testing: Alpha testing completed.  All functions are correct.
//Status: Ready for release to the customers

//Purpose of this program:
//  This program is a starting point to communicate with the "compute_triangle"

//This file
//  File name: main.c
//  Language: C language, 202x standardization where x will be a decimal digit.
//  Max page width: 124 columns
//  Compile: -m64 -Wall -no-pie -o main.o -std=c2x -c main.c
//  Link: -m64 -no-pie -o learn.out isfloat.o compute_triangle.o main.o -std=c2x -Wall -z noexecstack -lm

#include <stdio.h>
#include <math.h>

extern unsigned long gettime();
extern double computetriangle();
extern void haveagoodday();

int main() {
    printf("Welcome to Amazing Triangles programmed by Adam Kaci on February 21, 2024.\n");
    unsigned long count = 0;
    count = gettime();
    printf("\nThe starting time on the system clock is %lu tics\n", count);
    
    double thirdSide = 0;
    thirdSide = computetriangle();
    count = gettime();
    printf("\nThe final time on the system clock is %lu tics\n", count);
    haveagoodday();

    printf("The driver received this number %lf and will simply keep it.\n", thirdSide);
    printf("\nAn integer zero will now be sent to the operating system. Bye\n");

    return 0;
}