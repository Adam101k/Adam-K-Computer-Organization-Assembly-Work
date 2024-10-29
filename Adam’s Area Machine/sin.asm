;****************************************************************************************************************************
;Program name: "Adam’s Area Machine". This program takes in two sides of a triangle and an angle, then calculates           *
;the area of the triangle                                                                                                   *                                                     *
;This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License  *
;version 3 as published by the Free Software Foundation.  This program is distributed in the hope that it will be useful,   *
;but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See   *
;the GNU General Public License for more details A copy of the GNU General Public License v3 is available here:             *
;<https://www.gnu.org/licenses/>.                                                                                           *
;****************************************************************************************************************************

;========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**
;Author information
;  Author name: Adam Kaci
;  Author email: adamkaci3@fullerton.edu
;
;Program information
;  Program name: Adam's Area Machine
;  Programming languages: One module in C, one in C++, three in X86, and one in bash.
;  Date program began: 2024-April-28
;  Date of last update: 2024-May-12
;  Files in this program: atof.asm, producer.asm, sin.asm, director.c, r.sh, ftoa.cpp
;  Testing: Alpha testing completed.  All functions are correct.
;  Status: Ready for release to customers
;
;Purpose
;  This program is a custom implementation of a Sin call that calculates using the Taylor series
;
;This file:
;  File name: sin.asm
;  Language: X86-64
;  Max page width: 124 columns
;  Assemble (standard): 
;  Assemble (debug): 
;  Optimal print specification: Landscape, 7 points, monospace, 8½x11 paper
;  Prototype of this function: extern double sin(double num);
; 
;
;
;
;========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**

section .data
; Constants for the Taylor series terms
factorial3 dq 6.0      ; 3!
factorial5 dq 120.0    ; 5!

section .text
global sin
sin:
    ; xmm0 = x
    ; xmm1 = x^2
    ; xmm2 = x^3
    ; xmm3 = x^5
    ; xmm4, xmm5 - temporary registers

    ; Compute x^2
    movq xmm1, xmm0
    mulsd xmm1, xmm0

    ; Compute x^3
    movq xmm2, xmm1
    mulsd xmm2, xmm0

    ; Compute x^5
    movq xmm3, xmm2
    mulsd xmm3, xmm1

    ; Divide x^3 by 6
    movq xmm4, qword [factorial3]
    divsd xmm2, xmm4

    ; Divide x^5 by 120
    movq xmm5, qword [factorial5]
    divsd xmm3, xmm5

    ; Subtract x^3/6 from x
    subsd xmm0, xmm2

    ; Add x^5/120 to the result
    addsd xmm0, xmm3

    ; Return result in xmm0
    ret
