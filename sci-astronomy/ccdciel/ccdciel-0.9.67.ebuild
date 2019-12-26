# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit eutils xdg-utils

DESCRIPTION="A CCD capture program intended for the amateur astronomer"
HOMEPAGE=""
SRC_URI="https://github.com/pchev/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~arm ~arm64"
IUSE=""

DEPEND="
	dev-lang/fpc
	>=dev-lang/lazarus-2.0.2
"
RDEPEND="
	${DEPEND}
	sci-libs/indilib
	sci-libs/libpasastro
	media-gfx/dcraw
"
BDEPEND=""

src_configure() {

	./configure fpc=/usr/lib/fpc/"`fpc -iV`"/units/"`fpc -iTP`"-"`fpc -iTO`" prefix=/usr
}

src_compile() {

	emake -j1
}

src_install() {

	emake -j1 PREFIX="${D}/usr" install
}

pkg_postinst() {

	xdg_icon_cache_update
}
