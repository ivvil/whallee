{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    utils.url = "github:numtide/flake-utils";
  };

  outputs = {
    self,
      nixpkgs,
      utils,
  }:
    utils.lib.eachDefaultSystem
      (system: let
        pkgs = import nixpkgs {
          inherit system;
        };
        libs = with pkgs; [
          libfixposix
        ];
      in {
        devShells.default = pkgs.mkShell {
          packages = with pkgs; [
            pkg-config
          ] ++ libs;

          shellHook = ''
          export LD_LIBRARY_PATH=${pkgs.lib.makeLibraryPath libs}:$LD_LIBRARY_PATH
        '';
        };
      });
}
