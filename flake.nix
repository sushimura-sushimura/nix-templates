{
  # この flake の説明
  description = "A collection of Nix flake templates for various projects.";

  # 依存する他の flake を指定
  inputs = {
    # Nixpkgs を指定。nixpkgs-unstable ブランチを使う
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    
    # flake-utils を使って、各システムに対応した設定を簡単に記述する
    flake-utils.url = "github:numtide/flake-utils";
  };

  # flake が提供するアウトプットを定義
  outputs = { self, nixpkgs, flake-utils }:
    let
      # devShells などのために、各システムに対応した pkgs を取得するヘルパー関数
      pkgsFor = system: nixpkgs.legacyPackages.${system};
    in
    {
      # --- ここが最も重要な修正点です ---
      # テンプレートは、outputs のトップレベルに直接定義します。
      # 各システムに依存しないため、eachDefaultSystem の中には含めません。
      templates = {
        # java-maven-app-template という名前でテンプレートを公開
        java-maven-app-template = {
          description = "A simple Java Maven application template.";
          # このテンプレートの実体があるディレクトリを指定
          # flake.nix と同じ階層にある java-maven-app-template ディレクトリを指す
          path = ./java-maven-app-template;
        };

        # 他のテンプレートも同様にここに追加します
        nextjs-app-template = {
          description = "A Next.js application template.";
          path = ./nextjs-app-template;
        };
      };

      # --- devShells は各システムに対応させて定義 ---
      # devShells など、システムに依存する設定は eachDefaultSystem を使って記述します。
      devShells = flake-utils.lib.eachDefaultSystem (system:
        let
          pkgs = pkgsFor system;
        in
        {
          default = pkgs.mkShell {
            # シェルに入ったときに必要なツールをここに記述
            name = "general-nix-dev-shell";
            packages = with pkgs; [
              # Git や curl など、どのテンプレートでも共通して使うツール
              git
              curl
              
              # その他の一般的なツール
              # ...
            ];
            
            # シェルが起動したときに実行されるスクリプト (任意)
            shellHook = ''
              echo "Welcome to the Nix development shell!"
            '';
          };
        }
      );
    };
}