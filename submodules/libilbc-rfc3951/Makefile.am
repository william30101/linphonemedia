ACLOCAL_AMFLAGS = -I m4

SUBDIRS = downloads src pkgconfig man 

EXTRA_DIST= libilbc-rfc3951.spec.in libilbc-rfc3951.spec

rpm:
	$(MAKE) dist
	TAR_OPTIONS=--wildcards rpmbuild -ta --clean --rmsource --rmspec $(PACKAGE)-$(VERSION).tar.gz

