{ sources ? import ./sources.nix }:
let
  pkgs =
    import sources.nixpkgs { overlays = [ (import sources.nixpkgs-mozilla) ]; };

  # Things seem to work with:
  #
  # * Rust 1.46.0 (04488afe3 2020-08-24)
  # * Rust 1.44.0-nightly from 12 April 2020.
  # * Rust 1.45.0-nightly from 12 May 2020.
  # * Rust 1.46.0-nightly from 12 June 2020.
  # * Rust 1.46.0-nightly from 19 June 2020 (e55d3f9c5 2020-06-18)
  #
  # It does not work with:
  #
  # * Rust 1.46.0-nightly from 20 June 2020 (2d8bd9b74 2020-06-19).
  # ..
  # * Rust 1.51-nightly from 5 Jan 2021 (61f5a0092 2021-01-04)
  #
  # The non-working versions might be related to https://github.com/rust-lang/rust/pull/70740/ ??
  #
  # Note that the working versions show:
  #
  # crayon-init-04488afe3: ELF 64-bit LSB executable, x86-64, version 1 (SYSV), statically linked, BuildID[sha1]=7bb595e849b09a7323bd5bd2b626a640024e950d, with debug_info, not stripstripped
  # crayon-init-e55d3f9c5: ELF 64-bit LSB executable, x86-64, version 1 (SYSV), statically linked, with debug_info, not stripped
  #
  # But the non-working versions show:
  #
  # crayon-init-2d8bd9b74: ELF 64-bit LSB shared object, x86-64, version 1 (SYSV), dynamically linked, interpreter /nix/store/33idnvrkvfgd5lsx2pwgwwi955adl6sk-glibc-2.31/lib/ld-linux-x86-64.so.2, with debug_info, not stripped
  #
  # Interestingly, a non-Nix release version rustc 1.49.0 (e1884a8e3 2020-12-29) does work:
  #
  # target/x86_64-unknown-linux-musl/release/crayon-init: ELF 64-bit LSB executable, x86-64, version 1 (SYSV), statically linked, BuildID[sha1]=9405f5c9ad85b729d8c80e4bb98933456b6adef7, with debug_info, not stripped

  channel = "nightly";
  date = "2020-06-19";

  targets = [ "x86_64-unknown-linux-musl" ];
  chan = pkgs.rustChannelOfTargets channel date targets;

in
chan
