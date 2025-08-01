{
  description = "A collection of Nix flake templates.";

  # 依存する他の flake を指定
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  # flake が提供するアウトプットを定義
  outputs = { self, nixpkgs, flake-utils }:
    let
      # 各システムに対応した pkgs を取得するヘルパー関数を定義
      # これは、各システムに依存するアウトプット (例: devShells) を記述する際に使います。
      pkgsFor = system: import nixpkgs {
        inherit system;
        # 他のオーバーレイなどが必要な場合はここに追加
      };
    in
    {
      # --- テンプレートの定義 ---
      # テンプレートは、outputs のトップレベルに直接定義する必要があります。
      # eachDefaultSystem の中には含めないでください。
      templates = {
        java-maven-app-template = {
          description = "A simple Java Maven application template.";
          path = ./java-maven-app-template;
        };
      };

      # --- 開発シェル (devShell) の定義 ---
      # devShells など、システムに依存する設定は eachDefaultSystem を使って記述します。
      # これは、テンプレートそのものではなく、このリポジトリ自体の開発環境を定義するものです。
      devShells = flake-utils.lib.eachDefaultSystem (system:
        let
          pkgs = pkgsFor system;
        in
        {
          default = pkgs.mkShell {
            name = "general-nix-dev-shell";
            packages = with pkgs; [
              jdk17
              maven
            ];
          };
        }
      );
    };
}