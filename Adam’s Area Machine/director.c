//****************************************************************************************************************************
//Program name: "Adam’s Area Machine". This program takes in two sides of a triangle and an angle, then calculates           *
// the area of the triangle                                                                                                  *
//This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License  *
//version 3 as published by the Free Software Foundation.  This program is distributed in the hope that it will be useful,   *
//but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See   *
//the GNU General Public License for more details A copy of the GNU General Public License v3 is available here:             *
//<https://www.gnu.org/licenses/>.                                                                                           *
//****************************************************************************************************************************

//Author: Adam Kaci
//Author email: adamkaci3@csu.fullerton.edu
//Program name: Adam's Area Machine
//Programming languages: One module in C, one in C++, three in X86, and one in bash.
//Date program began: 2024-April-28
//Date of last update: 2024-May-12
//Files in this program: atof.asm, producer.asm, sin.asm, director.c, r.sh, ftoa.cpp
//Testing: Alpha testing completed.  All functions are correct.
//Status: Ready for release to the customers

//Purpose of this program:
//  This program is the main frontend that communicates with all of the backend functions

//This file
//  File name: director.c
//  Language: C language.
//  Max page width: 124 columns
//  Compile: gcc -m64 -Wall -no-pie -o director.o -std=c2x -c director.c
//  Link: gcc -m64 -Wall -no-pie -o director.o -std=c2x -c director.c

#include <stdio.h>
#include <string.h>

extern double producer();

int main() {
    printf("Welcome to Marvelous Adam’s Area Machine.\n");
    printf("We compute all your areas.\n");
    printf("\n");

    double area = producer();

    printf("\n\nThe drive received this number %lf and will keep it.\n", area);
    printf("A zero will be sent to the OS as a sign of a successful conclusion.\n");
    printf("Bye\n");
    printf(" ");

    return 0;
}