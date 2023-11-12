nasm -f elf64 "$1.asm"
ld -s -o "$1" "$1.o"
rm -rf *.o
"./$1"
