      .data
msg1:  .asciz "*****Print ID*****\n"
msg2:  .asciz "**Please Enter Member 1 ID:**\n"
str:   .asciz "%d"
str1:   .asciz "%d\n"
str2:  .asciz "%s"
msg3:  .asciz "**Please Enter Member 2 ID:**\n"
msg4:  .asciz "**Please Enter Member 3 ID:**\n"
msg6:  .asciz "*****Print Team Member ID and ID Summation*****\n"
msg7:  .asciz "** Please Enter Command **\n"
msg8:  .asciz "ID Summation = %d\n"
msg9:  .asciz "\n"
msg5:  .asciz "*****End Print*****\n"
msg10: .asciz "fail command \n \n"

num:     .word  0
num2:    .word  0
num3:    .word  0
t:        .word  0
n1:    .word  '\0'
n2:    .word  'p'

      .text
      .globl id
      .globl num
      .globl num2
      .globl num3
      .globl t

id: stmfd sp!,{r4-r11, lr}
      ldr   r0, =msg1
      bl    printf
      ldr   r0, =msg2
      bl    printf

      ldr   r0 , =str
      ldr   r1, =num
      bl    scanf
      ldr   r1, =num
      ldr   r8, [r1]

      ldr   r0, =msg3
      bl    printf
      ldr   r0 , =str
      ldr   r1, =num2
      bl    scanf
      ldr   r1, =num2
      ldr   r9, [r1]

      ldr   r0, =msg4
      bl    printf
      ldr   r0 , =str
      ldr   r1, =num3
      bl    scanf
      ldr   r1, =num3
      ldr   r10, [r1]



      ldr   r0, =msg7
      bl    printf

      ldr   r0 , =str2
      ldr   r1, =n1
      bl    scanf
      ldr   r1, =n1
      ldr   r1, [r1]
      ldr   r11, =n2
      ldr   r11, [r11]

      cmp   r1, r11

      ldrne   r0, =msg10
      blne    printf

      cmp   r1, r11
      addal   r11,r8,r9
      addal   r11,r11,r10
      subal   r11,r11,#0
      ldr     r4, =t
      str     r11, [r4]

      ldreq   r0, =msg6
      bleq    printf
      ldreq   r0, =str1
      moveq   r1, r8
      bleq    printf

      ldreq   r0, =str1
      moveq   r1, r9
      bleq    printf

      ldreq   r0, =str1
      moveq   r1, r10
      bleq    printf


      ldreq   r0, =msg9
      bleq    printf
      ldreq   r0, =msg8
      moveq   r1, r11
      bleq    printf
      ldreq   r0, =msg5
      bleq    printf
      @beq   else
      mov   r0, #0
      ldmfd sp!,{r4-r11, lr}
      mov   pc, lr


/*

else: ldr   r0, =msg6
      bl    printf
      ldr   r0, =str1
      mov   r1, r8
      bl    printf
      ldr   r0, =str1
      mov   r1, r9
      bl    printf
      ldr   r0, =str1
      mov   r1, r10
      ldr   r0, =str1
      mov   r1, r9
      bl    printf
      ldr   r0, =msg9
      bl    printf
      ldr   r0, =msg8
      mov   r1, r11
      bl    printf
      ldr   r0, =msg5
      bl    printf
      mov   r0, #0
      ldmfd sp!,{lr}
      mov   pc, lr
*/



