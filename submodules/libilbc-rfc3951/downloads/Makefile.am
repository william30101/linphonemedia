# here are the file names and urls for the technical specification
technical_spec = rfc3951.txt
success_marker = ../src/iLBC_define.h
BUILT_SOURCES = $(success_marker)

# cleaning up in ../src is necessary because the awk script appends
$(success_marker): $(technical_spec)
	cd ../src; rm *.c *.h &> /dev/null; $(AWK) -f $(abs_srcdir)/extract-cfile.awk \
		$(CURDIR)/$< > /dev/null

DISTCLEANFILES = $(BUILT_SOURCES)
