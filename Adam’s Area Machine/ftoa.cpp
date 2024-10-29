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
//  This program converts float values into strings

//This file
//  File name: ftoa.cpp
//  Language: C++ language.
//  Max page width: 124 columns
//  Compile: g++ -m64 -no-pie -o learn.out atof.o ftoa.o sin.o producer.o director.o
//  Link: g++ -m64 -no-pie -o learn.out atof.o ftoa.o sin.o producer.o director.o

#include <iostream>
#include <string>

void floatToString(double num, char *arr, int size) {
  // Convert the float to a string
  std::string str = std::to_string(num);

  // Copy the string into the provided array
  // Ensure the string does not exceed the array size
  int copySize = std::min(static_cast<std::string::size_type>(str.size()),
                          static_cast<std::string::size_type>(size - 1));
  std::copy(str.begin(), str.begin() + copySize, arr);

  // Null-terminate the array
  arr[copySize] = '\0';
}