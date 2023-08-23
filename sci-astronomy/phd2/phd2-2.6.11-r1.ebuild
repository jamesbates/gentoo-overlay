# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit eutils cmake

DESCRIPTION="PHD2 Autoguiding software"
HOMEPAGE=""
SRC_URI="https://github.com/OpenPHDGuiding/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
PATCHES=(
	"${FILESDIR}"/phd2-system-cameras-2.6.9.patch
)

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~arm ~arm64"
IUSE="indilib_drivers_asi indilib_drivers_toupbase indilib_drivers_qhy indilib_drivers_sbig indilib_drivers_ssag"

DEPEND="
	sys-libs/zlib
	sci-libs/libnova
	virtual/libusb
	x11-libs/wxGTK:3.0
	net-misc/curl
	indilib_drivers_asi? ( sci-libs/indilib-drivers-asi )
	indilib_drivers_toupbase? ( sci-libs/indilib-drivers-toupbase )
	indilib_drivers_qhy? ( sci-libs/indilib-drivers-qhy )
	indilib_drivers_sbig? ( sci-libs/indilib-drivers-sbig )
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
		-DUSE_OPENSSAG=$(usex indilib_drivers_ssag ON)
		-DUSE_ZWO=$(usex indilib_drivers_asi ON)
		-DUSE_TOUPCAM=$(usex indilib_drivers_toupbase ON)
		-DUSE_QHY=$(usex indilib_drivers_qhy ON)
		-DSBIG_SYSTEM=$(usex indilib_drivers_sbig ON)
	)

	cmake_src_configure
}

