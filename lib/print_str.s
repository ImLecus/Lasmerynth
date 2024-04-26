#------------------------------------------#
# int print_str(char* str)		   #
#					   #
# Prints an string in console, returns the #
# number of characters written.		   #
#------------------------------------------#
.type print_str, @function
.global print_str
print_str:
	
    enter $0, $0

    pushl %edx
    pushl %ecx
    pushl %ebx

    movl 8(%ebp), %ecx 
    push %ecx
    call len_str       
    movl %eax, %edx
    
    movl $4, %eax      
    movl $1, %ebx      
    int $0x80

    popl %ebx
    popl %ecx
    popl %edx
    leave 
    ret $4
