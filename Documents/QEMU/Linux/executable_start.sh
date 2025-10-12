#!/usr/bin/env bash

ARGS=(
    -cpu max
    -machine q35,accel=kvm,memory-backend=memfd
    -object memory-backend-memfd,id=memfd,size=16G
    -smp cores=2,cpus=4

    -drive media=disk,format=qcow2,if=pflash,readonly=on,file=/usr/share/edk2/ovmf/OVMF_CODE_4M.secboot.qcow2
    -drive media=disk,format=qcow2,if=pflash,readonly=off,file=./OVMF_VARS_4M.secboot.qcow2

    -drive media=disk,format=qcow2,if=virtio,index=0,readonly=off,file=./disk.qcow2

    -drive media=cdrom,format=raw,if=ide,index=1,readonly=on,file=${HOME}/Downloads/cachyos-desktop-linux-260124.iso

    -display gtk,gl=on,show-cursor=off

    -device virtio-sound-pci,audiodev=pipewire
    -audiodev pipewire,id=pipewire

    -device virtio-net-pci,netdev=user
    -netdev user,hostfwd=tcp:127.0.0.1:2222-:22,id=user

    -chardev socket,id=swtpm,path=./tpm/swtpm.sock
    -device tpm-tis,tpmdev=tpm0
    -tpmdev emulator,id=tpm0,chardev=swtpm

    -device usb-tablet
    -usb

    -parallel none
    -serial none
)

if [ ! -f ./disk.qcow2 ]
then
  qemu-img create --format qcow2 ./disk.qcow2 64G
fi

if [ ! -f ./OVMF_VARS_4M.secboot.qcow2 ]
then
  cp /usr/share/edk2/ovmf/OVMF_VARS_4M.secboot.qcow2 ./
fi

mkdir --parents ./tpm

swtpm socket --ctrl "path=./tpm/swtpm.sock,type=unixio" --daemon --tpm2 --tpmstate "dir=./tpm"

exec qemu-system-x86_64 "${ARGS[@]}" "${@}"
