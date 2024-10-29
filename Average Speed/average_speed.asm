;****************************************************************************************************************************
;Program name: "Average Speed". This program serves to fulfill the requirements of assignment 1. This program computes      *
;the average speed, total speed, and total distance of a driver.  Copyright (C) 2024  Adam Kaci.                            *
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
;  Program name: Average Speed
;  Programming languages: One module in C, one in X86, and one in bash.
;  Date program began: 2024-Jan-15
;  Date of last update: 2024-Feb-03
;  Files in this program: main.c, average_speed.asm, r.sh, and rg.sh.
;  Testing: Alpha testing completed.  All functions are correct.
;  Status: Ready for release to customers
;
;Purpose
;  This program calculates average speed, total time, and total distance. 
;
;This file:
;  File name: average_speed.asm
;  Language: X86-64
;  Max page width: 124 columns
;  Assemble (standard): nasm -f elf64 -l average_speed.lis -o average_speed.o average_speed.asm
;  Assemble (debug): nasm -f elf64 -gdwarf -l average_speed.lis -o average_speed.o average_speed.asm
;  Optimal print specification: Landscape, 7 points, monospace, 8½x11 paper
;  Prototype of this function: extern void name_title_inputs(); & extern double average_speed();
;
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



global calculate_average_speed
global calculate_total_distance
global calculate_total_time
global name_title_inputs
global average_speed

name_string_size equ 48

segment .bss
    align 64
    backup_storage_area resb 832

    user_name resb name_string_size
    user_title resb name_string_size
    user_mile resb name_string_size

segment .data
    inputNameMsg db "Please enter your first and last names: ", 0
    inputTitleMsg db "Please enter your title such as Lieutenant, Chief, Mr, Ms, Influencer, Chairman, Freshman, Foreman, Project Leader, etc: ", 0
    thankYouMsg db "Thank you %s %s", 10, 0
    mileTravelMsgFS db "Enter the number of miles traveled from Fullerton to Santa Ana: ", 0
    milesTravelMsgSL db "Enter the number of miles traveled from Santa Ana to Long Beach: ", 0
    milesTravelMsgLF db "Enter the number of miles traveled from Long Beach to Fullerton: ", 0
    avgSpeedMsg db "Enter your average speed during that leg of the trip: ", 0
    processDataMsg db "The inputted data are being processed", 10, 10, 0
    totalDistanceMsg db "The total distance traveled is %.1f miles.", 10, 0
    totalTimeMsg db "The time of the trip is %.9f hours", 10, 0
    avgSpeedTripMsg db "The average speed during this trip is %.8f mph.", 10, 0
    driverNumberMsg db "The driver has received this number ", 0
    haveGreatDayMsg db "Have a great day.", 10, 0
    new_line db "", 10, 0

    format db "%lf", 0

segment .text


name_title_inputs:
    ; Back up the GPRs (General Purpose Registers)
    push rbp
    mov rbp, rsp
    push rdx
    pushf
    

    ; Output instructions to receive first and last name
    mov rax, 0
    mov rdi, inputNameMsg
    call printf

    ; Input user names
    mov rax, 0
    mov rdi, user_name
    mov rsi, name_string_size
    mov rdx, [stdin]
    call fgets

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
    
    
    ; Output "Thank you" message along with user title and name
    mov rax, 0  ; Number of floating-point arguments
    mov rdi, thankYouMsg  ; First argument (format string)
    mov rsi, user_title  ; Second argument (user title)
    mov rdx, user_name  ; Third argument (user name)
    call printf


    ; Clean up
    popf
    pop rdx
    pop rbp
    ret



average_speed:
    ; Back up the GPRs (General Purpose Registers)
    push rbp
    mov rbp, rsp
    push rdx
    pushf



    ; Make a blank buffer line
    mov rax, 0
    mov rdi, new_line
    call printf

    ; Output instructions to receive distance1
    mov rax, 0
    mov rdi, mileTravelMsgFS
    call printf

    ; Recieve distance1 input and copy that to xmm8
    mov rdi, format
    push qword -9 ;rsp points to -9
    push qword -9
    mov rsi, rsp
    call scanf
    movsd xmm15, [rsp]
    pop r9
    pop r8
    


    ; Output instructions to recieve speed1
    mov rax, 0
    mov rdi, avgSpeedMsg
    call printf

    ; Recieve speed1 and copy that to xmm14
    mov rdi, format
    push qword -9 
    push qword -9
    mov rsi, rsp
    call scanf
    movsd xmm14, [rsp]
    pop r9
    pop r8

    ; Make a blank buffer line
    mov rax, 0
    mov rdi, new_line
    call printf

    ; Output instructions to receive distance2
    mov rax, 0
    mov rdi, milesTravelMsgSL
    call printf
    
    ; Recieve distance2 and copy that to xmm10
    mov rdi, format
    push qword -9 ;rsp points to -9
    push qword -9
    mov rsi, rsp
    call scanf
    movsd xmm10, [rsp]
    pop r9
    pop r8

    ; Output instructions to receive speed2
    mov rax, 0
    mov rdi, avgSpeedMsg
    call printf

    ; Recieve speed2 and copy that to xmm11
    mov rdi, format
    push qword -9 ;rsp points to -9
    push qword -9
    mov rsi, rsp
    call scanf
    movsd xmm11, [rsp]
    pop r9
    pop r8

    ; Make a blank buffer line
    mov rax, 0
    mov rdi, new_line
    call printf

    ; Output instructions to receive distance3
    mov rax, 0
    mov rdi, milesTravelMsgLF
    call printf

    ; Recieve distance3 and copy that to xmm12
    mov rdi, format
    push qword -9 ;rsp points to -9
    push qword -9
    mov rsi, rsp
    call scanf
    movsd xmm12, [rsp]
    pop r9
    pop r8

    ; Output instructions to receive speed3
    mov rax, 0
    mov rdi, avgSpeedMsg
    call printf

    ; Recieve speed3 and copy that to xmm13
    mov rdi, format
    push qword -9 ;rsp points to -9
    push qword -9
    mov rsi, rsp
    call scanf
    movsd xmm13, [rsp]
    pop r9
    pop r8

    ; Make a blank buffer line
    mov rax, 0
    mov rdi, new_line
    call printf

    ; Inform the user that the info is being processed
    mov rax, 0
    mov rdi, processDataMsg
    call printf

    ; First i'll get the total distance and output that   
    addsd xmm0, xmm15
    addsd xmm0, xmm10
    addsd xmm0, xmm12

    ; Now I have the total distance in xmm0 and i'll output it
    mov rax, 1
    mov rdi, totalDistanceMsg
    call printf


    ; Now i'll calculate the time

    ; time = distance / speed

    ; first leg set
    movsd xmm6, xmm15 ; Copying distance1 to xmm6
    divsd xmm6, xmm14 ; Divide distance1 by speed1 using double-precision, resulting in xmm6

    ; second leg set
    movsd xmm7, xmm10 ; Copying distance2 to xmm7
    divsd xmm7, xmm11 ; Dividing distance2 by speed2 using double-precision, resulting in xmm7
    addsd xmm6, xmm7 ; Add time of the second leg to the total using double-precision

    ; third leg set
    movsd xmm8, xmm12 ; Copying distance3 to xmm8
    divsd xmm8, xmm13 ; Dividing distance3 by speed3 using double-precision, resulting in xmm8
    addsd xmm6, xmm8 ; Add time of the third leg to the total using double-precision


    ; xmm6 now contains the total time, but we copy it over to xmm0
    movsd xmm0, xmm6

    ; Now we output the total time 
    mov rax, 1
    mov rdi, totalTimeMsg
    call printf


    ; Clear xmm0 to ensure it starts from 0 for recalculating total distance
    xorpd xmm0, xmm0
    addsd xmm0, xmm15
    addsd xmm0, xmm10
    addsd xmm0, xmm12

    ; xmm0 now has the total distance recalculated

    ; Ensure xmm6 has the total time calculated earlier
    ; No need to move if xmm6 already has the total time

    ; Calculate average speed
    movsd xmm15, xmm0  ; Copy total distance to xmm15
    divsd xmm15, xmm6  ; Divide total distance by total time using double-precision

    ; xmm15 now has the average speed
    mov rax, 1        ; Prepare for floating point output
    movsd xmm0, xmm15  ; Copy average speed to xmm0 for printing
    mov rdi, avgSpeedTripMsg
    call printf

    push qword 0
    movsd [rsp], xmm15

    movsd xmm0, [rsp]
    pop rax
    

    ; Clean up
    popf
    pop rdx
    pop rbp
    ret