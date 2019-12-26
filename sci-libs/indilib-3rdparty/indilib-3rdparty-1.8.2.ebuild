# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake-utils eutils udev

DESCRIPTION="INDI driver for the ZWO ASI Cameras"
HOMEPAGE="http://www.indilib.org/"
SRC_URI="https://github.com/indilib/indi-3rdparty/archive/v${PV}.tar.gz -> indi-3rdparty-${PV}.tar.gz"
PATCHES=(
	"${FILESDIR}"/eqmod-checklimits.patch
	"${FILESDIR}"/findaravis.patch
	"${FILESDIR}"/dsi-udev-install.patch
)

LICENSE="LGPL-2.1+ BSD GPL-2+ LGPL-2+"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~arm ~arm64"
IUSE="
	indi_drivers_apogee
	indi_drivers_armadillo
	indi_drivers_asicam
	indi_drivers_astromechfoc
	indi_drivers_atik
	indi_drivers_avalon
	indi_drivers_beefocus
	indi_drivers_cloudwatcher
	indi_drivers_dreamfocuser
	indi_drivers_dsi
	indi_drivers_duino
	indi_drivers_eqmod
	indi_drivers_ffmv
	indi_drivers_fishcamp
	indi_drivers_fli
	indi_drivers_gige
	indi_drivers_gphoto
	indi_drivers_gpsd
	indi_drivers_gpsnmea
	indi_drivers_inovaplx
	indi_drivers_limesdr
	indi_drivers_maxdome
	indi_drivers_mgen
	indi_drivers_mi
	indi_drivers_nexdome
	indi_drivers_nightscape
	indi_drivers_nse
	indi_drivers_qhy
	indi_drivers_qsi
	indi_drivers_rtlsdr
	indi_drivers_sbig
	indi_drivers_shelyak
	indi_drivers_skywalker
	indi_drivers_spectracyber
	indi_drivers_ssag
	indi_drivers_starbook
	indi_drivers_sx
	indi_drivers_toupbase
	indi_drivers_webcam
"

REQUIRED_USE="|| ( $IUSE )"

DEPEND="
	sci-libs/indilib
	virtual/pkgconfig
	indi_drivers_apogee? ( sci-libs/indilib-3rdparty-libs[indi_drivers_apogee] sci-libs/cfitsio sys-libs/zlib )
	indi_drivers_asicam? ( sci-libs/indilib-3rdparty-libs[indi_drivers_asicam] sci-libs/cfitsio sys-libs/zlib >=virtual/libusb-1 )
	indi_drivers_astromechfoc? ( sys-libs/zlib )
	indi_drivers_atik? ( sci-libs/indilib-3rdparty-libs[indi_drivers_atik] sci-libs/cfitsio sys-libs/zlib >=virtual/libusb-1 )
	indi_drivers_avalon? ( sci-libs/libnova )
	indi_drivers_dsi? ( sci-libs/cfitsio sys-libs/zlib >=virtual/libusb-1 )
	indi_drivers_eqmod? ( sci-libs/libnova sci-libs/gsl sys-libs/zlib )
	indi_drivers_ffmv? ( sci-libs/cfitsio media-libs/libdc1394 sys-libs/zlib )
	indi_drivers_fishcamp? ( sci-libs/indilib-3rdparty-libs[indi_drivers_fishcamp] sci-libs/cfitsio sys-libs/zlib )
	indi_drivers_fli? ( sci-libs/indilib-3rdparty-libs[indi_drivers_fli] sci-libs/cfitsio sys-libs/zlib )
	indi_drivers_gige? ( sci-libs/cfitsio sys-libs/zlib dev-libs/glib:2 media-video/aravis )
	indi_drivers_gphoto? ( sci-libs/cfitsio sys-libs/zlib media-libs/libgphoto2 virtual/jpeg media-libs/libraw >=virtual/libusb-1 media-libs/tiff )
	indi_drivers_gpsd? ( sci-libs/libnova sci-geosciences/gpsd sys-libs/zlib )
	indi_drivers_gpsnmea? ( sci-libs/libnova sys-libs/zlib )
	indi_drivers_inovaplx? ( sci-libs/indilib-3rdparty-libs[indi_drivers_inovaplx] sci-libs/cfitsio sys-libs/zlib )
	indi_drivers_limesdr? ( sci-libs/cfitsio net-wireless/limesuite sys-libs/zlib )
	indi_drivers_mgen? ( sci-libs/cfitsio dev-embedded/libftdi:1 sys-libs/zlib >=virtual/libusb-1 )
	indi_drivers_mi? ( sci-libs/cfitsio >=virtual/libusb-1 )
	indi_drivers_nexdome? ( sci-libs/libnova sys-libs/zlib )
	indi_drivers_nightscape? ( sci-libs/cfitsio >=virtual/libusb-1 dev-embedded/libftdi:1 )
	indi_drivers_nse? ( sci-libs/libnova sci-libs/gsl sys-libs/zlib )
	indi_drivers_qhy? ( sci-libs/indilib-3rdparty-libs[indi_drivers_qhy] sci-libs/cfitsio sys-libs/zlib >=virtual/libusb-1 )
	indi_drivers_qsi? ( sci-libs/indilib-3rdparty-libs[indi_drivers_qsi] sci-libs/cfitsio sys-libs/zlib )
	indi_drivers_rtlsdr? ( sci-libs/cfitsio sys-libs/zlib net-wireless/rtl-sdr )
	indi_drivers_sbig? ( sci-libs/indilib-3rdparty-libs[indi_drivers_sbig] sci-libs/cfitsio sys-libs/zlib >=virtual/libusb-1 )
	indi_drivers_skywalker? ( sci-libs/libnova )
	indi_drivers_spectracyber? ( sci-libs/libnova )
	indi_drivers_ssag? ( >=virtual/libusb-1 )
	indi_drivers_starbook? ( sci-libs/libnova net-misc/curl )
	indi_drivers_sx? ( sci-libs/cfitsio >=virtual/libusb-1 )
	indi_drivers_toupbase? ( sci-libs/indilib-3rdparty-libs[indi_drivers_toupbase] sci-libs/cfitsio sys-libs/zlib >=virtual/libusb-1 )
	indi_drivers_webcam? ( virtual/ffmpeg sys-libs/zlib sci-libs/cfitsio )
	!sci-libs/indilib-driver-asi
	!sci-libs/indilib-driver-eqmod
	!sci-libs/indilib-driver-gphoto
"
RDEPEND="${DEPEND}"

S="${WORKDIR}/indi-3rdparty-${PV}"

indi_driver_use() {
	echo -DWITH_"${1^^}"="$(usex indi_drivers_"$1" ON OFF)"
}

indi_drivers_config() {
	for u in $IUSE; do
	    [[ "$u" =~ ^indi_drivers_.* ]] && indi_driver_use "${u#indi_drivers_}"
	done
}

src_configure() {
	local mycmakeargs=(
		$(indi_drivers_config)
		-DRULES_INSTALL_DIR="$(get_udevdir)"/rules.d
		-Wno-dev
	)

	cmake-utils_src_configure
}

