      .data
msg1:  .asciz "*****Print Name*****\n"
msg2:  .asciz "Team 23\n"
msg3:  .asciz "robert\n"
msg4:  .asciz "liang\n"
msg5:  .asciz "hibiki\n"
msg6:  .asciz "*****End Print*****\n"

      .text
      .globl name
      .globl msg2
      .globl msg3
      .globl msg4
      .globl msg5

name: stmfd sp!,{r4-r7, lr}
      ldr   r0, =msg1
      bl    printf
      ldr   r0, =msg2
      mov   r4, r0
      bl    printf
      ldr   r0,=msg3
      mov   r5, r0
      bl    printf
      ldr   r0,=msg4
      mov   r6, r0
      bl    printf
      ldr   r0,=msg5
      mov   r7, r0
      bl    printf
      ldr   r0,=msg6
      bl    printf
      mov   r0, #0

      ldmfd sp!, {r4-r7, lr}
      mov   pc, lr
