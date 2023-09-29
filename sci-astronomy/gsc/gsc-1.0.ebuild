# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake-utils

DESCRIPTION="General Star Catalog (needed for INDI CCD simulator)"
HOMEPAGE=""
SRC_URI="https://github.com/jamesbates/gentoo-overlay/raw/master/sci-astronomy/${PN}/files/gsc_${PV}.orig.tar.gz"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~arm ~arm64"

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""
