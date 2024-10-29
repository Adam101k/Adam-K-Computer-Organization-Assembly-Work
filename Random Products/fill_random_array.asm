;****************************************************************************************************************************
;Program name: "Random Products". This program generates random values and populates an array with those values             *
;it also sorts and normalizes said values inside the array.                                                                 *
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
;  Program name: Random Products
;  Programming languages: Two modules in C, five in X86, and one in bash.
;  Date program began: 2024-April-1
;  Date of last update: 2024-April-14
;  Files in this program: executive.asm, fill_random_array.asm, isnan.asm, main.c, normalize_array.asm, r.sh, show_array.asm, sort.c
;  Testing: Alpha testing completed.  All functions are correct.
;  Status: Ready for release to customers
;
;Purpose
;  This program is used to randomly generate values to fill an array
;
;This file:
;  File name: fill_random_array.asm
;  Language: X86-64
;  Max page width: 124 columns
;  Assemble (standard): 
;  Assemble (debug): 
;  Optimal print specification: Landscape, 7 points, monospace, 8½x11 paper
;  Prototype of this function: extern void fill_random_array();
; 
;
;
;
;========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**

global fill_random_array
extern isnan
extern printf

section .data
    debug db "Debug = %d", 10, 0
    debug_hex db "0x%016lx", 10, 0
section .bss
section .text


fill_random_array:
    push rbp
    mov rbp, rsp

    mov r14, rdi        ; r14 will be our loop counter
    mov r15, rsi        ; r15 will point to the current array position
    
    ; Debug only
    ; mov rdi, debug
    ; mov rsi, r14
    ; call printf

fill_loop:
    test r14, r14
    jz fill_end         ; If the counter is zero, we are done

fill_random_number:
    rdrand rax                  ; Get a random number
    mov [r15], rax              ; Store it temporarily
    lea rdi, [r15]              ; Pass the address to isnan
    call isnan
    cmp rax, 1                  ; Check if the return value indicates NaN
    je fill_random_number       ; If NaN, generate another number

    ; Continue with valid number processing
    ; mov rax, [r15]
    ; mov rdi, debug_hex
    ; mov rsi, rax
    ; call printf                 ; Print the valid number

    add r15, 8                  ; Move pointer to the next array slot
    dec r14                     ; Decrement counter
    jmp fill_loop               ; Continue the loop


fill_end:
    pop rbp             ; Restore base pointer
    ret                 ; Return to caller


