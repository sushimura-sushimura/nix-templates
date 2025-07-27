# ~/nix-templates/flake.nix
{
  description = "My personal Nix Flake templates.";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    # flake-utils はテンプレートの各システム対応のために必要です
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    # flake-utils を使って、各システムに対するテンプレートを定義します
    # ここでは便宜上、templates はシステムに依存しないものとして扱います
    # 厳密には templates はシステム属性を持つべきですが、
    # その場合テンプレートのパス指定が煩雑になるため、今回はシンプルに定義します。
    # (もし厳密なシステム依存テンプレートが必要な場合は、
    #  flake-utils.lib.eachDefaultSystem を outputs の外で定義し、
    #  templates = { ... } と直接記述します)
    {
      # ここでテンプレートを定義します
      templates = {
        # Next.js アプリのテンプレート
        nextjs-app = {
          description = "A basic Next.js app development environment.";
          # 'path' はテンプレートの元となるディレクトリを指定します
          # このディレクトリの内容が 'nix flake new' でコピーされます
          path = ./nextjs-app-template;
        };

        # Java/Maven アプリのテンプレート
        java-maven-app = {
          description = "A basic Java/Maven development environment.";
          path = ./java-maven-app-template;
        };
      };
    };
}