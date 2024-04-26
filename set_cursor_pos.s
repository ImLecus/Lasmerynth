#------------------------------------------------------------------#
# int set_cursor_pos(byte[] new_pos, char* cursor, char* map) 	   #
#					   		   	   #
# Returns 1 if the position is valid, 0    		   	   #
# otherwise.	  			   		   	   #
#------------------------------------------------------------------#
.type set_cursor_pos, @function
.global set_cursor_pos
set_cursor_pos:

   enter $0, $0
   pushl %ebx
   pushl %ecx
   pushl %esi # contador de índice
   pushl %edx # registro auxiliar
   # AH=fila, AL=columna
   movl 8(%ebp), %eax
   movl 12(%ebp), %ebx
   movl 16(%ebp), %ecx
   
   movl %eax, %edx
   
   movl $-1, %esi
   
   cmpb $1, %dl
   je countHorizontalIndex
   
   countIndex:
     decb %dl
     addl $9, %esi
     cmpb $1, %dl
     jbe countHorizontalIndex
     jmp countIndex
    
   countHorizontalIndex:
     decb %dh
     incl %esi
     cmpb $0, %dh
     jbe convert
     jmp countHorizontalIndex
   
   convert:
   # TODO AMPLIAR A DOS CARACTERES CADA POSICION
   # Convertir a ACII
   orb $0x30, %al
   orb $0x30, %ah
   # Actualizar codigo ANSI
   movb %al, 3(%ebx)
   movb %ah, 6(%ebx)
   
   cmpb $'1', (%ecx, %esi) 
   je err
   
   end:
       
       popl %ebx
       popl %ecx
       movl $1, %eax
       leave
       ret
   
   err:
       popl %ebx
       popl %ecx
       movl $0, %eax
       leave
       ret
    
 
