.data
   key:    .byte 0   # Ultima pulsacion de teclado
   pos:    .byte 2,2 # Fila, Columna actual
   goal:   .byte 1,8 # Fila, Columna de salida
   # Graficos
   wall:   .asciz "#" # Pared
   nowall: .asciz " " # Espacio libre
   player: .asciz "@" # Jugador
   # Codigos ANSI
   position: .asciz "\033[02;02H" # Fila;Columna
   origen:   .asciz "\033[1;1H"   # Fila;Columna arriba-izquierda
   clear:    .asciz "\033[2J"     # Limpiar la terminal
   hidecur:  .asciz "\033[?25l"   # Ocultar el cursor
   showcur:  .asciz "\033[?25h"   # Mostrar el cursor
   nextline: .asciz "\033[1E"     # Pasar a siguiente linea
   # Textos
   victory: .asciz "Has conseguido llegar a la salida.\n"
   surrend: .asciz "Te has rendido.\n"
   # Datos del mapa
   mapfile: .long 0 # Archivo del mapa
   size: .long 9,9  # Tamaño del mapa en filas,columnas
   map: .asciz "111111101101010001101000001101110101100010101101010111100010101100000001111111111"
   FREE = '0' # Caracter que representa espacio libre

   # No TOCAR 
   termiosnew: .space 18 # Configuracion de la terminal
   termiosold: .space 18
   # NO TOCAR

.text
.global _start
# ARGUMENTOS:
# 1º Nombre del programa
# 2º Archivo de mapa
# 3º Fila inicio
# 4º Columna inicio
# 5º Fila final
# 6º Columna final
_start:
   # TODO PROCESAR ARGUMENTOS


   # TODO LEER MAPA DESDE ARCHIVO


   # Recuperar configuracion terminal
   movl $54, %eax
   movl $0, %ebx
   movl $0x5401, %ecx
   movl $termiosold, %edx
   int $0x80
   # Establecer nueva configuracion terminal
   movl $54, %eax
   movl $0, %ebx
   movl $0x5403, %ecx
   movl $termiosnew, %edx
   int $0x80
   # Limpiar terminal
   push $clear
   call print_str
   # Ocultar cursor
   push $hidecur
   call print_str


# BUCLE PRINCIPAL
mainLoop:
   # Limpiar pulsacion previa
   movb $0, (key)

   # Posicion 0,0 para mostrar mapa
   push $origen
   call print_str

   # Mostrar mapa
   xorl %edi, %edi
nextRow:
   xorl %esi, %esi
nextCol:
   # Por defecto espacio libre    
   movl $nowall, %ecx
   movl %edi, %eax
   mull (size+4)
   cmpb $FREE, map(%esi,%eax)
   je displayPos
   movl $wall, %ecx
 displayPos:
   # Mostrar pared o libre
   movl $4, %eax
   movl $1, %ebx
   movl $1, %edx
   int $0x80
   # Avanzar por array
   incl %esi
   cmpl (size), %esi
   jne nextCol
   # Mover cursor abajo
   movl $4, %eax
   movl $1, %ebx
   movl $nextline, %ecx
   movl $4, %edx
   int $0x80
   # Mas filas
   incl %edi
   cmp (size+4), %edi
   jne nextRow
   
   # Fijar posicion jugador
   push $position
   call print_str
   # Mostrar jugador
   push $player
   call print_str

   # Lectura teclado
   movl $3, %eax
   movl $0, %ebx
   movl $key, %ecx
   movl $1, %edx
   int $0x80

   # Comprobar pulsacion
   # MOVIMIENTO
   cmpb $'w', (key)
   je mov_up
   cmpb $'a', (key)
   je mov_left
   cmpb $'s', (key)
   je mov_down
   cmpb $'d', (key)
   je mov_right
   # SALIR
   cmpb $'q', (key)
   je fail
   
   # Comprobar meta
   movw (goal), %ax
   cmpw (pos), %ax
   je win
   
   # Sigue jugando
   jmp mainLoop
   
fail:
   push $surrend
   jmp end
   
win:
   push $victory

end:
   # Limpiar terminal
   push $clear
   call print_str
   # Cursor esquina izquierda-arriba
   push $origen
   call print_str
   # Recuperar estado terminal
   movl $54, %eax
   movl $0, %ebx
   movl $0x5403, %ecx
   movl $termiosold, %edx
   int $0x80
   # Mostrar el mensaje en pila
   call print_str
   # Mostrar cursor
   pushl $showcur
   call print_str
   # Retornar al SO
   movl $1, %eax
   movl $0, %ebx
   int $0x80


# TODO LOGICA DE CONTROL DEL JUGADOR
# TODO setCursorPos SERA SUBRUTINA, PROCESAR SALIDA
mov_up:
   decb (pos)
   pushl $position
   pushl (pos)
   call set_cursor_pos
   jmp mainLoop

mov_down:
   incb (pos)
   pushl $position
   pushl (pos)
   call set_cursor_pos
   jmp mainLoop

mov_right:
   incb (pos+1)
   pushl $position
   pushl (pos)
   call set_cursor_pos
   jmp mainLoop

mov_left:
   decb (pos+1)
   pushl $position
   pushl (pos)
   call set_cursor_pos
   jmp mainLoop

