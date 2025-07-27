{
  description = "My personal Nix Flake templates.";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    {
      templates = {
        nextjs-app = {
          description = "A basic Next.js app development environment.";
          path = ./nextjs-app-template;
        };

        java-maven-app = {
          description = "A basic Java/Maven development environment.";
          path = ./java-maven-app-template;
        };

        java-gradle-app = {
          description = "A basic Java/Gradle development environment.";
          path = ./java-gradle-app-template;
        };
      };
    };
}