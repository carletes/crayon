LINUX_VERSION = 5.4.14
LINUX_SRC_DIR = linux-$(LINUX_VERSION)
LINUX_TARBALL = $(LINUX_SRC_DIR).tar.xz
LINUX_SRC_URL = https://cdn.kernel.org/pub/linux/kernel/v5.x/$(LINUX_TARBALL)

$(LINUX_SRC_DIR)/XXX: $(LINUX_SRC_DIR)/.config
	make -C $(LINUX_SRC_DIR) -j $$(nproc)

$(LINUX_SRC_DIR)/.config: dot-config
	cp $< $(LINUX_SRC_DIR)/.config

$(LINUX_SRC_DIR): $(LINUX_TARBALL)
	tar xvJf $(LINUX_TARBALL)
	touch $(LINUX_SRC_DIR)

$(LINUX_TARBALL):
	wget -O $(LINUX_TARBALL) $(LINUX_SRC_URL)
