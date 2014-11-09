;位于磁盘第二分区中的小程序，打印 "Hello,World!"

section .text
    ;初始化寄存器
    mov ax, cs
    mov ds, ax
    mov es, ax
    
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
    mov bp, $PROC_MSG	;设置字符串偏移地址
    mov cx, $MSG_LEN	;字符串长度
    mov dx, 0x0101 	;第1行第1列
    mov bh, 0x0 	;第0页
    mov ah, 0x13
    mov al, 0x0 	;光标跟随移动
    mov bl, 0x04	;黑底红字
    int 0x10
    
MSG_LEN equ 12
PROC_MSG:    
    db "Hello,World!"