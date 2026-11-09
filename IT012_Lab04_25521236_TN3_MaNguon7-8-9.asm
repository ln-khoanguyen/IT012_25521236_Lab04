#Le Nguyen Khoa Nguyen - 25521236
#TN3 - Tinh dien nang 12 thang, tong ca nam va thang cao nhat
.data
m1:      .asciiz "Thang "
m2:      .asciiz ": "
mt:      .asciiz "Tong: "
mm:      .asciiz "Thang cao nhat: "
lp:      .asciiz " ("
rp:      .asciiz ")"
nl:      .asciiz "\n"
reading: .word 1000, 1095, 1205, 1345, 1510, 1715, 1955
         .word 2210, 2440, 2625, 2775, 2895, 2995
usage:   .space 48
# Ma nguon 8 – dien nang tung thang	
.text
.globl main
main:
  la   $s0, reading     # $s0 = dia chi nen reading
  la   $s1, usage       # $s1 = dia chi nen usage
  addi $s2, $zero, 0    # i = 0
  #addi $s3, $zero, 12   # n = 12 thang
  #addi $s3, $zero, 13
  addi $s3, $zero, 11
  addi $s4, $zero, 0    # $s4 = tong dien nang = 0
  addi $s5, $zero, -1   # $s5 = max usage = -1
  addi $s6, $zero, 0    # $s6 = thang cao nhat = 0

Loop:
  beq  $s2, $s3, Done   # neu i == 12 thi ket thuc vong lap

  # Tinh dia chi reading[i] va doc reading[i], reading[i+1]
  sll  $t1, $s2, 2      # $t1 = i * 4
  add  $t2, $s0, $t1    # $t2 = &reading[i]
  lw   $t3, 0($t2)      # $t3 = reading[i]
  lw   $t4, 4($t2)      # $t4 = reading[i+1]

  # Tinh dien nang thang: $t5 = reading[i+1] - reading[i]
  sub  $t5, $t4, $t3

  # Luu vao m?ng usage[i]
  add  $t6, $s1, $t1    # $t6 = &usage[i]
  sw   $t5, 0($t6)

  # Cong don tong dien nang
  add  $s4, $s4, $t5

  # Kiem tra max: neu $s5 < $t5 thi cap nhat
  slt  $t7, $s5, $t5
  beq  $t7, $zero, SkipUpdate
  add  $s5, $t5, $zero  # $s5 = max value
  addi $s6, $s2, 1      # $s6 = thang (i + 1)
SkipUpdate:

  # In: "Thang " + (i + 1) + ": " + $t5 + "\n"
  li   $v0, 4
  la   $a0, m1
  syscall

  li   $v0, 1
  addi $a0, $s2, 1
  syscall

  li   $v0, 4
  la   $a0, m2
  syscall

  li   $v0, 1
  add  $a0, $t5, $zero
  syscall

  li   $v0, 4
  la   $a0, nl
  syscall

  # Tang i va lap tiep
  addi $s2, $s2, 1
  j    Loop

Done:
  # In Tong: "Tong: " + $s4 + "\n"
  li   $v0, 4
  la   $a0, mt
  syscall

  li   $v0, 1
  add  $a0, $s4, $zero
  syscall

  li   $v0, 4
  la   $a0, nl
  syscall

  # In: "Thang cao nhat: " + $s6 + " (" + $s5 + ")\n"
  li   $v0, 4
  la   $a0, mm
  syscall

  li   $v0, 1
  add  $a0, $s6, $zero
  syscall

  li   $v0, 4
  la   $a0, lp
  syscall

  li   $v0, 1
  add  $a0, $s5, $zero
  syscall

  li   $v0, 4
  la   $a0, rp
  syscall

  li   $v0, 4
  la   $a0, nl
  syscall

  li   $v0, 10
  syscall