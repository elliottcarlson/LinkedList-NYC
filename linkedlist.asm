; 'LinkedList NYC' printed out using a Linked List implementation in ASM
;
; Elliott Carlson  -  x@sublim.nl

    extern malloc
    extern free
    extern putchar

%macro init 1
    mov         dword [%1], 0
%endmacro

; Append mactro to add one or more passed items to the linked list procedure
%macro append 1-*
    %rep %0 
        push    dword %1
        push    linkedlist
        call    ll_append
    %rotate 1
    %endrep
%endmacro

; Print out the linked list
%macro print 1
    push        dword [%1]
    call        ll_print
%endmacro

; Cleanup the linked lists allocated memory
%macro cleanup 1
    push        dword [%1]
    call        ll_cleanup
%endmacro

section .data
    size_i:
    struc node
        info:   resd  1
        next:   resd  1
    endstruc
    len:        equ $ - size_i

section .bss
    linkedlist: resd  1

section .text
    global      main

; Main
main:
    ; Save the stack
    push        ebp
    mov         ebp, esp

    ; Initialize list as empty
    init        linkedlist    

    ; Append the hex codes of the message 'LinkedList NYC' to
    ; the linked list via the append macro
    append      0x4c, 0x69, 0x6e, 0x6b, 0x65, 0x64, 0x4c
    append      0x69, 0x73, 0x74, 0x20, 0x4e, 0x59, 0x43

    ; Print out the contents of the linked list
    print       linkedlist

    ; Clean up allocated memory
    cleanup     linkedlist

    ; Restore stack
    mov         esp, ebp
    pop         ebp
    ret

; Linked list append
; Add an element to the linked list
ll_append:
    ; Save the stack
    push        ebp
    mov         ebp, esp

    ; Save registers
    push        eax
    push        ebx

    ; Get the allocated memory of the linked list - push to eax
    push        len
    call        malloc
    
    mov         ebx, [ebp + 12]
    mov         [eax + info], ebx
    mov         dword [eax + next], 0

    ; Check if the linked list is currently null
    mov         ebx, [ebp + 8]
    cmp         dword [ebx], 0
    je          ll_append_null

    mov         ebx, [ebx]

ll_append_next:
    ; Find the address of the last element in the linked list
    cmp         dword [ebx + next], 0
    je          ll_append_last

    mov         ebx, [ebx + next]
    jmp         ll_append_next

ll_append_last:
    ; Set the pointer to the address of the last element
    mov         [ebx + next], eax
    jmp         ll_append_exit

ll_append_null:
    ; Set pointer to first element
    mov         [ebx], eax

ll_append_exit:
    ; Restore registers
    pop         ebx
    pop         eax

    ; Restore stack    
    mov         esp, ebp
    pop         ebp
    ret         8

; Linked list print
; Print all elements out from a linked list
ll_print:
    ; Save the stack
    push        ebp
    mov         ebp, esp

    ; Save register
    push        ebx

    ; Get the address of the first element in the list
    mov         ebx, [ebp + 8]
    ; If ebx is 0, then the list is empty - bothing to print
    cmp         ebx, 0
    je          ll_print_exit

ll_print_next:
    ; Loop through the linked list and print each character    
    push        dword [ebx + info]
    call        putchar
    mov         ebx, [ebx + next]
    ; As long as ebx doesn't equal 0 (end of list) then loop
    cmp         ebx, 0
    jne         ll_print_next
    
    ; Print a new line character at the end
    push        dword 10
    call        putchar

ll_print_exit:
    ; Restore stack
    pop         ebx
    mov         esp, ebp
    pop         ebp
    ret         4

; Linked list cleanup
; Deallocate memory used by the linked list
ll_cleanup:
    ; Save stack
    push        ebp
    mov         ebp, esp

    ; Save register
    push        eax

    ; Get address of the current position of the stack in the linked list
    mov         eax, [ebp + 8]
    ; Check if we have passed the end of the linked list
    cmp         eax, 0
    je          ll_cleanup_exit

    ; Go to the next available address in the linked list and loop
    push        dword [eax + next]
    call        ll_cleanup

    ; Set the address of the current element and free it from memory
    push        eax
    call        free
    add         esp, 4

ll_cleanup_exit:
    ; Restore register
    pop         eax

    ; Restore stack
    mov         esp, ebp
    pop         ebp
    ret         4
