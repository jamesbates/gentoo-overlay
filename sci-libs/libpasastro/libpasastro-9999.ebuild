# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit eutils git-r3

DESCRIPTION="Interface to standard astronomy libraries for use from Pascal programs"
HOMEPAGE=""
EGIT_REPO_URI="https://github.com/pchev/${PN}.git"
LICENSE="GPL-2+"
SLOT="0"
IUSE=""

DEPEND="
	media-libs/libraw
"
RDEPEND="${DEPEND}"
BDEPEND=""

src_install() {
	dolib.so getdss/libpasgetdss.so.* plan404/libpasplan404.so.* wcs/libpaswcs.so.* raw/libpasraw.so.*
	dodoc changelog copyright README.md
}

pkg_postinst() {

	/sbin/ldconfig
}
