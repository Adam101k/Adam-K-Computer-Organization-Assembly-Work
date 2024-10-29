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
;  This program is used to check for any nan values
;
;This file:
;  File name: isnan.asm
;  Language: X86-64
;  Max page width: 124 columns
;  Assemble (standard): 
;  Assemble (debug): 
;  Optimal print specification: Landscape, 7 points, monospace, 8½x11 paper
;  Prototype of this function: extern void isnan();
; 
;
;
;
;========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**

global isnan
section .text

isnan:
    push rbp
    mov rbp, rsp

    ; Assuming the value is already in xmm0 from earlier preparation
    ; Convert the integer from rdi to a floating point in xmm0
    movq xmm0, [rdi]            ; Load the integer as a floating point number

    ; Load the comparison value into xmm1
    mov rax, 7FEFFFFFFFFFFFFFh
    movq xmm1, rax

    ; Compare if xmm0 > xmm1 (actually checking for values that would be considered NaN or INF)
    ucomisd xmm0, xmm1
    ja .is_nan                  ; If above, it's an INF or NaN based on our misuse of the range

    mov rax, 0                  ; Return 0, indicating it's not a NaN
    jmp .exit

.is_nan:
    mov rax, 1                  ; Return 1, indicating it is a NaN (or INF)

.exit:
    mov rsp, rbp
    pop rbp
    ret
