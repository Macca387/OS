ASM=nasm

SRC_DIR=src
BUILD_DIR=Output

$(BUILD_DIR)/main_floppy.img: $(BUILD_DIR)/main.bin
	cp $(BUILD_DIR)/main.bin $(BUILD_DIR)/main_floppy.img
	truncate -s 1440k $(BUILD_DIR)/main_floppy.img

$(BUILD_DIR)/main.bin: $(SRC_DIR)/bootv2.asm  $(SRC_DIR)/startv1.asm
	$(ASM) $(SRC_DIR)/bootv2.asm $(SRC_DIR)/startv1.asm -f bin -o $(BUILD_DIR)/main.bin

run: $(BUILD_DIR)/main_floppy.img
	qemu-system-x86_64 -drive format=raw,file=$(BUILD_DIR)/main_floppy.img