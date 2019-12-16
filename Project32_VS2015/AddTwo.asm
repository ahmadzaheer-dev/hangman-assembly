INCLUDE Irvine32.inc
.data

levelCounter dword 0       ; This variable holds the level of the game
wrongAttemptCounter dword  0
ecxStorage dword 0
gameOverBool dword 0
gameOverString byte "Game Over",0

ecxa byte "ecx:",0

; Declaration of words for Levels
level1_Hint byte "It's a name of an INSECT",0
level1_Word byte "bee",0
ptr_word1 dword offset level1_Word

level2_Hint byte "It' a name of a MAMMAL",0
level2_Word byte "bear",0
ptr_word2 dword offset level2_Word

level3_Hint byte "A symbol of WISDOM",0
level3_Word byte "owl",0

level4_Hint byte "A symbol of PEACE",0
level4_Word byte "dove",0

level5_Hint byte "A name of ANIMAL",0
level5_Word byte "hyena",0

level6_Hint byte "A CITY of PAKISTAN",0
level6_Word byte "kohat",0

level7_Hint byte "A famous food of Afghanistan",0
level7_Word byte "kabulipulao",0

level8_Hint byte "A brand of car",0
level8_Word byte "alfaromeo",0

level9_Hint byte "An International brand of food",0
level9_Word byte "popeyes",0

level10_Hint byte "A name of the football club",0
level10_Word byte "juventus",0
ptr_word10 dword level10_Word
level10_output byte "********",0
output10_ptr dword level10_output
index dword 0
test1 byte ?

.code
wordChecker proto, word2:dword
compareChar proto, char1:byte, char2:byte
compareCharToWord proto, word1:dword



main PROC
invoke wordChecker, ptr_word10
mov eax,gameOverBool
call writeint
mov eax,gameOverBool
cmp eax,1
je jump
mov eax,wrongAttemptCounter
call writeint
jump:
mov edx,offset gameOverString
call writestring
jmp EndProgram
main ENDP



wordChecker PROC, word2:dword
pushad
mov ecx,8
WCloop:
	mov ecxStorage,ecx
	invoke compareCharToWord ,word2
	;mov eax,index
	;call writeint
	mov edx,index
	cmp edx,8
	jge next
	mov dl,test1
	mov esi, output10_ptr
	add esi,index
	mov [esi],dl
	call crlf
	mov edx,offset level10_output
	call writestring

next:
	mov ecx, ecxStorage
	cmp ebx,1
	je WCnextIteration
	inc wrongAttemptCounter
	add ecx,1
	;mov eax,wrongAttemptCounter
	;call writeint
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



compareCharToWord PROC uses edx, word1:dword
mov esi,word1
mov ecx,8
mov index,0
call readchar
mov Test1,al
CCTWloop:
	invoke compareChar ,test1, [esi]
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

EndProgram:
END main




