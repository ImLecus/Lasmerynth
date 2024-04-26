as ./lib/str_to_ul.s -o str_to_ul.o --32 -g
as ./lib/len_str.s -o len_str.o --32 -g
as ./lib/print_str.s -o print_str.o --32 -g
as ./lib/set_cursor_pos.s -o set_cursor_pos.o --32 -g
as ./lib/laberintoBASE.s -o laberintoBASE.o --32 -g
ld str_to_ul.o laberintoBASE.o print_str.o len_str.o set_cursor_pos.o -o game -melf_i386
rm laberintoBASE.o
rm load_map.o
rm str_to_ul.o
rm set_cursor_pos.o
rm print_str.o
rm len_str.o
./game ./maps/map1.bin 2 2 5 2
rm game
