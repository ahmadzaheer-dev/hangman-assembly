INCLUDE Irvine32.inc
.data



levelCounter dword 1       ; This variable holds the level of the game
wrongAttemptCounter dword  0
ecxStorage dword 0
gameOverBool dword 0
gameOverString byte "Game Over",0
mainController dword ?

chooseOptionString byte "Select from the option given below",0
startGameString byte "1 - Start Game",0
playNextString byte "2 - Next Level",0
playPreviousString byte "3 - Previous Level",0
exitGameString byte "4 - Exit Game",0
enterOptionString byte "Enter the number of the option: ",0



; Declaration of words for Levels
arrayLength dword ?

level1_Hint byte "Name of Animal::",0
level1_Word byte "zebra",0
ptr_word1 dword offset level1_Word
level1_output byte "*****",0
output1_ptr dword level1_output

level2_Hint byte "It' a name of a MAMMAL",0
level2_Word byte "bear",0
ptr_word2 dword offset level2_Word
level2_output byte "****",0
output2_ptr dword level2_output

level3_Hint byte "A symbol of WISDOM",0
level3_Word byte "owl",0
ptr_word3 dword offset level3_Word
level3_output byte "***",0
output3_ptr dword level3_output

level4_Hint byte "A symbol of PEACE",0
level4_Word byte "dove",0
ptr_word4 dword offset level4_Word
level4_output byte "****",0
output4_ptr dword level4_output

level5_Hint byte "A name of ANIMAL",0
level5_Word byte "hyena",0
ptr_word5 dword offset level5_Word
level5_output byte "*****",0
output5_ptr dword level5_output

index dword 0
charIn byte ?

.code
wordChecker proto, word2:dword, word3:dword, lengthOfWord:dword
compareChar proto, char1:byte, char2:byte
compareCharToWord proto, word1:dword, numberOfLetters:dword
restoreString proto, estericString:dword, lengthOfWord:dword



main PROC

menuLoop:
call printMenu
call readint
call clrscr
mov mainController,eax
cmp eax,1
je startGamelabel
cmp eax,2
je nextLevelLabel
cmp eax,3
je previousLevelLabel
cmp eax,4
je endGameLabel



startGameLabel:
	mov levelCounter,1
	mov eax,levelCounter
	jmp levelCompare 

nextLevelLabel:
	inc levelCounter
	mov eax,levelCounter
	jmp levelCompare

previousLevelLabel:
	mov eax,levelCounter
	jmp levelCompare

endGameLabel:
jmp EndProgram








levelCompare:
	cmp eax,1
	je level1
	cmp eax,2
	je level2
	cmp eax,3
	je level3
	cmp eax,4
	je level4
	cmp eax,5
	je level5

level1:
mov eax,lengthof level1_word
sub eax,1
mov arrayLength,eax
invoke wordChecker, ptr_word1, output1_ptr,arrayLength
invoke restoreString, output1_ptr, arrayLength
jmp menuLoop

level2:
mov eax,lengthof level2_word
sub eax,1
mov arrayLength,eax
invoke wordChecker, ptr_word2, output2_ptr,arrayLength
jmp menuLoop

level3:
mov eax,lengthof level3_word
sub eax,1
mov arrayLength,eax
invoke wordChecker, ptr_word3, output3_ptr,arrayLength
jmp menuLoop

level4:
mov eax,lengthof level4_word
sub eax,1
mov arrayLength,eax
invoke wordChecker, ptr_word4, output4_ptr,arrayLength
jmp menuLoop

level5:
mov eax,lengthof level5_word
sub eax,1
mov arrayLength,eax
invoke wordChecker, ptr_word5, output5_ptr,arrayLength
jmp menuLoop

main ENDP



wordChecker PROC uses ecx, word2:dword, word3:dword, lengthOfWord:dword
pushad
mov ecx,lengthOfWord
WCloop:
	mov ecxStorage,ecx
	invoke compareCharToWord ,word2,lengthOfWord
	mov edx,index
	cmp edx,lengthOfWord
	jge next
	mov dl,charIn
	mov esi, word3
	add esi,index
	mov [esi],dl
	call clrscr
	mov  dh,1
	mov dl,55
	call gotoxy
	mov edx,word3
	call writestring
	

next:
	mov ecx, ecxStorage
	cmp ebx,1
	je WCnextIteration
	inc wrongAttemptCounter
	add ecx,1
	mov ebx,wrongAttemptCounter
	cmp ebx,5
	je GameOver
	WCnextIteration:
	loop WCloop
	jmp WCReturn
GameOver:
mov gameOverBool,1
WCReturn:
popad
ret
wordChecker ENDP



compareCharToWord PROC uses edx, word1:dword, numberOfLetters:dword
mov esi,word1
mov ecx,numberOfLetters
mov index,0
mov  dh,1
mov dl,55
call gotoxy
call readchar
mov charIn,al
CCTWloop:
	invoke compareChar ,charIn, [esi]
	cmp edx,1
	je return
	inc esi
	inc index
	loop CCTWloop
return:
	mov ebx,edx
	ret
compareCharTOWord ENDP



; This procedure returns the value in edx. If its equal it returns 1 else it returns 0
compareChar PROC uses eax ,char1:byte, char2:byte
	mov edx,0
	mov al,char1
	cmp al,char2
	jne eax1
	mov edx,1
	eax1:
		ret
compareChar ENDP



printMenu PROC uses edx
	mov  dh,10
	mov dl,40
	call gotoxy
	mov edx, offset chooseOptionString
	call writestring
	mov  dh,11
	mov dl,40
	call gotoxy
	mov edx, offset startGameString
	call writestring
	mov  dh,12
	mov dl,40
	call gotoxy
	mov edx, offset playNextString
	call writestring
	mov  dh,13
	mov dl,40
	call gotoxy
	mov edx, offset playPreviousString
	call writestring
	mov  dh,14
	mov dl,40
	call gotoxy
	mov edx, offset exitGameString
	call writestring
	mov  dh,15
	mov dl,40
	call gotoxy
	mov edx, offset enterOptionString
	call writestring
	ret
printMenu ENDP


restoreString PROC , estericString:dword, lengthOfWord:dword
pushad
mov ecx,lengthofWord
mov eax,lengthofWord
call writeint
mov index,0
restoreLoop:
	mov edx,index
	cmp edx,lengthOfWord
	jge restoreReturn
	mov dl,'*'
	mov esi, estericString
	add esi,index
	mov [esi],dl
	inc index
	loop restoreLoop
restoreReturn:
popad
ret
restoreString ENDP


centerCursor PROC

centerCursor ENDP

EndProgram:
END main




