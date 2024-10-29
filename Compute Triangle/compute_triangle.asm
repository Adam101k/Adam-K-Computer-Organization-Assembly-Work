;****************************************************************************************************************************
;Program name: "Compute Triangle".  This program serves to compute the missing side of a triangle based on inputs provided  *
;by the user.  Copyright (C) 2024  Adam Kaci.                                                                               *
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
;  Author email: adamkaci3@fullerton.edu
;
;Program information
;  Program name: Compute Triangle
;  Programming languages: One module in C, two in X86, and one in bash.
;  Date program began: 2024-Feb-15
;  Date of last update: 2024-Feb-21
;  Files in this program: main.c, compute_triangle.asm, isfloat.asm, r.sh. 
;  Testing: Alpha testing completed.  All functions are correct.
;  Status: Ready for release to customers
;
;Purpose
;  This program is a starting point to communicate with the "compute_triangle"
;
;This file:
;  File name: compute_triangle.asm
;  Language: X86-64
;  Max page width: 124 columns
;  Assemble (standard): 
;  Assemble (debug): 
;  Optimal print specification: Landscape, 7 points, monospace, 8½x11 paper
;  Prototype of this function: extern unsigned long gettime();
;                              extern double computetriangle();
;                              extern void haveagoodday();
; 
;
;
;
;========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**

extern printf
extern fgets
extern stdin
extern strlen
extern scanf
extern isfloat
extern atof
extern cos
extern sqrt
true equ -1
false equ 0
float_size equ 60
name_string_size equ 48
global gettime
global computetriangle
global haveagoodday


section .bss
    align 64
    backup_storage_area resb 832

    user_name resb name_string_size
    user_title resb name_string_size
    input_float resb float_size

section .data
    ; User info
    inputNameMsg db "Please enter your name: ", 0
    inputTitleMsg db "Please enter your title (Sargent, Chief, CEO, President, Teacher, etc): ", 0
    goodMorningMsg db "Good morning %s %s. We take care of all your triangles.", 10, 0

    ; Triangle info
    inputLength1 db "Please enter the length of the first side: ", 0
    inputLength2 db "Please enter the length of the second side: ", 0
    inputAngleDegree db "Please enter the size of the angle in degrees: ", 0

    ; Error output
    invalidInput db "Invalid input. Try again: ", 0

    ; Returning info
    repeatInfo db "Thank you %s. You entered %.6f %.6f and %.6f.", 10, 0
    lastsideInfo db "The length of the third side is %.6f", 10, 0
    lengthWillSend db "This length will be sent to the driver program.", 0
    goodDay db "Have a good day %s %s.", 10, 0

    ; Math values
    PI dq 3.14159265358979323846
    oneEighty dq 180.0

    ; Misc text
    new_line db "", 10, 0
    format db "%lf", 0

section .text

gettime:
    ; Back up all registers and set stack pointer to base pointer
    push rbp
    mov rbp, rsp
    push rdi
    push rsi
    push rdx
    push rcx
    push r8
    push r9
    push r10
    push r11
    push r12
    push r13
    push r14
    push r15
    push rbx
    pushf

    push qword -1                           ; Extra push to create even number of pushes

    ;----------------------------------READ CLOCK-----------------------------------------------

    mov rax, 0  
    mov rdx, 0

    cpuid                              ; Identifies the type of cpu being used on pc.
    rdtsc                              ; Counts the number of cycles/tics occured since pc reset.

    shl rdx, 32
    add rax, rdx

    ;---------------------------------END OF FILE-----------------------------------------------

    pop r8                             ; Remove extra push of -1 from stack.

    ; Restores all registers to their original state.
    popf                                                 
    pop rbx                                                     
    pop r15                                                     
    pop r14                                                      
    pop r13                                                      
    pop r12                                                      
    pop r11                                                     
    pop r10                                                     
    pop r9                                                      
    pop r8                                                      
    pop rcx                                                     
    pop rdx                                                     
    pop rsi                                                     
    pop rdi                                                     
    pop rbp

    ret

computetriangle:
    ; Back up the GPRs (General Purpose Registers)
    push rbp
    mov rbp, rsp
    push rdx
    pushf

    ; Make a blank buffer line
    mov rax, 0
    mov rdi, new_line
    call printf

    ; Output intructions to receive name
    mov rax, 0
    mov rdi, inputNameMsg
    call printf

    ; Input user name
    mov rax, 0
    mov rdi, user_name
    mov rsi, name_string_size
    mov rdx, [stdin]
    call fgets

    ; Make a blank buffer line
    mov rax, 0
    mov rdi, new_line
    call printf

    ; Output instructions to receive title
    mov rax, 0
    mov rdi, inputTitleMsg
    call printf

    ; Input user title
    mov rax, 0
    mov rdi, user_title
    mov rsi, name_string_size
    mov rdx, [stdin]
    call fgets

    ; Remove newline from user_name
    mov rax, 0
    mov rdi, user_name
    call strlen
    mov [user_name+rax-1], byte 0

    ; Remove newline from user_title
    mov rax, 0
    mov rdi, user_title
    call strlen
    mov [user_title+rax-1], byte 0

    ; Make a blank buffer line
    mov rax, 0
    mov rdi, new_line
    call printf

    ; Output "Good Morning" messasge along with user title and name
    mov rax, 0 ; Number of floating-point arguments
    mov rdi, goodMorningMsg ; First argument (format string)
    mov rsi, user_title ; Second argument (user title)
    mov rdx, user_name ; Thrid argument (user name)
    call printf

    ; Make a blank buffer line
    mov rax, 0
    mov rdi, new_line
    call printf

    ; Output instructions to receive first size
    mov rax, 0
    mov rdi, inputLength1
    call printf

    ; HERE YOU CHECK IF VALID INPUT FOR INPUT 1
    call input1loop

    ; Output instructions to receive second size
    mov rax, 0
    mov rdi, inputLength2
    call printf

    ; HERE YOU CHECK IF VALID INPUT FOR INPUT 2
    call input2loop

    ; Output instructions to receive Angle Degree
    mov rax, 0
    mov rdi, inputAngleDegree
    call printf

    ; HERE YOU CHECK IF VALID INPUT FOR INPUT 3
    call input3loop

    ; Make a blank buffer line
    mov rax, 0
    mov rdi, new_line
    call printf

    ; Repeat provided numbers back to user
    mov rax, 3              ; Indicate that there are three floating point numbers to print
    mov rdi, repeatInfo     ; The format string
    mov rsi, user_name      ; First argument (user name)
    movsd xmm0, xmm10        ; Move the first length into xmm0 for printf
    movsd xmm1, xmm11       ; Move the second length into xmm1 for printf
    movsd xmm2, xmm12       ; Move the angle into xmm2 for printf
    call printf

    ; Make a blank buffer line
    mov rax, 0
    mov rdi, new_line
    call printf

    ; Now... for the MATH!!!
    call calculatelastside

    ; Make a blank buffer line
    mov rax, 0
    mov rdi, new_line
    call printf

    ; Tell the user the 3rd length will be sent to driver
    mov rax, 0
    mov rdi, lengthWillSend
    call printf

    ; Make a blank buffer line
    mov rax, 0
    mov rdi, new_line
    call printf

    ; Move the third side value to xmm0 so it may returned to the driver
    movapd xmm0, xmm14
    

    popf
    pop rdx
    pop rbp
    ret

haveagoodday:
    push rbp
    mov rbp, rsp
    push rdx
    pushf

    ; Make a blank buffer line
    mov rax, 0
    mov rdi, new_line
    call printf

    ; Output "Good Morning" messasge along with user title and name
    mov rax, 0 ; Number of floating-point arguments
    mov rdi, goodDay ; First argument (format string)
    mov rsi, user_title ; Second argument (user title)
    mov rdx, user_name ; Thrid argument (user name)
    call printf

    ; Make a blank buffer line
    mov rax, 0
    mov rdi, new_line
    call printf

    popf
    pop rdx
    pop rbp
    ret

input1loop:
    
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

    ; Check if input is a float
    mov rax, 0
    mov rdi, input_float
    call isfloat
    cmp rax, false
    je error1

    ; Convert the input from string to float
    mov rax, 0
    mov rdi, input_float
    call atof
    movsd xmm10, xmm0 ; xmm10 contains the first length
    
    ret

error1:
    pushf
    ; Print the invalidInput
    mov rax, 0
    mov rdi, invalidInput
    mov rsi, format
    call printf

    popf

    ; Loop back to input1loop
    jmp input1loop

input2loop:

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

    ; Check if input is a float
    mov rax, 0
    mov rdi, input_float
    call isfloat
    cmp rax, false
    je error2

    ; Convert the input from string to float
    mov rax, 0
    mov rdi, input_float
    call atof
    movsd xmm11, xmm0 ; xmm10 contains the first length
    
    ret

error2:
    pushf
    ; Print the invalidInput
    mov rax, 0
    mov rdi, invalidInput
    mov rsi, format
    call printf

    popf

    ; Loop back to input1loop
    jmp input2loop

input3loop:
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

    ; Check if input is a float
    mov rax, 0
    mov rdi, input_float
    call isfloat
    cmp rax, false
    je error3

    ; Convert the input from string to float
    mov rax, 0
    mov rdi, input_float
    call atof
    movsd xmm12, xmm0 ; xmm10 contains the first length
    
    ret

error3:
    pushf
    ; Print the invalidInput
    mov rax, 0
    mov rdi, invalidInput
    mov rsi, format
    call printf

    popf

    ; Loop back to input1loop
    jmp input3loop

calculatelastside:
    push rbp
    mov rbp, rsp
    sub rsp, 16  ; Reserve stack space for floating-point calculations if needed

    ; Convert angle from degrees to radians
    ; theta_radians = theta_degrees * (PI / 180)
    movsd xmm0, [oneEighty]  ; Load 180.0
    divsd xmm12, xmm0         ; xmm12 = angle / 180
    movsd xmm0, [PI]          ; Load PI
    mulsd xmm12, xmm0         ; xmm12 = (angle / 180) * PI = angle in radians

    ; Calculate cosine of the angle
    movapd xmm0, xmm12        ; Move angle in radians to xmm0, cos expects the argument in xmm0
    call cos                  ; Call cos, result is in xmm0

    ; Calculate a^2 and b^2
    movapd xmm1, xmm10        ; Load side a into xmm1
    mulsd xmm1, xmm1          ; Calculate a^2, result is in xmm1
    movapd xmm2, xmm11        ; Load side b into xmm2
    mulsd xmm2, xmm2          ; Calculate b^2, result is in xmm2

    ; Calculate 2ab
    movapd xmm3, xmm10        ; Load side a into xmm3
    mulsd xmm3, xmm11         ; Calculate ab, result is in xmm3
    addsd xmm3, xmm3          ; Calculate 2ab, result is in xmm3

    ; Calculate 2ab*cos(theta)
    mulsd xmm3, xmm0          ; Calculate 2ab*cos(theta), result is in xmm3

    ; Calculate a^2 + b^2 - 2ab*cos(theta)
    addsd xmm1, xmm2          ; Calculate a^2 + b^2, result is in xmm1
    subsd xmm1, xmm3          ; Subtract 2ab*cos(theta), result is in xmm1

    ; Calculate sqrt(a^2 + b^2 - 2ab*cos(theta))
    movapd xmm0, xmm1         ; Move result to xmm0 for sqrt
    call sqrt                 ; Call sqrt, result is in xmm0

    ; Backing up the length of the third size to xmm14 for later usage
    movsd xmm14, xmm0

    ; xmm0 now contains the length of the third side
    ; Prepare to print the result
    mov rax, 1                ; Indicate one floating point number to print
    mov rdi, lastsideInfo     ; Message format
    call printf               ; Print the result

    add rsp, 16  ; Clean up the stack space
    pop rbp
    ret