# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit xdg-utils

DESCRIPTION="A skychart program intended for the amateur astronomer"
HOMEPAGE=""
if [[ ${PV} == *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/pchev/${PN}.git"
	EGIT_SUBMODULES=()
	SRC_URI="http://sourceforge.net/projects/skychart/files/4-source_data/data_spicesun.tgz -> data_spicesun.data"
else
    SRC_URI="https://github.com/pchev/${PN}/archive/V${PV}.tar.gz -> ${P}.tar.gz
			http://sourceforge.net/projects/skychart/files/4-source_data/data_spicesun.tgz -> data_spicesun.data"
    KEYWORDS="~amd64 ~x86 ~arm ~arm64"
fi

LICENSE="GPL-3+"
SLOT="0"
IUSE="+data"

DEPEND="
	dev-lang/fpc
	>=dev-lang/lazarus-2.0.2[-gtk2,extras]
"
RDEPEND="
	${DEPEND}
	sci-libs/indilib
	sci-libs/libpasastro
"
BDEPEND=""

src_unpack() {
	if [[ ${PV} == *9999 ]]; then
		git-r3_src_unpack
	fi
	default_src_unpack
	cp ${DISTDIR}/data_spicesun.data ${WORKDIR}/${P}/BaseData/data_spicesun.tgz
}

src_configure() {

	./configure fpc=/usr/lib/fpc/"`fpc -iV`"/units/"`fpc -iTP`"-"`fpc -iTO`" prefix=/usr
}

src_compile() {

	emake -j1
}

src_install() {

	emake -j1 PREFIX="${D}/usr" install
	for u in data; do
	    if use $u; then
	        emake -j1 PREFIX="${D}/usr" install_$u
	    fi
	done
}

pkg_postinst() {

	xdg_icon_cache_update
}
