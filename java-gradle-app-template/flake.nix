# ~/nix-templates/java-gradle-app-template/flake.nix
{
  description = "A Java/Gradle development environment.";

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
          name = "java-gradle-dev-shell";

          packages = with pkgs; [
            jdk17 # Java Development Kit バージョン17 (必要に応じて変更)
            gradle # Gradle ビルドツール
          ];

          shellHook = ''
            echo "✅ Nix開発環境がロードされました！ (Java/Gradle, システム: ${system})"
            echo "✨ Gradleコマンド (e.g., 'gradle build', 'gradle run') が利用可能です。"
          '';
        };
      }
    );
}