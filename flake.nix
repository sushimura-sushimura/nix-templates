{
  description = "A collection of Nix flake templates.";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  # outputs は関数として定義
  outputs = { self, nixpkgs, flake-utils }:
    let
      # devShells などを定義するためのヘルパー関数を定義
      pkgsFor = system: nixpkgs.legacyPackages.${system};
    in
    {
      # --- templates は outputs のトップレベルに配置 ---
      templates = {
        java-maven-app-template = {
          description = "A simple Java Maven application template.";
          path = ./java-maven-app-template;
        };
      };

      # --- devShells は各システムに対応させて定義 ---
      devShells = flake-utils.lib.eachDefaultSystem (system:
        let
          pkgs = pkgsFor system;
        in
        {
          default = pkgs.mkShell {
            packages = with pkgs; [
              jdk17
              maven
            ];
          };
        }
      );
    };
}