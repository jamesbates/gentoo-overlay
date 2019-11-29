# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

MY_PN="${PN/lib/}"

inherit cmake-utils udev user

DESCRIPTION="INDI Astronomical Control Protocol library"
HOMEPAGE="http://www.indilib.org/"
SRC_URI="https://github.com/${PN}/${MY_PN}/archive/v${PV}.tar.gz -> ${PN}-${PV}.tar.gz"

LICENSE="LGPL-2.1+ BSD GPL-2+ LGPL-2+"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="ogg test drivers qt5"

RDEPEND="
	sci-libs/cfitsio
	sci-libs/libnova
	sci-libs/gsl
	sci-libs/fftw
	sys-libs/zlib
	virtual/jpeg:0
	virtual/libusb:1
	net-misc/curl
	qt5? ( dev-qt/qtnetwork:5 )
	ogg? (
				media-libs/libogg
				media-libs/libtheora
        )
"
DEPEND="${RDEPEND}
	sys-kernel/linux-headers
	drivers? ( sci-libs/indilib-drivers )
	test? (
				dev-cpp/gmock
				dev-cpp/gtest
        )
"

DOCS=( AUTHORS ChangeLog README )

S=${WORKDIR}/${MY_PN}-${PV}

src_configure() {
	local mycmakeargs=(
		-DUDEVRULES_INSTALL_DIR=$(get_udevdir)/rules.d
		-DINDI_BUILD_UNITTESTS=$(usex test)
		$(cmake-utils_use qt5 INDI_BUILD_QT5_CLIENT)
		$(cmake-utils_use_find_package ogg OggTheora)
	)
	cmake-utils_src_configure
}

