#------------------------------------------#
# int len_str(char* str)		   #
#					   #
# Returns the length of the string.	   #
#------------------------------------------#
.type len_str, @function
.global len_str
len_str:

    enter $0, $0

    pushl %ecx
    pushl %ebx

    movl 8(%ebp), %ebx 
    xorl %eax, %eax 
      
 countchar:
    movb (%ebx, %eax), %cl
    incl %eax
    cmpb $0, %cl
    jne countchar
    decl %eax 


    popl %ebx
    popl %ecx

    leave
    ret $4
