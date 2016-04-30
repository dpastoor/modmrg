SHELL := /bin/bash
LIBDIR=$HOME/Rlibs/lib
PACKAGE=modmrg
VERSION=$(shell grep Version rdev/DESCRIPTION |awk '{print $$2}')
TARBALL=${PACKAGE}_${VERSION}.tar.gz
PKGDIR=rdev/
CHKDIR=Rchecks



all:
	make doc
	make build
	make install

.PHONY: doc
doc:
	Rscript makescripts/doc_mrgsolve.R

build:
	R CMD build --md5 $(PKGDIR)

qbuild:
	R CMD build --no-build-vignettes $(PKGDIR)

install:
	R CMD INSTALL --install-tests ${TARBALL}

check:
	make doc
	make build
	R CMD CHECK ${TARBALL} -o ${CHKDIR}

ucheck:
	R CMD check ${TARBALL} -o ${CHKDIR}

test:
	R CMD INSTALL ${PKGDIR}
	Rscript makescripts/test.R

.PHONY: tests
tests:
	Rscript makescripts/tests.R

