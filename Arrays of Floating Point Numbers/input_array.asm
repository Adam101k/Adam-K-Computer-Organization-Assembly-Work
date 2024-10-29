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
;  This program is in charge of taking in the users input, validating it, than adding it to an array that is sent back to manager.asm
;
;This file:
;  File name: input_array.asm
;  Language: X86-64
;  Max page width: 124 columns
;  Assemble (standard): nasm -f elf64 -o input_array.o input_array.asm
;  Optimal print specification: Landscape, 7 points, monospace, 8½x11 paper
;  Prototype of this function: extern input_array
; 
;
;
;
;========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**

global input_array
extern scanf
extern printf
extern isfloat
extern atof

segment .data
    user_string db "%s", 0
    error_output db "The last input was invalid and not entered into the array.", 10, 0

segment .bss
    align 64
    storedata resb 832

segment .text

input_array:
    push rbp
    mov rbp, rsp
    push rbx
    push rcx
    push rdx
    push rsi
    push rdi
    push r8
    push r9
    push r10
    push r11
    push r12
    push r13
    push r14
    push r15
    pushf

    mov rax, 7
    mov rdx, 0
    xsave [storedata]

    mov r13, rdi
    mov r14, rsi
    mov r15, 0
    sub rsp, 1024

start_loop:
    
    ; Get user input
    mov rax, 0
    mov rdi, user_string
    mov rsi, rsp
    call scanf

    ; Check if the user inputted Ctrl-D
    cdqe
    cmp rax, -1
    je exit

    ; Check if the user inputted a float value
    mov rax, 0
    mov rdi, rsp
    call isfloat
    cmp rax, 0
    je reset_loop

    ; Convert the string into a float value
    mov rax, 0
    mov rdi, rsp
    call atof

    ; Put the valid info in a cell
    movsd [r13 + r15 * 8], xmm0

    ; If the array isn't full yet jump back to the start
    inc r15
    cmp r15, r14
    jl start_loop

    jmp exit

reset_loop:
    ; Ask the user to input a valid float
    mov rax, 0
    mov rdi, error_output
    call printf
    jmp start_loop

exit:

    ; Restore the xmm registers
    add rsp, 1024

    mov rax, 7
    mov rdx, 0
    xrstor [storedata]

    mov rax, r15

    popf
    pop r15
    pop r14
    pop r13
    pop r12
    pop r11
    pop r10
    pop r9
    pop r8
    pop rdi
    pop rsi
    pop rdx
    pop rcx
    pop rbx
    pop rbp

    ret
    