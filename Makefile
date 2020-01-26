LINUX_VERSION = 5.4.14
LINUX_SRC_DIR = linux-$(LINUX_VERSION)
LINUX_TARBALL = $(LINUX_SRC_DIR).tar.xz
LINUX_SRC_URL = https://cdn.kernel.org/pub/linux/kernel/v5.x/$(LINUX_TARBALL)

CARGO_DIR = target/x86_64-unknown-linux-musl/release
CRAYON_INIT = $(CARGO_DIR)/crayon-init

.PHONY: run

run: root.qcow2
	./run-image root.qcow2

root.qcow2: $(LINUX_SRC_DIR)/arch/x86/boot/bzImage create-root-image $(CRAYON_INIT)
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

$(CRAYON_INIT): crayon-bin

.PHONY: crayon-bin

crayon-bin:
	cargo build --target x86_64-unknown-linux-musl --release
