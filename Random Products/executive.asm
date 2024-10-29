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
;  This program is a starting point to communicate with the rest of the program
;
;This file:
;  File name: executive.asm
;  Language: X86-64
;  Max page width: 124 columns
;  Assemble (standard): 
;  Assemble (debug): 
;  Optimal print specification: Landscape, 7 points, monospace, 8½x11 paper
;  Prototype of this function: extern void executive();
; 
;
;
;
;========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**

global executive
extern fill_random_array
extern normalize_array
extern show_array
extern sort_array
extern printf
extern fgets
extern stdin
extern strlen
extern scanf
extern atof
array_size equ 100
float_size equ 60
name_string_size equ 48

section .data
    ; User info / Greeting
    inputUserName db "Please enter your name: ", 0
    inputUserTitle db "Please enter your title (Sargent, Chief, CEO, President, Teacher, etc): ", 0
    userGreeting db "Nice to meet you %s %s", 10, 0

    ; Floating number inputs
    informProgramOutput db "This program will generate 64-bit IEEE float numbers.", 0
    getNumberOutputAmount db "How many numbers do you want. Today’s limit is 100 per customer. ", 0
    informUserValueRecieved db "Your numbers have been stored in an array. Here is that array.", 10, 0

    ; Index for the Array Values
    indexTitle db "IEEE754              Scientific Decimal", 0

    ; Inform user that array will be Normalized
    normalizeInfo db "The array will now be normalized to the range 1.0 to 2.0 Here is the normalized array", 10, 0

    ; Inform user array has been sorted
    sortedInfo db "The array will now be sorted", 10, 0

    ; Goodbye output
    goodbyeOutput db "Good bye %s. You are welcome any time.", 10, 0
    weDone db "Oh, %s. We hope you enjoyed your arrays. Do come again.", 10, 0

    ; New Line buffer
    newLine db "", 10, 0
    
    ; User string, used to validate misc inputs
    user_string db "%s", 0

    ; Input Error
    userError db "Invalid Input, please try again", 0
    int_format db "%d", 0      ; Format for reading an integer

    zero dd 0.0        ; Define 0.0 for comparison
    hundred dd 100.0   ; Define 100.0 for comparison

    debug db "Debug = %d", 10, 0

section .bss
    align 64
    nice_array resq array_size

    user_name resb name_string_size
    user_title resb name_string_size
    input_float resb float_size
    input_number resq 1        ; Reserve space for the integer input

section .text

executive:
    push rbp
    mov rbp, rsp

    ; No need to align the stack here, the stack hasn't moved yet
    ;sub rsp, 32 ; Ensure stack alignment

    ; Print introduction messages

    ; Get User name
    mov rax, 0
    lea rdi, [inputUserName]
    call printf

    mov rax, 0
    mov rdi, user_name
    mov rsi, name_string_size
    mov rdx, [stdin]
    call fgets

    ; Output instructions to receive title
    mov rax, 0
    lea rdi, [inputUserTitle]
    call printf

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

    ; Greet the user via their name and title
    mov rax, 0              ; Specify floating-point argument count (not strictly needed here, but good practice for printf)
    lea rdi, [userGreeting] ; Load the address of the greeting message
    lea rsi, [user_title]    ; Load the address of the user's name
    lea rdx, [user_name]   ; Load the address of the user's title
    call printf             ; Call printf to print the greeting

    ; Make a blank buffer line
    mov rax, 0
    mov rdi, newLine
    call printf

    ; Explain to the user how the program works
    mov rax, 0
    lea rdi, [informProgramOutput]
    call printf

    mov rax, 0
    mov rdi, newLine
    call printf

    mov rax, 0
    lea rdi, [getNumberOutputAmount]
    call printf
    
    ; Ask user how many numbers they want then recieve it
    ; call valid_num_loop 
    ; The function call above input a random large number instead of the expected input
    ; I commented it out and use a different input method instead
    
    ; Prepare for integer input
    mov rax, 0              ; Clear rax to indicate no vector registers used
    mov rdi, int_format     ; Load the address of the format string
    mov rsi, input_number   ; Address of the buffer to store the integer
    call scanf              ; Call scanf to read the integer    

    ; For testing only
    ; Now the input is in [input_number], do what you want with it
    ; mov rax, 0
    ; mov rdi, debug
    ; mov rsi, [input_number]
    ; call printf

    ; Now rdi needs to have the number of random numbers to generate
    ; mov eax, [input_number]      ; Move the input_number into eax (general use before moving to rdi)
    
    mov rdi, [input_number]              ; Move the number of elements into rdi, which is the first argument
    mov rsi, nice_array             ; Load the address of the array into rsi, which is the second argument
    ; Call the fill_random_array function with rdi set to the number of elements, and rsi as the address of the array
    call fill_random_array

    ; Our array now contains the random values, we shall inform the user of that then tell them what it contains
    mov rax, 0
    lea rdi, [informUserValueRecieved]
    call printf

    ; Make a blank line
    mov rax, 0
    lea rdi, [newLine]
    call printf

    ; Index for array
    mov rax, 0
    lea rdi, [indexTitle]
    call printf

    ; Make a blank line
    mov rax, 0
    lea rdi, [newLine]
    call printf

    ; Call show array to... well... show the array
    mov rdi, [input_number]
    mov rsi, nice_array
    call show_array

    ; Make a blank line
    mov rax, 0
    lea rdi, [newLine]
    call printf

    ; Inform the User that the Array will now be Normalized
    mov rax, 0
    lea rdi, [normalizeInfo]
    call printf

    ; Make a blank line
    mov rax, 0
    lea rdi, [newLine]
    call printf

    ; Call normalize array then show array
    mov rdi, [input_number]
    mov rsi, nice_array
    call normalize_array

    ; Index for array
    mov rax, 0
    lea rdi, [indexTitle]
    call printf

    ; Make a blank line
    mov rax, 0
    lea rdi, [newLine]
    call printf

    ; Call show array to... well... show the array
    mov rdi, [input_number]
    mov rsi, nice_array
    call show_array

    ; Make a blank line
    mov rax, 0
    lea rdi, [newLine]
    call printf

    ; Inform the user that the array will now be sorted
    mov rax, 0
    lea rdi, [sortedInfo]
    call printf
    
    ; Make a blank line
    mov rax, 0
    lea rdi, [newLine]
    call printf

    ; Call sort array then show array
    mov rdi, [input_number]
    mov rsi, nice_array
    call sort_array

    ; Index for array
    mov rax, 0
    lea rdi, [indexTitle]
    call printf

    ; Make a blank line
    mov rax, 0
    lea rdi, [newLine]
    call printf

    ; Call show array to... well... show the array
    mov rdi, [input_number]
    mov rsi, nice_array
    call show_array

    ; Make a blank line
    mov rax, 0
    lea rdi, [newLine]
    call printf

    mov rax, 0
    lea rdi, [goodbyeOutput]
    lea rsi, [user_title]
    call printf

    mov rax, 0
    lea rdi, [newLine]
    call printf

    mov rax, 0
    lea rdi, [weDone]
    lea rsi, [user_title]
    call printf
    ; Cleanup and return to C
    mov rsp, rbp
    pop rbp
    ret