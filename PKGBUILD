# Maintainer: Andre Mikulec <Andre_Mikulec@Hotmail.com>
_realname=postgres-plr
pkgbase=${_realname}
pkgname="${_realname}"
pkgver=1.0.0
pkgrel=1
pkgdesc="PL/R - PostgreSQL support for R as a procedural language (PL)"
arch=('any')
makedepends=("${MINGW_PACKAGE_PREFIX}-gcc"
             "curl"
             "perl"
             "git"
             "flex"
             "bison"
             "make")

license=("GPL")

export PGSOURCE=$(cygpath -u "${PGSOURCE}")
export PLRSOURCE=$(cygpath -u "${PLRSOURCE}")
export PLRMAKEFILESOURCE=$(cygpath -u "${PLRMAKEFILESOURCE}")
export PGBUILD=$(cygpath -u "${PGBUILD}")
export PGINSTALL=$(cygpath -u "${PGINSTALL}")
export R_HOME=$(cygpath -u "${R_HOME}")
export ZIPTMP=$(cygpath -u "${ZIPTMP}")

package() {

  msg2 "BEGIN APPVEYOR BUILD_SCRIPT"

  # prepare to build postgres
  #
  mkdir ${PGBUILD}

  # build postgres
  #
  msg2 "BEGIN POSTGRESQL BUILD"
  cd ${PGBUILD}
  ${PGSOURCE}/configure --prefix=${PGINSTALL}
  cd -
  msg2 "END   POSTGRESQL BUILD"

  # Links from the "build environment" back to the "source environment".
  # Links "abs_top_builddir" back to the "abs_top_srcdir" directory.
  #
  msg2 "PGBUILD to PGSOURCE links follow"
  cat  "${PGBUILD}/src/Makefile.global" | grep '^abs'
  cat  "${PGBUILD}/src/Makefile.global" | grep '^CPPFLAGS'
  #
  # If these are wrong then re-run configure !!!
  # If these are wrong then re-run configure !!!
  # If these are wrong then re-run configure !!!

  # copy the PLR code and the correct Makefile to PGSOURCE
  #
  msg2 "BEGIN PLR FILES SETUP"
  mkdir -p                                      ${PGSOURCE}/contrib/plr    
  cp -r    ${PLRSOURCE}/*                       ${PGSOURCE}/contrib/plr
  rm                                            ${PGSOURCE}/contrib/plr/Makefile
  cp       ${PLRMAKEFILESOURCE}/Makefile        ${PGSOURCE}/contrib/plr

  # copy the correct Makefile to PGBUILD
  #
  mkdir -p                                      ${PGBUILD}/contrib/plr
  cp       ${PLRMAKEFILESOURCE}/Makefile        ${PGBUILD}/contrib/plr
  mkdir -p                                      ${PGBUILD}/contrib/plr/sql
  mkdir -p                                      ${PGBUILD}/contrib/plr/expected
  msg2 "echo END  PLR FILES SETUP"

  # note: build OLD/CUR R PLR uses the Makefile that uses R_HOME and R_ARCH

  # build OLD R PLR
  #

  msg2 "BEGIN OLD R PLR BUILD"
  export R_HOME_ORIG=${R_HOME}
  export R_HOME=${R_HOME}OLD
  cd ${PGBUILD}/contrib/plr
  make
  make install
  make clean
  cd -
  export R_HOME=${R_HOME_ORIG}
  msg2 "END  OLD R PLR BUILD"


  # save OLD R PLR in a zip
  #
  msg2 "BEGIN SAVE OLD PLR"
  mkdir -p                                                ${ZIPTMP}
  cp       ${PLRSOURCE}/LICENSE                           ${ZIPTMP}/PLR_LICENSE
  mkdir -p                                                ${ZIPTMP}/lib
  cp -r    ${PGINSTALL}/lib/postgresql/plr*.*             ${ZIPTMP}/lib
  mkdir -p                                                ${ZIPTMP}/share
  cp -r    ${PGINSTALL}/share/postgresql/extension/plr*.* ${ZIPTMP}/share
  export ZIP=${MSYSTEM}_PG_${PG_GIT_BRANCH}_R_${R_OLD_VERSION}_PLR_${PLR_TAG}.tar.gz
  cd ${ZIPTMP}
  tar -zcvf ${APPVEYOR_BUILD_FOLDER}/${ZIP} *
  cd -
  msg2 "END   SAVE OLD PLR"
  #
  # clean up
  #
  rm -r ${ZIPTMP}
  rm -r ${PGINSTALL}/lib/postgresql/plr*.*
  rm -r ${PGINSTALL}/share/postgresql/extension/plr*.*
  msg2 "echo END   SAVE OLD PLR"

  # build CUR R PLR
  #
  msg2 "BEGIN CUR R PLR BUILD"
  export R_HOME_ORIG=${R_HOME}
  export R_HOME=${R_HOME}CUR
  cd ${PGBUILD}/contrib/plr
  make
  make install
  make clean
  cd -
  export R_HOME=${R_HOME_ORIG}
  msg2 "END  CUR R PLR BUILD"

  # save CUR R PLR in a zip
  #
  msg2 "BEGIN SAVE CUR PLR"
  mkdir -p                                                ${ZIPTMP}
  cp       ${PLRSOURCE}/LICENSE                           ${ZIPTMP}/PLR_LICENSE
  mkdir -p                                                ${ZIPTMP}/lib
  cp -r    ${PGINSTALL}/lib/postgresql/plr*.*             ${ZIPTMP}/lib
  mkdir -p                                                ${ZIPTMP}/share
  cp -r    ${PGINSTALL}/share/postgresql/extension/plr*.* ${ZIPTMP}/share
  export ZIP=${MSYSTEM}_PG_${PG_GIT_BRANCH}_R_${R_CUR_VERSION}_PLR_${PLR_TAG}.tar.gz
  cd ${ZIPTMP}
  tar -zcvf ${APPVEYOR_BUILD_FOLDER}/${ZIP} *
  cd -
  msg2 "END   SAVE CUR PLR"
  #
  # clean up
  #
  rm -r ${ZIPTMP}
  rm -r ${PGINSTALL}/lib/postgresql/plr*.*
  rm -r ${PGINSTALL}/share/postgresql/extension/plr*.*
  msg2 "echo END   SAVE CUR PLR"

}