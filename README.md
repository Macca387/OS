# OS

This is a project that no person in the world should ever be looking at in the state that it is in.

I have no idea what I am doing and I am using this as a learning experience.

I don't even know how to use git.

This is so annoying, it isn't git-ing.

Yay, using git --force OS main did the trick and now everything is uploaded and I can now use GITHUB.

Make the binary file using command below.
nasm src/bootv3.asm -f bin -o bin/bootv3.bin

Start QEMU using the below command.
qemu-system-x86_64 -fda bin/bootv3.bin

Ok I have no idea what I am doing to load into a stage 2.
