//****************************************************************************************************************************
//Program name: "Arrays of floating point numbers". This program takes in values from the user and stores it in an array.    *
//The program than takes those array values and computes the variance, returning the variance value to the user.             *                                                          *
//                                                                                                                           *
//This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License  *
//version 3 as published by the Free Software Foundation.  This program is distributed in the hope that it will be useful,   *
//but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See   *
//the GNU General Public License for more details A copy of the GNU General Public License v3 is available here:             *
//<https://www.gnu.org/licenses/>.                                                                                           *
//****************************************************************************************************************************

//Author: Adam Kaci
//Author email: adamkaci3@csu.fullerton.edu
//Program name: Arrays of floating point numbers
//Programming languages: Two modules in C, two in X86, one in C++, and one in bash.
//Date program began: 2024-March-1
//Date of last update: 2024-March-17
//Files in this program: input_array.asm, main.c, manager.asm, output_array.c, compute_variance.cpp
//Testing: Alpha testing completed.  All functions are correct.
//Status: Ready for release to the customers

//Purpose of this program:
//  This program calculates the variance value of a provided array

//This file
//  File name: compute_variance.cpp
//  Language: C++ language.
//  Max page width: 124 columns
//  Compile: g++ -c -o compute_variance.o compute_variance.cpp
//  Link: g++ -m64 -no-pie -o learn.out isfloat.o manager.o input_array.o main.o output_array.o compute_variance.o -std=c++2a -Wall -z noexecstack -lm

#include <iostream>
#include <iomanip> // For setprecision

extern "C" double computeVariance(double* array, int size) {
    if (size <= 1) return 0.0; // Can't compute variance with 0 or 1 element.

    // Calculate mean
    double sum = 0.0;
    for (int i = 0; i < size; ++i) {
        sum += array[i];
    }
    double mean = sum / size;

    // Calculate variance for a sample population
    double variance = 0.0;
    for (int i = 0; i < size; ++i) {
        variance += (array[i] - mean) * (array[i] - mean);
    }
    variance /= (size - 1); // Note the use of (size - 1) for sample variance

    return variance;
}
