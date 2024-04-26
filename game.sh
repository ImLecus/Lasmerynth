as str_to_ul.s -o str_to_ul.o --32 -g
as len_str.s -o len_str.o --32 -g
as print_str.s -o print_str.o --32 -g
as set_cursor_pos.s -o set_cursor_pos.o --32 -g
as laberintoBASE.s -o laberintoBASE.o --32 -g
ld str_to_ul.o laberintoBASE.o print_str.o len_str.o set_cursor_pos.o -o game -melf_i386
rm laberintoBASE.o
rm str_to_ul.o
rm set_cursor_pos.o
rm print_str.o
rm len_str.o
./game
echo $?
