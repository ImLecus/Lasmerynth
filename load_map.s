#------------------------------------------#
# char* load_map(char* file, char* target) #
#					   					   #
# Loads a new map to the game.		   	   #
#------------------------------------------#
.type load_map, @function
.global load_map
load_map:
	
	enter $0,$0
	movl 8(%ebp), %ebx # file location
	movl 12(%ebp), %edi # target
	pushl %ecx
	pushl %edx
	
	movl $5, %eax
	movl $0, %ecx
	int $0x80
	
	popl %ebx
	popl %ecx
	popl %edx
	popl %edi
	leave 
	ret
