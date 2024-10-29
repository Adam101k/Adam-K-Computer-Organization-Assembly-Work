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
;  This program is a custom implemtation of the traditional atof function
;
;This file:
;  File name: atof.asm
;  Language: X86-64
;  Max page width: 124 columns
;  Assemble (standard): 
;  Assemble (debug): 
;  Optimal print specification: Landscape, 7 points, monospace, 8½x11 paper
;  Prototype of this function: extern void atof();
; 
;
;
;
;========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**

;Assembler directives
global atof
extern printf
extern scanf

section .data
    ten dq 10.0                       ; Constant for base 10 multiplication
    one_tenth dq 0.1                  ; Constant for decimal handling

section .bss
    ; No uninitialized data declared

section .text
atof:
    push rbp
    mov rbp, rsp

    ; Backup registers
    push rbx
    push rcx
    push rdx
    push rdi
    push rsi

    mov rdi, rdi                       ; rdi contains pointer to the input string
    xor rax, rax                       ; Clear rax
    xor rbx, rbx                       ; rbx will hold the integer part
    xor rdx, rdx                       ; rdx will temporarily hold character values

    ; Check for negative numbers
    mov cl, byte [rdi]
    cmp cl, '-'
    jne check_positive
    inc rdi                            ; Skip '-' character
    mov rsi, 1                         ; Sign flag for negative

check_positive:
    xor rsi, rsi                       ; Sign flag for positive

; Parse integer part
parse_integer:
    mov cl, byte [rdi]
    cmp cl, '0'
    jb check_decimal
    cmp cl, '9'
    ja check_decimal

    sub cl, '0'                        ; Convert character to integer
    movzx rcx, cl                      ; Move the converted integer into rcx properly
    imul rbx, rbx, 10                  ; Multiply current result by 10
    add rbx, rcx                       ; Add new digit
    inc rdi                            ; Move to next character
    jmp parse_integer

check_decimal:
    cmp cl, '.'
    jne convert_to_float
    inc rdi                            ; Skip '.' character

    ; Parse fractional part
    mov rax, 1                         ; Denominator for fractional calculation
parse_fraction:
    mov cl, byte [rdi]
    cmp cl, '0'
    jb convert_to_float
    cmp cl, '9'
    ja convert_to_float

    sub cl, '0'                        ; Convert character to integer
    movzx rcx, cl                      ; Move the converted integer into rcx properly
    imul rbx, rbx, 10                  ; Shift previous digits
    add rbx, rcx                       ; Add new digit
    imul rax, rax, 10                  ; Adjust the denominator

    inc rdi                            ; Move to next character
    jmp parse_fraction


convert_to_float:
    ; Convert integers to float
    cvtsi2sd xmm0, rbx                 ; Convert rbx to double in xmm0
    cvtsi2sd xmm1, rax                 ; Convert denominator to double in xmm1
    divsd xmm0, xmm1                   ; Divide to get the actual floating-point value

    ; Apply the negative sign if necessary
    test rsi, rsi
    jz done
    movsd xmm1, [rel neg_one]
    mulsd xmm0, xmm1                   ; Apply negative sign

done:
    ; Restore registers and return
    pop rsi
    pop rdi
    pop rdx
    pop rcx
    pop rbx
    pop rbp
    ret

section .data
    neg_one dq -1.0                    ; Constant for negative sign
