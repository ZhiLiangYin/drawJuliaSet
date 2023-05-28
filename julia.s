       .data
msg1:  .asciz "QAQ\n"



maxwidth: .word 640
maxhigh:  .word 480
con1:     .word 1500
con2:     .word 480000
con3:     .word 240000
con4:     .word 4000000
con5:     .word 1280
con6:     .word 0xffff

       .text
.constant:
   .word 255      @.constant+0
   .word 480000   @.constant+4
   .word 240000   @.constant+8
   .word 4000000  @.constant+12
   .word 1280     @.constant+16
   .word 0xffff   @.constant+20
       .globl julia


       	@ int zx, zy;  r4 r5
        @ int tmp;     r11
        @ int i;       r6
        @ int x, y;    r7 r8
        @ save cy      r9
        @ save frame   r10


julia:  stmfd   sp!,{r4-r11, lr}
        mov   r9,  r0   @ r9 can't use because r9 now save cy
        mov   r10, r1   @ r10 now save frame

        mov   r7, #0    @ x = 0
        cmp   r7, #0
        movne r7, #0

for1:   cmp   r7, #640  @ x < 640    @enter 31 for
        bge   exfor1
        mov   r8, #0    @ y = 0
for2:   cmp   r8, #480  @ y < 480    @enter 32 for
        bge   exfor2
        ldr   r1, =con1
        ldr   r1, [r1]   @ r1 = 1500
        mul   r1, r1, r7 @ r1 = 1500 * x
        ldr   r0, =con2 @ r0 = 480000
        ldr   r0, [r0]
        @ldr   r0, .constant+4
        sub   r0, r1, r0 @ r0=r1-r0= 1500x - 480000
        mov   r1, #320   @ r1 = 320
        bl    __aeabi_idiv @ r0 / r1
        mov   r4, r0     @ the answer of r0 set to r4 (zx)
        mov   r1, #1000  @ r1 = 1000
        mul   r1, r1, r8 @ r1 = 1000 * y
        ldr   r0, =con3  @ r0 = 240000
        ldr   r0, [r0]
        @ldr   r0, .constant+8
        sub   r0, r1, r0 @ r0=r1-r0 = 1000y - 240000
        mov   r1, #240   @ r1 = 240
        bl    __aeabi_idiv @ r0 / r1
        mov   r5, r0     @ the answer of r0 set to r5 (zy)
        mov   r6, #255

while:  mul   r0, r4, r4
        mul   r1, r5, r5
        add   r2, r0, r1
        ldr   r3, =con4
        ldr   r3, [r3]
        @ldr   r3, .constant+12
        cmp   r2, r3
        bge   jump
        cmplt   r6, #0 @enter 37 while
        ble   jump
        sub   r0, r0, r1
        mov   r1, #1000
        bl    __aeabi_idiv
        sub   r11, r0, #700        @ r11 is temp
        mul   r0, r4, r5
        mov   r1, #500
        bl    __aeabi_idiv
        add   r5, r0, r9      @ r9 = cy
        mov   r4, r11
        sub   r6, r6, #1      @ i--
        b     while

jump:   and   r1, r6, #0xff
        mov   r6, r1, lsl#8
        orr   r6, r6, r1      @ r6 = color
        @ldr   r0, =con6
        ldr   r0, .constant+20
        bic   r6, r0, r6

        mov   r0, r10
        ldr   r1, =con5 @ r1 = 1280
        ldr   r1, [r1]
        @ldr   r1, .constant+16
        mul   r1, r1, r8      @ r1 = 1280y
        add   r2, r7, r7      @ r2 = x + x = 2x
        add   r0, r0, r1
        add   r0, r0, r2
        strh  r6, [r0]
        add   r8, r8, #1      @ y++
        b     for2
exfor2: add   r7, r7, #1      @ x++
        b     for1

exfor1: mov   r0, #0
        mov   r1, #1
        cmp   r0, r1
        addeq r0, r0, r0, lsl r1
        ldreq   r0, [r1, #2]
        subs  r0, r14, r13
        ldmfd sp!, {r4-r11, lr}
        mov   pc, lr
