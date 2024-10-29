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
;  This program serves as a manager where all the functions communicate with eachother
;
;This file:
;  File name: manager.asm
;  Language: X86-64
;  Max page width: 124 columns
;  Assemble (standard): nasm -f elf64 -l manager.lis -o manager.o manager.asm
;  Optimal print specification: Landscape, 7 points, monospace, 8½x11 paper
;  Prototype of this function: extern double managerOutputs();
; 
;
;
;
;========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**

global managerOutputs
extern input_array
extern outputArray
extern compute_mean
extern computeVariance
extern printf
array_size equ 12

section .data
    programIntro1 db "This program will manage your arrays of 64-bit floats", 10, 0
    programIntro2 db "For the array enter a sequence of 64-bit floats separated by white space.", 10, 0
    programIntro3 db "After the last input press enter followed by Control+D: ", 0
    errorOutput db "The last input was invalid and not entered into the array.", 10, 0
    programOutro1 db "These numbers were received and placed into an array", 10, 0
    meanOutput db "The mean of the numbers in the array is %lf", 10, 0
    programOutro2 db "The variance of the inputted numbers is %.7f", 10, 0
    new_line db "", 10, 0

section .bss
    align 64
    storedata resb 832
    array resq array_size

section .text
managerOutputs:
    push rbp
    mov rbp, rsp
    sub rsp, 32 ; Ensure stack alignment

    ; Print introduction messages
    mov rax, 0
    lea rdi, [programIntro1]
    call printf
    lea rdi, [programIntro2]
    call printf
    lea rdi, [programIntro3]
    call printf

    Mov rax, 0
    lea rdi, [new_line]
    call printf

    ; Saving the array into the "array"
    lea rdi, [array] ; Address of the start of the array
    mov rsi, array_size ; Size of the array
    call input_array
    mov r15, rax ; Store number of elements read into array in r15

    ; Print the array output pretext
    mov rax, 0
    lea rdi, [programOutro1]
    call printf

    ; Output the array elements
    lea rdi, [array] ; Address of the start of the array
    mov rsi, r15 ; Number of elements in the array
    call outputArray

    ; Call compute_mean to calculate the mean
    lea rdi, [array] ; Address of the start of the array
    mov rsi, r15 ; Number of elements in the array
    call compute_mean
    ; Mean calculation is done inside compute_mean

    ; Printing out the mean
    mov rdi, meanOutput  ; Format string
    mov rax, 1            ; Indicate floating point number is being passed
    call printf           ; Print mean

    ; Call computeVariance to calculate the variance
    lea rdi, [array] ; Address of the start of the array
    mov rsi, r15 ; Number of elements in the array
    call computeVariance
    ; The variance is now in XMM0, ready to be printed and returned

    ; After computing the variance and before calling printf
    movsd xmm15, xmm0  ; Store the variance temporarily in another XMM register

    ; Output the variance using printf
    mov rdi, programOutro2 ; The format string for printf
    mov rax, 1             ; FP argument count
    call printf            ; This call might alter xmm0

    ; Restore the variance into xmm0 from xmm15
    movsd xmm0, xmm15      ; Move the variance back into xmm0 for return

    ; Cleanup and return to C
    mov rsp, rbp
    pop rbp
    ret
