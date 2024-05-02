
INCLUDE irvine32.inc
INCLUDE randomwords.asm
INCLUDE lives.asm

.data
    found           BYTE ?
    secretWord      BYTE ?
    guesses         BYTE 6 DUP(?)
    correctGuesses  DWORD ?
    tries           DWORD ?
    blanks          BYTE 20 DUP("?")
    winMessage      BYTE "Congratulations! You won!", 0
    loseMessage     BYTE "Sorry, you lost. The word was: ", 0
    prompt          BYTE "Enter your guess: ", 0
    promptForKey    BYTE "Press any key to exit...", 0

.code
CheckGuess PROC
    pushad
    mov found, 0
    mov esi, OFFSET secretWord
    movzx eax, guesses
    mov edi, OFFSET guesses
    cmp eax, 0
    je noGuess
checkLoop:
    cmp al, [esi]
    je foundGuess
    inc esi
    cmp byte ptr [esi], 0
    je noMatch
    jmp checkLoop
foundGuess:
    mov found, 1
    inc correctGuesses
    jmp noMatch
noMatch:
    inc tries
noGuess:
    inc edi
    movzx eax, byte ptr [edi]
    cmp eax, 0
    je endCheck
    jmp CheckGuess
endCheck:
    popad
    ret
CheckGuess ENDP

DisplayWordProgress PROC
    pushad
    mov edx, OFFSET blanks
    mov esi, OFFSET secretWord
    movzx ecx, byte ptr found
    cmp ecx, 0
    je noChange
    mov al, [esi]
    mov [edx], al
noChange:
    call WriteString
    call Crlf
    popad
    ret
DisplayWordProgress ENDP

PromptForGuess PROC
    pushad
    mov edx, OFFSET prompt
    call WriteString
    call ReadChar
    movzx eax, al
    popad
    ret
PromptForGuess ENDP
END
