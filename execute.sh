DIR_IMG="build/main_floopy.img"
ARCH_QEMU="qemu-system-i386"
RUN="${ARCH_QEMU} ${DIR_IMG}"

make && $RUN