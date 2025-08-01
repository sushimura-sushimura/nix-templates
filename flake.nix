{
  description = "A collection of Nix flake templates";

  inputs = {
    # 既存のinputsはそのまま
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in
      {
        # ここにテンプレートを定義します
        templates = {
          # java-maven-app-templateという名前でテンプレートを公開
          java-maven-app-template = {
            description = "A simple Java Maven application template.";
            path = ./java-maven-app-template;
          };
          # 他のテンプレートもここに追加できます
          nextjs-app-template = {
            description = "A Next.js application template.";
            path = ./nextjs-app-template;
          };
        };

        # devShellsなどの他のアウトプットはここに追加できます
        devShells.default = pkgs.mkShell {
          # ...
        };
      }
    );
}