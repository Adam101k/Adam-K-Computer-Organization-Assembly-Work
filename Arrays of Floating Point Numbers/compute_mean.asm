;****************************************************************************************************************************
;Program name: "Arrays of floating point numbers". This program takes in values from the user and stores it in an array.    *
;The program than takes those array values and computes the variance, returning the variance value to the user.             *                                                          *
;                                                                                                                           *
;This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License  *
;version 3 as published by the Free Software Foundation.  This program is distributed in the hope that it will be useful,   *
;but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See   *
;the GNU General Public License for more details A copy of the GNU General Public License v3 is available here:             *
;<https://www.gnu.org/licenses/>.                                                                                           *
;****************************************************************************************************************************

;========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**
;Author information
;  Author name: Adam Kaci
;  Author email: adamkaci3@csu.fullerton.edu
;
;Program information
;  Program name: Arrays of floating point numbers
;  Programming languages: Two modules in C, two in X86, one in C++, and one in bash.
;  Date program began: 2024-March-1
;  Date of last update: 2024-March-17
;  Files in this program: input_array.asm, main.c, manager.asm, output_array.c, compute_variance.cpp
;  Testing: Alpha testing completed.  All functions are correct.
;  Status: Ready for release to customers
;
;Purpose
;  This program serves as the mean calculator, once calculated, the mean is sent to manager for printing
;
;This file:
;  File name: compute_mean.asm
;  Language: X86-64
;  Max page width: 124 columns
;  Assemble (standard): nasm -f elf64 -o compute_mean.o compute_mean.asm
;  Optimal print specification: Landscape, 7 points, monospace, 8½x11 paper
;  Prototype of this function: extern compute_mean
; 
;
;
;
;========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**

global compute_mean
extern printf

section .data
    meanOutput db "The mean of the numbers in the array is %lf", 10, 0

section .text
compute_mean:
    push rbp
    mov rbp, rsp
    sub rsp, 16   ; Ensure stack alignment, reserve space if needed

    ; rdi = address of the array
    ; rsi = size of the array

    xorpd xmm0, xmm0 ; Clear xmm0 for sum accumulation
    xor rax, rax     ; Clear rax, index for loop

    ; Check if the array is empty
    test rsi, rsi
    jz .emptyArray

.loop:
    cmp rax, rsi    ; Compare counter with size
    jge .endLoop    ; If counter >= size, end loop

    movsd xmm1, [rdi + rax*8] ; Load next array element
    addsd xmm0, xmm1 ; Add element to sum
    inc rax         ; Increment counter
    jmp .loop

.endLoop:
    ; Calculate mean
    cvtsi2sd xmm1, rsi ; Convert size to double
    divsd xmm0, xmm1   ; Divide sum by size to get mean

.emptyArray:
    ; Clean up and return
    mov rsp, rbp
    pop rbp
    ret
