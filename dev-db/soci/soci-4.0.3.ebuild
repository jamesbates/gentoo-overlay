# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake

DESCRIPTION="SOCI"
HOMEPAGE="http://soci.sourceforge.net/"
SRC_URI="https://s3.amazonaws.com/rstudio-buildtools/soci-${PV}.tar.gz"
PATCHES=(
)

LICENSE="Boost-1.0"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~arm ~arm64"
IUSE=""
REQUIRED_USE=""

DEPEND="
	dev-libs/boost
	dev-db/postgresql
	dev-db/sqlite:3
"
RDEPEND="${DEPEND}"

src_configure() {
	local mycmakeargs=(
		-GNinja
		-DCMAKE_POLICY_DEFAULT_CMP0063="NEW"
		-DCMAKE_POLICY_DEFAULT_CMP0074="NEW"
		-DCMAKE_POSITION_INDEPENDENT_CODE:BOOL=true
		-DCMAKE_CXX_VISIBILITY_PRESET="$COMPILE_VISIBILITY"
		-DCMAKE_OSX_DEPLOYMENT_TARGET="10.12"
		-DSOCI_TESTS=OFF
		-DSOCI_CXX11=ON
		-DSOCI_EMPTY=OFF
		-DWITH_BOOST=ON
		-DWITH_POSTGRESQL=ON
		-DWITH_SQLITE3=ON
		-DWITH_DB2=OFF
		-DWITH_MYSQL=OFF
		-DWITH_ORACLE=OFF
		-DWITH_FIREBIRD=OFF
		-DWITH_ODBC=OFF
	)

	cmake_src_configure
}

