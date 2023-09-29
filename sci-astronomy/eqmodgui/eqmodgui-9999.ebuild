# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit xdg-utils

DESCRIPTION="A GUI for INDI EqMod driver"
HOMEPAGE=""
if [[ ${PV} == *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/pchev/${PN}.git"
	EGIT_SUBMODULES=()
else
    SRC_URI="https://github.com/pchev/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
    KEYWORDS="~amd64 ~x86 ~arm ~arm64"
fi

LICENSE="GPL-3+"
SLOT="0"
IUSE=""

DEPEND="
	dev-lang/fpc
	>=dev-lang/lazarus-1.8.4-r2
	media-libs/sdl-mixer
"
RDEPEND="
	${DEPEND}
	|| ( sci-libs/indilib-3rdparty[indi_drivers_eqmod] sci-libs/indilib-drivers[indilib_drivers_eqmod] )
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

