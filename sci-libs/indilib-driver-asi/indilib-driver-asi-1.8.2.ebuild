# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

MY_PN="${PN%%lib-driver-**}"

inherit cmake-utils eutils

DESCRIPTION="INDI driver for the ZWO ASI Cameras"
HOMEPAGE="http://www.indilib.org/"
SRC_URI="https://github.com/${MY_PN}lib/${MY_PN}-3rdparty/archive/v${PV}.tar.gz -> ${MY_PN}-3rdparty-${PV}.tar.gz"

LICENSE="LGPL-2.1+ BSD GPL-2+ LGPL-2+"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="
	sci-libs/indilib
	sci-libs/libasi
"
DEPEND="${RDEPEND}"

S="${WORKDIR}/${MY_PN}-3rdparty-${PV}/indi-asi"

