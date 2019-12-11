# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit eutils cmake-utils

DESCRIPTION="PHD2 Autoguiding software"
HOMEPAGE=""
SRC_URI="https://github.com/OpenPHDGuiding/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
PATCHES=(
	"${FILESDIR}"/phd2-system-libtoupcam.patch
)

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~arm ~arm64"
IUSE=""

DEPEND="
	sys-libs/zlib
	sci-libs/libnova
	virtual/libusb
	x11-libs/wxGTK:3.0
	net-misc/curl
	sci-libs/libasi
	sci-libs/libtoupcap
"
RDEPEND="${DEPEND}"
BDEPEND=""
