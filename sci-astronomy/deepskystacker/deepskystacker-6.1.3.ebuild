# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

#CMAKE_MAKEFILE_GENERATOR=emake
inherit cmake

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
	sys-libs/zlib
	net-misc/curl
	sci-libs/cfitsio
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

#src_compile() {
#
#	emake -j1
#}


