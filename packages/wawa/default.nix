{
  lib,
  stdenv,
  fetchFromCodeberg,
  pkg-config,
  wayland,
  wayland-scanner,
  wayland-protocols
}:
stdenv.mkDerivation {
  pname = "wawa";
  version = "1.0";
  src = fetchFromCodeberg {
    owner = "sewn";
    repo = "wawa";
    rev = "249f43876d05f73cc1ba9c51235a32f058478e8c";
    hash = "sha256-3fF5U4EdXgbAFF55+Etl6ZcTPGLCU804FblVJvpNe3c=";
  };

  env.NIX_CFLAGS_COMPILE = "-Wno-incompatible-pointer-types";
  
  nativeBuildInputs = [
    pkg-config
    wayland-scanner
    wayland-protocols
  ];

  buildInputs = [
    wayland
  ];

  makeFlags = [
    "PREFIX=$(out)"
  ];

  meta = {
    description = "A simple, hackable, and distinctive Wayland wallpaper setter utilizing stb_image that targets wlr-layer-shell supported compositors, featuring tiling, spreading across monitors, along with fill, fit and stretching the wallpaper, with less SLOC than your average wallpaper setter.";
    homepage = "https://codeberg.org/sewn/wawa";
    license = lib.licenses.mit;
    mainProgram = "wawa";
  };
}

  

