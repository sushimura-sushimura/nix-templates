# ~/nix-templates/nextjs-app-template/flake.nix
{
  description = "A basic Next.js app development environment with TypeScript and Tailwind CSS.";

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
          name = "todo-dev-shell";

          packages = with pkgs; [
            nodejs_20
            yarn
            git
          ];

          shellHook = ''
            export PATH="${pkgs.yarn}/bin:$PATH"

            echo "✅ Nix開発環境がロードされました！ (システム: ${system})"
            echo "✨ まずは 'yarn install' でJavaScriptの依存関係をインストールしましょう。"
            echo "🚀 アプリを起動するには 'yarn dev'、Storybook を起動するには 'yarn storybook' を実行してください。"
          '';
        };
      }
    );
}