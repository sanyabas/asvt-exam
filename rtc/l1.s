@
@ чтение регистра RTC Orange Pi Zero
@
@ сборка
@		gcc -o p41 p41.s
@ запуск
@		sudo ./p41
@
.data
ferror:	.asciz	"Input file open error\n"
merror:	.asciz	"Input file mmap error\n"
fname:	.asciz	"/dev/mem"
msg2:	.asciz	"RTC Hour-Minute-Second Register  (0x14) : %08x\n"
msg3:	.asciz	"RTC Year-Month-Day Register  (0x10) : %08x\n"

.text
	.syntax unified				@ используем весь набор команд версии 7 ядра
	.cpu arm10tdmi				@
	
file_access         = 2			@ доступ к памяти O_RDWR
timer_register_base = 0x01f00000	@ физический адрес места расположения регистров, отображаются только страницы с их реального начала, д.б. кратно 0х1000
base_address        = 0			@ базовый адрес от места расположения
page_size           = 4096		@ размер области отображения
prot_access         = 3			@ доступ PROT_READ | PROT_WRITE
map_access          = 1			@ доступ MAP_SHARED
HHMMSS 				= 0x00110a1a
YYMMDD 				= 0x00024509

.global	main
.align	4
main:
	push	{r0-r7, lr}
	sub	sp, sp, #8
@ открытие входного файла /dev/mem
	ldr	r0, =fname
	mov	r1, #file_access
	bl	open			@ r0 -> номер дескриптора или код ошибки
	cmn	r0, #1
	bne	1f
@ ошибка открытия
	ldr	r0, =ferror
	bl	printf
	mov	r0, #1			@ код возврата
	b	3f
1: @ mmap - отображаем физическую память в виртуальную
	ldr	r3, =timer_register_base
	stmia	sp, {r0, r3}		@ дескриптор файла и физический адрес страницы - в стек
	mov	r3, #map_access
	mov	r2, #prot_access
	mov	r1, #page_size
	mov	r0, #base_address
	bl	mmap			@ r0 -> виртуальный адрес нужной страницы физической памяти или код ошибки
	cmn	r0, #1
	bne	2f
@ ошибка mmap
	ldr	r0, =merror
	bl	printf
	mov	r0, #2			@ код возврата
	b	3f
2:
@ печатаем RTC Hour-Minute-Second Register (0x14)
	push	{r0}
	ldr 	r9, =HHMMSS
	@ldr 	r9, [r9]
	str		r9, [r0, #0x14]
	ldr		r1, [r0, #0x14]
	ldr		r0, =msg2
	bl		printf
	pop		{r0}
	ldr 	r9, =YYMMDD
	@ldr 	r9, [r9]
	str		r9, [r0, #0x10]
	ldr		r1, [r0, #0x10]
	ldr		r0, =msg3
	bl		printf
@ завершение работы
	mov	r0, #0			@ код возврата
3:
	add	sp, sp, #8
	pop	{r0-r7, pc}
