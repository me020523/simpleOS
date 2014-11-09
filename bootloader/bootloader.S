;a tiny bootloader
section .data
section .bss

section .text
BOOTSEG equ 0x07c0	;origin address of boot-sector
PROCSECS equ 0x1;	;proc小程序占用的扇区数
PROCSEG equ 0x9000	;the base of proc segment

global _main
_main:
    ;init the regs
    mov ax, $BOOTSEG
    ;mov cs, ax
    mov ds, ax
    
    
    ;软硬盘控制器复位
    xor ah, ah
    xor dl, dl
    int 0x13  ;reset FDC
    
    ;加载位于第二分区中的小程序至0x90000H
    mov ax, $PROCSEG
    mov es, ax
    mov ax, 0x0200 + $PROCSECS
    xor dx, dx
    mov dl, 0x80
    mov cx, 0x0002
    xor bx, bx
    int 0x13
    
    jnc LOAD_PROC_SUCC
    
LOAD_PROC_ERROR:
    ;清屏
    MOV     AX,0600H
    MOV     CX,0000H
    MOV     DX,184FH
    MOV     BH,07H
    INT     10H
    
    ;failed to load proc
    ;设置光标位置
    MOV     AH,02H
    MOV     DH,1           ;**为目的地行数(0-24)
    MOV     DL,1           ;**为目的地列数(0-79)
    MOV     BH,00H
    INT     10H
    
    ;打印字符串
    mov ax, $BOOTSEG
    mov es, ax
    mov ah, 0x13
    mov bp, $ERROR_MSG ;设置字符串偏移地址
    mov cx, $ERROR_MSG_LEN	;字符串长度
    mov dx, 0x0101  ;第1行第1列
    mov bh, 0x0 ;第0页
    mov al, 0x0 ;光标跟随移动
    mov bl, 0x04 ;黑底红字
    int 0x10
    
    jmp $
    
LOAD_PROC_SUCC:
    ;success to load proc, and jmp to it
    jmp $PROCSEG:0;

ERROR_MSG_LEN equ 30
ERROR_MSG:
    db "Fail to load proc\n"
times 510 - ($ - $$) db 0
    dw 0xAA55