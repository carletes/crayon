let
  sources = import ./nix/sources.nix;
  rust = import ./nix/rust.nix { inherit sources; };
  pkgs = import sources.nixpkgs { };
in
pkgs.mkShell {
  buildInputs = [
    pkgs.bc
    pkgs.bison
    pkgs.e2fsprogs
    pkgs.flex
    pkgs.gnumake
    pkgs.gnutar
    pkgs.libelf
    pkgs.ncurses
    pkgs.pkg-config
    pkgs.qemu
    pkgs.syslinux
    pkgs.utillinuxCurses
    pkgs.wget

    rust

    pkgs.bashInteractive
  ];

  SYSLINUX_MBR_PATH = "${pkgs.syslinux}/share/syslinux/mbr.bin";
}
