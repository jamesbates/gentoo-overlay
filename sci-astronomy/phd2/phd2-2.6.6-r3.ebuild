# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit eutils cmake-utils

DESCRIPTION="PHD2 Autoguiding software"
HOMEPAGE=""
SRC_URI="https://github.com/OpenPHDGuiding/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
PATCHES=(
	"${FILESDIR}"/phd2-system-cameras.patch
)

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~arm ~arm64"
IUSE="indi_drivers_asicam indi_drivers_toupbase indi_drivers_qhy indi_drivers_sbig indi_drivers_ssag"

DEPEND="
	sys-libs/zlib
	sci-libs/libnova
	virtual/libusb
	x11-libs/wxGTK:3.0
	net-misc/curl
	indi_drivers_asicam? ( sci-libs/indilib-3rdparty-libs[indi_drivers_asicam] )
	indi_drivers_toupbase? ( sci-libs/indilib-3rdparty-libs[indi_drivers_toupbase] )
	indi_drivers_qhy? ( sci-libs/indilib-3rdparty-libs[indi_drivers_qhy] )
	indi_drivers_sbig? ( sci-libs/indilib-3rdparty-libs[indi_drivers_sbig] )
	sci-libs/cfitsio
	sci-libs/indilib
	virtual/libusb
	>=dev-cpp/eigen-3.2.91:3
	dev-cpp/gtest
"
RDEPEND="${DEPEND}"
BDEPEND=""

src_configure() {

	local mycmakeargs=(
		-DUSE_SYSTEM_CFITSIO=true
		-DUSE_SYSTEM_LIBUSB=true
		-DUSE_SYSTEM_EIGEN3=true
		-DUSE_SYSTEM_GTEST=true
		-DUSE_SYSTEM_LIBINDI=true
		-DUSE_OPENSSAG=$(usex indi_drivers_ssag ON)
		-DUSE_ZWO=$(usex indi_drivers_asicam ON)
		-DUSE_TOUPCAM=$(usex indi_drivers_toupbase ON)
		-DUSE_QHY=$(usex indi_drivers_qhy ON)
		-DSBIG_SYSTEM=$(usex indi_drivers_sbig ON)
	)

	cmake-utils_src_configure
}

