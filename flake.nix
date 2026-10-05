{
  description = "NDgpu development environment (Nix Python and uv)";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/b6c8664de9b6cc07fe5666a29f91884ba81197c4";

  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
    in {
      devShells.${system}.default = pkgs.mkShell {
        packages = [ pkgs.python313 pkgs.uv ];
        shellHook = ''
          export UV_PYTHON="${pkgs.python313}/bin/python3.13"
          export UV_PYTHON_DOWNLOADS=never
          export UV_CACHE_DIR="$PWD/.cache/uv"
          export PYTHONNOUSERSITE=1
          export LD_LIBRARY_PATH="/run/opengl-driver/lib:${pkgs.lib.makeLibraryPath [ pkgs.stdenv.cc.cc.lib pkgs.zlib ]}''${LD_LIBRARY_PATH:+:$LD_LIBRARY_PATH}"
          export CUPY_CACHE_DIR="$PWD/.cache/cupy"
        '';
      };
    };
}
