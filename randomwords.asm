
INCLUDE irvine32.inc
INCLUDE randomwords.asm
INCLUDE lives.asm

.code
SelectRandomWord PROC
    pushad
    mov eax, OFFSET wordsList
    call Randomize
    mov ebx, OFFSET secretWord
    mov ecx, 0
randomWordLoop:
    mov edx, eax
    add edx, ecx
    mov al, [edx]
    cmp al, 0
    je selectedWord
    mov [ebx], al
    inc ebx
    inc ecx
    jmp randomWordLoop
selectedWord:
    popad
    ret
SelectRandomWord ENDP
END
