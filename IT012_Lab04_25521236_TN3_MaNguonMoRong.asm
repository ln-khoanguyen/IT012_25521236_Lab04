#Le Nguyen Khoa Nguyen - 25521236
#Phan Mo Rong - Dem so thang theo tung bac gia dien
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
cnt:     .word 0, 0, 0, 0      # 4 phan tu dem so thang cho Bac 1..4
mbac:    .asciiz "Bac "

.text
.globl main
main:
  la   $s0, reading
  la   $s1, usage
  addi $s2, $zero, 0
  addi $s3, $zero, 12

VongLapTinhUsage:
  beq  $s2, $s3, DemBac
  sll  $t1, $s2, 2
  add  $t2, $s0, $t1
  lw   $t3, 0($t2)
  lw   $t4, 4($t2)
  sub  $t5, $t4, $t3
  add  $t6, $s1, $t1
  sw   $t5, 0($t6)
  addi $s2, $s2, 1
  j    VongLapTinhUsage

# Duyet usage de phan bac va dem
DemBac:
  addi $s2, $zero, 0    # i = 0
  la   $s4, cnt         # $s4 = &cnt

VongLapDem:
  beq  $s2, $s3, InBac
  sll  $t1, $s2, 2
  add  $t2, $s1, $t1
  lw   $t5, 0($t2)      # $t5 = usage[i]

  # Kiem tra bac (1..4)
  slti $t0, $t5, 101
  bne  $t0, $zero, IncB1
  slti $t0, $t5, 151
  bne  $t0, $zero, IncB2
  slti $t0, $t5, 201
  bne  $t0, $zero, IncB3

  # Bac 4
  addi $t8, $zero, 12   # offset cnt[3]
  j    Tang
IncB1:
  addi $t8, $zero, 0    # offset cnt[0]
  j    Tang
IncB2:
  addi $t8, $zero, 4    # offset cnt[1]
  j    Tang
IncB3:
  addi $t8, $zero, 8    # offset cnt[2]

Tang:
  add  $t9, $s4, $t8    # dia chi cua cnt[bac - 1]
  lw   $t7, 0($t9)      # lw
  addi $t7, $t7, 1      # addi
  sw   $t7, 0($t9)      # sw

  addi $s2, $s2, 1
  j    VongLapDem

# In ket qua 4 bac
InBac:
  addi $s2, $zero, 0    # k = 0
  addi $s3, $zero, 4
InVongLap:
  beq  $s2, $s3, Finish
  li   $v0, 4
  la   $a0, mbac
  syscall

  li   $v0, 1
  addi $a0, $s2, 1      # Bac k + 1
  syscall

  li   $v0, 4
  la   $a0, m2
  syscall

  sll  $t1, $s2, 2
  add  $t2, $s4, $t1
  lw   $a0, 0($t2)      # So thang
  li   $v0, 1
  syscall

  li   $v0, 4
  la   $a0, nl
  syscall

  addi $s2, $s2, 1
  j    InVongLap

Finish:
  li   $v0, 10
  syscall