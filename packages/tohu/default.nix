{
  lib,
  stdenv,
  fetchFromSourcehut,
  pkg-config,
  pixman,
  wayland,
  neuswc,
  neuwld,
  libxcb,
  libxcb-wm,
  udev,
  libdrm,
  libinput,
  libxkbcommon,
  fontconfig,
}:
stdenv.mkDerivation {
  pname = "tohu";
  version = "unstable-2026-03-20";
  src = fetchFromSourcehut {
    owner = "~shrub900";
    repo = "tohu";
    rev = "1e300018f795c6a84990b3eda8e51fd41fb6aeaf";
    hash = "sha256-wCx1L2YJXpnueoJSZQAJbJ/W01ksw3nUuEBdHWDeqCw=";
  };

  nativeBuildInputs = [
    pkg-config
  ];

  buildInputs = [
    pixman
    wayland
    neuswc
    neuwld
    libxcb
    libxcb-wm
    udev
    libdrm
    libinput
    libxkbcommon
    fontconfig
  ];

  postPatch = ''
    substituteInPlace Makefile \
      --replace "-fcolor-diagnostics" ""
  '';

  installPhase = ''
    runHook preInstall
    mkdir -p $out/bin
    cp tohu $out/bin/tohu
    runHook postInstall
  '';

  meta = {
    description = "floating window manager for swc";
    homepage = "https://git.sr.ht/~shrub900/tohu";
    license = lib.licenses.isc;
    mainProgram = "tohu";
  };
}
