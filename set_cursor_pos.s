#----------------------------------------------------------#
# int set_cursor_pos(byte[] new_pos, char* cursor) 	   #
#					   		   #
# Returns 1 if the position is valid, 0    		   #
# otherwise.	  			   		   #
#----------------------------------------------------------#
.type set_cursor_pos, @function
.global set_cursor_pos
set_cursor_pos:

   enter $0, $0
   pushl %ebx
   # AH=fila, AL=columna
   movl 8(%ebp), %eax
   movl 12(%ebp), %ebx
   # TODO AMPLIAR A DOS CARACTERES CADA POSICION
   # Convertir a ACII
   orb $0x30, %al
   orb $0x30, %ah
   # Actualizar codigo ANSI
   movb %al, 3(%ebx)
   movb %ah, 6(%ebx)
   
   popl %ebx
   leave
   ret
