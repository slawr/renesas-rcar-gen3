require include/gles-control.inc
require include/omx-options.inc
inherit systemd

FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"
SRC_URI = "file://init \
           file://weston.service \
           file://weston-start"

do_install_append() {
    if ${@bb.utils.contains('DISTRO_FEATURES', 'systemd', 'true', 'false', d)}; then
        install -Dm0644 ${WORKDIR}/weston.service ${D}${systemd_system_unitdir}/weston.service
        install -Dm0755 ${WORKDIR}/weston-start ${D}${bindir}/weston-start
    fi

    if [ "X${USE_GLES}" = "X1" ]; then
        sed -e "/RequiresMountsFor=\/run/a Wants=rc.pvr.service" \
            -e "/RequiresMountsFor=\/run/a After=rc.pvr.service dbus.service multi-user.target" \
            -e "s/\$OPTARGS/--idle-time=0 \$OPTARGS/" \
            -i ${D}${systemd_system_unitdir}/weston.service
    fi

    if [ "X${USE_MULTIMEDIA}" = "X1" ]; then
        if [ "X${USE_V4L2_RENDERER}" = "X1" ]; then
            sed -e "s/\$OPTARGS/--use-v4l2 \$OPTARGS/" \
                -i ${D}${systemd_system_unitdir}/weston.service
        fi
    fi
}

SYSTEMD_SERVICE_${PN} = "weston.service"
