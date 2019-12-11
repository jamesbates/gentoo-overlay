# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

MY_PN="indi"

inherit cmake-utils eutils

DESCRIPTION="ZWO ASI SDK"
HOMEPAGE="http://www.indilib.org/"
SRC_URI="https://github.com/indilib/${MY_PN}-3rdparty/archive/v${PV}.tar.gz -> ${MY_PN}-3rdparty-${PV}.tar.gz"

LICENSE="LGPL-2.1+ BSD GPL-2+ LGPL-2+"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~arm ~arm64"

DEPEND=""
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_PN}-3rdparty-${PV}/libasi"

