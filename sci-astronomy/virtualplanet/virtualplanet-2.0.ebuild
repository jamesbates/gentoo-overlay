# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit eutils xdg-utils

DESCRIPTION="Virtual planet atlas"
HOMEPAGE=""
SRC_URI="https://master.dl.sourceforge.net/project/${PN}/4-Source/${PV}/${P}-src.tar.xz -> ${P}-src.tar.xz"
PATCHES=(
	"${FILESDIR}"/"${PN}"-lazarus2.patch
)

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
"
BDEPEND=""

S="${WORKDIR}/${P}-src"

src_configure() {

	./configure fpc=/usr/lib/fpc/"`fpc -iV`"/units/"`fpc -iTP`"-"`fpc -iTO`" prefix=/usr
}

src_compile() {

	emake -j1
}

src_install() {

	emake -j1 PREFIX="${D}/usr" install install_data install_data2 install_data3
}

pkg_postinst() {

	xdg_icon_cache_update
	xdg_desktop_database_update
}
