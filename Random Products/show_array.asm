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
;  This program is used to show values contained within an array
;
;This file:
;  File name: show_array.asm
;  Language: X86-64
;  Max page width: 124 columns
;  Assemble (standard): 
;  Assemble (debug): 
;  Optimal print specification: Landscape, 7 points, monospace, 8½x11 paper
;  Prototype of this function: extern void show_array();
; 
;
;
;
;========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**

global show_array
extern printf

section .data
    bothOutputs db "0x%016lx   %-18.13g", 0

    ; New Line buffer
    newLine db "", 10, 0
section .text

; rdi contains size of array
; rsi contains array address

show_array:
    push rbp
    mov rbp, rsp

    mov r14, rdi ; r14 will be our loop counter
    mov r15, rsi ; r15 will point to our current array position

show_loop:
    test r14, r14
    jz end_array ; If the counter is zero, we are done

    ; Show each value in both hex and scientific formats on the same line
    mov rax, [r15]          ; Load the double value from the array into rax
    movq xmm1, rax          ; Also load the value into xmm1 for floating point printing
    mov rdi, bothOutputs    ; Load the combined format string address
    mov rsi, rax            ; First argument for printf (hexadecimal)
    movq xmm0, xmm1         ; Second argument for printf (scientific), must be in xmm0
    call printf             ; Print both the hex and scientific representations

    ; Make a blank buffer line
    mov rax, 0
    mov rdi, newLine
    call printf

    add r15, 8              ; Move to the next double in the array
    dec r14                 ; Decrement our loop counter
    jmp show_loop           ; Continue the loop

end_array:
    pop rbp
    ret
