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
;  This program is the main backend component that takes in the triangle values and outputs the area
;
;This file:
;  File name: producer.asm
;  Language: X86-64
;  Max page width: 124 columns
;  Assemble (standard): 
;  Assemble (debug): 
;  Optimal print specification: Landscape, 7 points, monospace, 8½x11 paper
;  Prototype of this function: extern double producer();
; 
;
;
;
;========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**

global producer

extern atof
extern ftoa
extern sin
extern printf
extern stdin
extern fgets
extern strlen
float_size equ 60

section .bss
    input_float resb float_size

section .data
    ; User input prints
    inputLength1 db "Please enter the length of side 1: ", 0
    inputLength2 db "Please enter the length of side 2: ", 0
    inputDegree db "Please enter the degrees of the angle between: ", 0

    ; Final outputs
    triangleArea db "The area of this triangle is %.6f square feet.", 10, 0
    goodbye db "Thank you for using a Adam product.", 0, 10

    ; Misc text
    new_line db "", 10, 0
    format db "%lf", 0

    ; Math values
    PI dq 3.14159265358979323846
    oneEighty dq 180.0
    half dq 0.5

    ; Debug
    debug_format db "Debug Value: %lf", 10, 0

section .text

producer:
    ; Back up GPRs
    push rbp
    mov rbp, rsp
    push rdx
    pushf

    ; Output instructions to receive first side
    mov rax, 0
    mov rdi, inputLength1
    call printf

    ; get the user input
    mov rax, 0
    mov rdi, input_float
    mov rsi, float_size
    mov rdx, [stdin]
    call fgets

    ; Remove the newline character
    mov rax, 0
    mov rdi, input_float
    call strlen
    mov [input_float + rax - 1], byte 0

    ; Convert the input from string to float
    mov rax, 0
    mov rdi, input_float
    call atof
    movsd xmm10, xmm0 ; xmm10 contains the first length

    ; Output instructions to receive second side
    mov rax, 0
    mov rdi, inputLength2
    call printf

    ; get the user input
    mov rax, 0
    mov rdi, input_float
    mov rsi, float_size
    mov rdx, [stdin]
    call fgets

    ; Remove the newline character
    mov rax, 0
    mov rdi, input_float
    call strlen
    mov [input_float + rax - 1], byte 0

    ; Convert the input from string to float
    mov rax, 0
    mov rdi, input_float
    call atof
    movsd xmm11, xmm0 ; xmm11 contains the second length

    ; Output instructions to receive Angle Degree
    mov rax, 0
    mov rdi, inputDegree
    call printf

    ; get the user input
    mov rax, 0
    mov rdi, input_float
    mov rsi, float_size
    mov rdx, [stdin]
    call fgets

    ; Remove the newline character
    mov rax, 0
    mov rdi, input_float
    call strlen
    mov [input_float + rax - 1], byte 0

    ; Convert the input from string to float
    mov rax, 0
    mov rdi, input_float
    call atof
    movsd xmm12, xmm0 ; xmm12 contains the Angle Degree

    ; Now... to calculate the area!!!
    call calculateArea
    ; The area value should be contained in xmm14 currently

    ; Make a blank buffer line
    mov rax, 0
    mov rdi, new_line
    call printf

    ; Tell the user the area of the triangle
    mov rax, 1
    mov rdi, triangleArea
    movsd xmm0, xmm14 ; Prepare the area to be outputted
    call printf

    ; Say goodbye and return to director
    mov rax, 0
    mov rdi, goodbye
    call printf

    ; Move the area of the triangle back to xmm0 to return to director
    movapd xmm0, xmm14

    popf
    pop rdx
    pop rbp
    ret

; Function to calculate the area of a triangle using the formula:
; Area = (s1 * s2 * sin(angle))/2
; Parameters:
; xmm10 = side1 (double)
; xmm11 = side2 (double)
; xmm12 = angle in degrees (double)
; Output:
; xmm14 = area (double)
calculateArea:
    push rbp
    mov rbp, rsp
    sub rsp, 16               ; Allocate stack space for local storage

    ; Convert angle from degrees to radians
    movsd xmm0, xmm12        ; Load angle in degrees
    movsd xmm1, [rel oneEighty]
    divsd xmm0, xmm1         ; xmm0 = degrees / 180

    movsd xmm1, [rel PI]
    mulsd xmm0, xmm1         ; Multiply by PI

    ; Calculate sin of angle
    call sin                 ; xmm0 = sin(angle)

    ; Calculate area
    movsd xmm1, xmm10        ; Load side1
    movsd xmm2, xmm11        ; Load side2
    mulsd xmm1, xmm2         ; xmm1 = side1 * side2
    mulsd xmm0, xmm1         ; xmm0 = side1 * side2 * sin(angle)
    movsd xmm1, [rel half]
    mulsd xmm0, xmm1         ; xmm0 = 0.5 * side1 * side2 * sin(angle)

    ; Store the result in xmm14
    movsd xmm14, xmm0

    ; Cleanup
    mov rsp, rbp
    pop rbp
    ret
