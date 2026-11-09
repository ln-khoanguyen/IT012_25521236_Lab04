#Le Nguyen Khoa Nguyen - 25521236
# Ma nguon 5 – phan bac dien nang
.data
prompt: .asciiz "Nhap dien nang (kWh): "
msg:    .asciiz "Bac: "
nl:     .asciiz "\n"

.text
.globl main
main:
  li  $v0, 4
  la  $a0, prompt
  syscall
  li  $v0, 5            # doc kWh, ket qua o $v0
  syscall
  add $s0, $v0, $zero   # $s0 = dien nang (kWh)


  # Phan bac:
  # Bac 1: 0 - 100 (<101)
  slti $t0, $s0, 101
  bne  $t0, $zero, BAC1

  # Bac 2: 101 - 150 (<151)
  slti $t0, $s0, 151
  bne  $t0, $zero, BAC2

  # Bac 3: 151 - 200 (<201)
  slti $t0, $s0, 201
  bne  $t0, $zero, BAC3

  # Bac 4: >= 201
  li   $s1, 4
  j    Print

BAC1:
  li   $s1, 1
  j    Print

BAC2:
  li   $s1, 2
  j    Print

BAC3:
  li   $s1, 3
  j    Print

Print:
  li   $v0, 4
  la   $a0, msg
  syscall

  li   $v0, 1
  add  $a0, $s1, $zero
  syscall

  li   $v0, 4
  la   $a0, nl
  syscall

  li   $v0, 10
  syscall