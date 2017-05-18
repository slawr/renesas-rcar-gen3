SUMMARY = "Graphics OpenGL ES user libraries and depenencies package group"
LICENSE = "CLOSED & MIT"

DEPENDS = "gles-user-module \
    ${@bb.utils.contains('DISTRO_FEATURES', 'wayland', 'libgbm wayland-kms', '', d)} \
"

PR = "r0"

inherit packagegroup

PACKAGES = " \
    packagegroup-graphics-libegl \
"

RDEPENDS_packagegroup-graphics-libegl = " \
    gles-user-module \
    ${@bb.utils.contains('DISTRO_FEATURES', 'wayland', 'libgbm wayland-kms', '', d)} \
"

PROVIDES = "virtual/egl"
RPROVIDES_${PN} += " \
    libegl \
    libegl1 \
"
