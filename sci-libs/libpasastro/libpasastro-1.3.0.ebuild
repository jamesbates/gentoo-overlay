# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit eutils

DESCRIPTION="Interface to standard astronomy libraries for use from Pascal programs"
HOMEPAGE=""
SRC_URI="https://github.com/pchev/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~arm ~arm64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""

src_install() {
	dolib.so getdss/libpasgetdss.so.* plan404/libpasplan404.so.* wcs/libpaswcs.so.*
	dodoc changelog copyright README.md
}

pkg_postinst() {

	/sbin/ldconfig
}
