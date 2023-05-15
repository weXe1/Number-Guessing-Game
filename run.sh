#!/usr/bin/bash
if nasm -f elf64 guess_number.asm; then
    if ld -lc guess_number.o -I/lib64/ld-linux-x86-64.so.2; then
        ./a.out
    fi
fi