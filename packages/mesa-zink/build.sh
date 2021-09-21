TERMUX_PKG_HOMEPAGE=https://www.mesa3d.org
TERMUX_PKG_DESCRIPTION="Mesa opengl library"
TERMUX_PKG_LICENSE="MIT"
TERMUX_PKG_MAINTAINER="DLC01"
TERMUX_PKG_VERSION=21.2.0
TERMUX_PKG_SRCURL=https://github.com/mesa3d/mesa.git
_COMMIT=b8970120545b3cb250821013cb459bf4d2acfda4
TERMUX_PKG_DEPENDS="libandroid-shmem-static, libc++, libdrm, libexpat, bison, flex, vulkan-headers"
TERMUX_PKG_BUILD_DEPENDS="xorgproto, vulkan-loader-android"
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="
-Dgallium-drivers=zink
"

termux_step_post_get_source() {
	git pull
        git reset --hard ${_COMMIT}
}

termux_step_pre_configure() {
    export LDFLAGS=" -L${TERMUX_PREFIX}/lib -latomic -llog"
}

termux_step_post_massage() {
        cd ${TERMUX_PKG_MASSAGEDIR}/${TERMUX_PREFIX}/lib || exit 1
        if [ ! -e "./libGL.so.1" ]; then
                ln -sf libGL.so libGL.so.1
        fi
}

termux_step_install_license() {
        install -Dm600 -t $TERMUX_PREFIX/share/doc/mesa $TERMUX_PKG_BUILDER_DIR/LICENSE
}
