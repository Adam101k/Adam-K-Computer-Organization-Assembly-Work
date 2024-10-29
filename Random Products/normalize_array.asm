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
;  This program is used to normalize values contained within an array between 1 - 2
;
;This file:
;  File name: normalize_array.asm
;  Language: X86-64
;  Max page width: 124 columns
;  Assemble (standard): 
;  Assemble (debug): 
;  Optimal print specification: Landscape, 7 points, monospace, 8½x11 paper
;  Prototype of this function: extern void normalize_array();
; 
;
;
;
;========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**

global normalize_array

section .data
    ; Any constant data can be declared here

section .text

; Entry:
; rdi - number of elements in the array
; rsi - pointer to the array of double-precision floating points

normalize_array:
    push rbp
    mov rbp, rsp

    mov r14, rdi            ; r14 will be our loop counter, storing the size of the array
    mov r15, rsi            ; r15 will point to our current array position

normalize_loop:
    test r14, r14           ; Test if r14 is 0, which means we are done
    jz end_loop             ; If zero, jump to end_loop

    ; Normalize the current value pointed by r15
    ; Load the value into a register
    mov rax, [r15]

    ; Clear the exponent field and sign bit, while keeping the mantissa
    shl rax, 12             ; Shift left to drop the exponent and sign
    shr rax, 12             ; Shift right to restore the mantissa position

    ; Set the new exponent to '3FF' hex, which corresponds to an exponent of 0 (2^0 = 1.0)
    mov rbx, 0x3FF0000000000000
    or rax, rbx             ; Combine the mantissa with the new exponent

    ; Store the modified value back into the array
    mov [r15], rax

    ; Move to the next double in the array
    add r15, 8
    dec r14                ; Decrement our loop counter
    jmp normalize_loop     ; Continue the loop

end_loop:
    mov rsp, rbp
    pop rbp
    ret
