# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake-utils eutils udev

DESCRIPTION="INDIlib 3rdparty driver library dependencies"
HOMEPAGE="http://www.indilib.org/"
SRC_URI="https://github.com/indilib/indi-3rdparty/archive/v${PV}.tar.gz -> indi-3rdparty-${PV}.tar.gz"

LICENSE="LGPL-2.1+ BSD GPL-2+ LGPL-2+"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~arm ~arm64"
IUSE="
	indi_drivers_apogee
	indi_drivers_asicam
	indi_drivers_atik
	indi_drivers_fishcamp
	indi_drivers_fli
	indi_drivers_inovaplx
	indi_drivers_qhy
	indi_drivers_qsi
	indi_drivers_sbig
	indi_drivers_toupbase
"

REQUIRED_USE="|| ( $IUSE )"

DEPEND="
	=sci-libs/indilib-${PV}
	virtual/pkgconfig
	indi_drivers_apogee? ( >=virtual/libusb-1 net-misc/curl )
	indi_drivers_fishcamp? ( >=virtual/libusb-1 )
	indi_drivers_fli? ( >=virtual/libusb-1 )
	indi_drivers_qsi? ( dev-embedded/libftdi )
"
RDEPEND="
	${DEPEND}
	!sci-libs/libasi
	!sci-libs/libtoupcam
"

S="${WORKDIR}/indi-3rdparty-${PV}"

indi_driver_use() {
	echo -DWITH_"${1^^}"="$(usex indi_drivers_"$1" ON OFF)"
}

indi_drivers_config() {
	for u in $IUSE; do
	    [[ "$u" =~ ^indi_drivers_.* ]] && indi_driver_use "${u#indi_drivers_}"
	done
}

src_configure() {
	local mycmakeargs=(
		$(indi_drivers_config)
		-DBUILD_LIBS=ON
		-DUDEVRULES_INSTALL_DIR="$(get_udevdir)"/rules.d
	)

	cmake-utils_src_configure
}


pkg_postinst() {

	/sbin/ldconfig
}

