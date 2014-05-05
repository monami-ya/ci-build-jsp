#!/bin/bash

if [ $# -ne 1 ]; then
  echo "$0: cpu/sys" > /dev/stderr
  exit 1
fi

case $1 in
  armv4/*)      COMPILER=arm-elf ;;
  blackfin/*)   COMPILER=bfin-elf ;;
  h8/*)         COMPILER=h8300-elf ;;
  lm32/*)       COMPILER=lm32-elf ;;
  m32r/*)       COMPILER=m32r-elf ;;
  m68k/*)       COMPILER=m68k-elf ;;
  microblaze/*) COMPILER=microblaze-elf ;;
  mips32/*)     COMPILER=mips-elf ;;
  nios2/*)      COMPILER=nios2-elf ;;
  s1c33*)       COMPILER=undefined ;;
  sh[1234]/*)   COMPILER=sh-elf ;;
  v850/*)       COMPILER=v850-elf ;;
  xstormy16/*)  COMPILER=xstormy16-elf ;;
  *)            COMPILER=undefined ;;
esac

brew tap PizzaFactory/commandline
brew install pf-gnuchains4x-$COMPILER

cpu=${1%/*}
sys=${1#*/}

(cd jsp_core/cfg; make clean depend all)
rm -fr OBJ
mkdir OBJ
(cd OBJ; ../jsp_core/configure -C $cpu -S $sys; make depend; make)
