#!/bin/sh

# Add local path to init scripts
sed -i '3iexport PATH=/sbin:/usr/sbin:/bin:/usr/bin:/usr/local/sbin:/usr/local/bin' ${TARGET_DIR}/etc/init.d/rcK
sed -i '3iexport PATH=/sbin:/usr/sbin:/bin:/usr/bin:/usr/local/sbin:/usr/local/bin' ${TARGET_DIR}/etc/init.d/rcS

# Remove log daemon init scripts since they are loaded from inittab
rm -f ${TARGET_DIR}/etc/init.d/S01syslogd ${TARGET_DIR}/etc/init.d/S02klogd

# Change dropbear init sequence
mv ${TARGET_DIR}/etc/init.d/S50dropbear ${TARGET_DIR}/etc/init.d/S42dropbear

# Generate U-Boot environment
${HOST_DIR}/bin/mkenvimage -p 0x0 -s 0x20000 -o ${BINARIES_DIR}/u-boot-env.img ${TARGET_DIR}/etc/u-boot.env
