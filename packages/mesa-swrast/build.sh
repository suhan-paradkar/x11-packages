TERMUX_PKG_HOMEPAGE=https://www.mesa3d.org
TERMUX_PKG_DESCRIPTION="An open-source implementation of the OpenGL specification"
TERMUX_PKG_LICENSE="MIT"
TERMUX_PKG_MAINTAINER="DLC01"
TERMUX_PKG_VERSION=21.0.0
TERMUX_PKG_REVISION=3
TERMUX_PKG_SRCURL=https://github.com/PojavLauncherTeam/mesa/archive/refs/heads/release-${TERMUX_PKG_VERSION}.zip
TERMUX_PKG_SHA256=66d5db6e1530e0addb473bd54aa8f3d273dc76d1ca6f4dbef1e57afac808b435
TERMUX_PKG_DEPENDS="libandroid-shmem, llvm, libllvm, bison, flex, libexpat, libdrm, libx11, libxdamage, libxext, zstd, libxml2, libxshmfence, zlib"
TERMUX_PKG_BUILD_DEPENDS="xorgproto"
TERMUX_PKG_CONFLICTS="libmesa"
TERMUX_PKG_REPLACES="libmesa"
TERMUX_PKG_RM_AFTER_INSTALL="include/KHR/khrplatform.h"

TERMUX_PKG_EXTRA_CONFIGURE_ARGS="
--prefix=$TERMUX_PREFIX
-Dgbm=enabled
-Degl=disabled
-Dgles1=disabled
-Dgles2=disabled
-Dlmsensors=disabled
-Dvalgrind=disabled
-Dllvm=enabled
-Dglx=gallium-xlib
-Dplatforms=x11
-Dopengl=true
-Dosmesa=true
-Dvulkan-drivers=
-Dgallium-drivers=swrast
-Dshared-glapi=enabled
-Ddri-drivers=
"

termux_step_pre_configure() {
	export LDFLAGS+=" -L${TERMUX_PREFIX}/lib -landroid-shmem -latomic -llog "
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
