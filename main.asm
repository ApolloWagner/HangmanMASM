; Apollo Wagner
;May 2nd 2024

.386P
.model flat, stdcall

INCLUDE irvine32.inc
INCLUDE randomwords.asm
INCLUDE lives.asm

INCLUDE Irvine32.inc
INCLUDE RandomWords.asm
INCLUDE Lives.asm

.data
    secretWord      BYTE ?
    blanks          BYTE 20 DUP("?")
    guesses         BYTE 6 DUP(?)
    correctGuesses  DWORD 0
    tries           DWORD 0
    winMessage      BYTE "Congratulations! You won!", 0
    loseMessage     BYTE "Sorry, you lost. The word was: ", 0
    prompt          BYTE "Enter your guess: ", 0
    promptForKey    BYTE "Press any key to exit...", 0

.code
main PROC
    call InitializeRandomSeed
    call SelectRandomWord

    ; Initialize blanks with underscores
    push OFFSET secretWord
    push OFFSET blanks
    call InitializeBlanks

    ; Display the initial blank word
    push OFFSET blanks
    call WriteString
    call Crlf

gameLoop:
    ; Prompt the user for a guess
    push OFFSET guesses
    call PromptForGuess
    call CheckGuess
    call DisplayWordProgress

    ; Check if the game is over
    push LENGTHOF secretWord
    push correctGuesses
    call CompareGuesses
    pop ecx
    pop edx
    je gameWon

    push MAX_GUESSES
    push tries
    call CompareGuesses
    pop ecx
    pop edx
    jge gameLost

    ; Continue game loop
    jmp gameLoop

gameWon:
    push OFFSET blanks
    call WriteString
    call Crlf
    call WriteString, OFFSET winMessage
    jmp endGame

gameLost:
    push OFFSET secretWord
    call WriteString
    call Crlf
    call WriteString, OFFSET loseMessage

endGame:
    call Crlf
    call WaitForKeyPress
    exit
main ENDP

InitializeRandomSeed PROC
    invoke GetTickCount
    mov ecx, eax
    ret
InitializeRandomSeed ENDP

WaitForKeyPress PROC
    mov edx, OFFSET promptForKey
    call WriteString
    call ReadChar
    ret
WaitForKeyPress ENDP

END main

