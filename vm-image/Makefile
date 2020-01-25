LINUX_VERSION = 5.4.14
LINUX_SRC_DIR = linux-$(LINUX_VERSION)
LINUX_TARBALL = $(LINUX_SRC_DIR).tar.xz
LINUX_SRC_URL = https://cdn.kernel.org/pub/linux/kernel/v5.x/$(LINUX_TARBALL)

root.qcow2: $(LINUX_SRC_DIR)/arch/x86/boot/bzImage create-root-image
	sudo ./create-root-image root.qcow2 $(LINUX_SRC_DIR)/arch/x86/boot/bzImage

$(LINUX_SRC_DIR)/arch/x86/boot/bzImage: $(LINUX_SRC_DIR)/.config $(LINUX_SRC_DIR)/Makefile
	make -C $(LINUX_SRC_DIR) -j $$(nproc)

$(LINUX_SRC_DIR)/.config: dot-config
	mkdir -p $(LINUX_SRC_DIR)
	cp dot-config $(LINUX_SRC_DIR)/.config

$(LINUX_SRC_DIR)/Makefile: $(LINUX_TARBALL)
	tar xJf $(LINUX_TARBALL)
	touch $(LINUX_SRC_DIR)/Makefile

$(LINUX_TARBALL):
	wget -O $(LINUX_TARBALL) $(LINUX_SRC_URL)
