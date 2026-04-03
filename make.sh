#!/bin/bash
nasm -f bin src/bootv2.asm -o Output/boot.bin
nasm -f bin src/startv1.asm -o Output/start.bin
cat Output/boot.bin Output/start.bin > Output/main_floppy.img
qemu-system-x86_64 -drive format=raw,file=Output/main_floppy.img