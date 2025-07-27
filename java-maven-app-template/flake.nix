# ~/nix-templates/java-maven-app-template/flake.nix
{
  description = "A Java/Maven development environment.";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in
      {
        devShells.default = pkgs.mkShell {
          name = "java-dev-shell";

          packages = with pkgs; [
            jdk17
            maven
          ];
        };
      }
    );
}