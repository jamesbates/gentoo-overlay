# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

#CMAKE_MAKEFILE_GENERATOR=emake
inherit cmake xdg-utils

DESCRIPTION="DeepSkyStacker"
HOMEPAGE=""
SRC_URI="https://github.com/deepskystacker/DSS/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"
PATCHES=(
	"${FILESDIR}"/"${P}.patch"
)

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~arm ~arm64"

DEPEND="
	>=dev-qt/qtbase-6.10.0
	>=dev-qt/qtsvg-6.10.0
	>=dev-qt/qtcharts-6.10.0
	sci-libs/cfitsio
	dev-libs/boost
	media-gfx/exiv2
	dev-libs/expat
	>=media-libs/tiff-4.7.1
	media-libs/libraw
	llvm-runtimes/openmp
	sys-libs/zlib
"
RDEPEND="${DEPEND}"
BDEPEND=""

S="${WORKDIR}/DSS-${PV}"

src_configure() {

	local mycmakeargs=(
		-DCMAKE_DISABLE_PRECOMPILE_HEADERS=OFF
	)

	cmake_src_configure
}

pkg_postinst() {

	xdg_desktop_database_update
	xdg_icon_cache_update
	xdg_mimeinfo_database_update
}
