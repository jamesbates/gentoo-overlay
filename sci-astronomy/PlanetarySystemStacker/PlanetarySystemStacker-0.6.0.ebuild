# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Planetary System Stacker dependencies"
HOMEPAGE=""
SRC_URI="https://github.com/Rolf-Hempel/${PN}/archive/V${PV}.tar.gz -> ${P}.tar.gz"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="
	sci-libs/scipy
	dev-python/astropy
	dev-python/matplotlib
	media-libs/opencv
	dev-python/psutil
	sci-libs/scikits_image
	sci-libs/mkl-rt
"
RDEPEND="${DEPEND}"
BDEPEND=""
