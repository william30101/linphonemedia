silk_version = 1.0.9
silk_extracted_directory = SILK_SDK_SRC_v$(silk_version)
silk_flavour_dir = SILK_SDK_SRC_$(SILK_FLAVOUR)_v$(silk_version)
silk_src_dir = $(silk_extracted_directory)/$(silk_flavour_dir)
silk_lib = libSKP_SILK_SDK.a


copy-sdk:
	mkdir -p $(silk_extracted_directory)
	if [ ! -d "$(silk_src_dir)" ]; then cp -r $(abs_srcdir)/$(silk_src_dir) $(silk_src_dir); fi

# Call Skype Makefile to build the library
all-local: copy-sdk
	cd $(silk_src_dir) && $(MAKE) AS="$(AS)" AR="$(AR)" RANLIB="$(RANLIB)" CC="$(CC) $(CFLAGS)" LD="$(LD)" $(SILK_MAKE_OPTIONS) $(AM_MAKEFLAGS) lib
check-local: copy-sdk
	cd $(silk_src_dir) && $(MAKE) $(AM_MAKEFLAGS) test
clean-local: copy-sdk
	cd $(silk_src_dir) && $(MAKE) $(AM_MAKEFLAGS) clean

install-data-local: copy-sdk
	$(INSTALL) -D $(silk_src_dir)/$(silk_lib) $(DESTDIR)$(prefix)/lib/$(silk_lib)

