# Auto load wilc_sdio module during kernel boot
rootfs_postprocess_function() {
    echo "wilc_sdio" > ${IMAGE_ROOTFS}/etc/modules-load.d/wilc_sdio.conf
}

ROOTFS_POSTPROCESS_COMMAND_append = " \
    rootfs_postprocess_function; \
"
