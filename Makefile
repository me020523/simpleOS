all: bootloader.o proc.o

bootloader.o: bootloader/bootloader.S
	nasm -f bin bootloader/bootloader.S -o bootloader.o
proc.o: bootloader/proc.S
	nasm -f bin bootloader/proc.S -o proc.o
clean:
	rm *.o
install:
	dd if=bootloader.o of=simpleOS.img bs=512 count=1 conv=notrunc
	dd if=proc.o of=simpleOS.img bs=512 seek=1 count=1 conv=notrunc