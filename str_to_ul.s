#------------------------------------------#
# int str_to_ul(char* str)		   #
#					   #
# Returns the conversion to decimal integer#
# from the string, 0xFFFF otherwise.	   #
#------------------------------------------#
.type str_to_ul, @function
.global str_to_ul
str_to_ul:
    
    enter $0, $0
    
    pushl %ebx
    pushl %ecx
    pushl %edx
    pushl %esi

    movl 8(%ebp), %ebx 
    pushl %ebx
    call len_str      
    movl %eax, %ecx
    xorl %eax, %eax
    xorl %edx, %edx
    xorl %esi, %esi
    movl $10, %edi
  nextdigit:
    mull %edi  # mul edx|eax=edi*eax
    jc overror
    movb (%ebx, %esi), %dl
	cmpb $'0', %dl
    jb overror
    cmpb $'9', %dl
    ja overror
    andb $0x0F, %dl  # subb $'0',%dl
    addl %edx, %eax
    jc overror
    incl %esi
    cmpl %ecx, %esi
    jne nextdigit

    jmp endstrul
 overror:
    movl $0xFFFF, %eax

 endstrul:
    
    popl %esi
    popl %edx
    popl %ecx
    popl %ebx
    
    leave
    ret $4

