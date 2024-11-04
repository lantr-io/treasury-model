{
  description = "Python environment with Jupyter for mathematical modeling";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        pythonEnv = pkgs.python3.withPackages (ps: with ps; [
          jupyter
          numpy
          matplotlib
          pandas
          ipykernel
        ]);
      in
      {
        devShell = pkgs.mkShell {
          buildInputs = [
            pythonEnv
            pkgs.git
          ];
          shellHook = ''
            echo "Python environment with Jupyter is ready!"
            echo "Run 'jupyter notebook' to start the notebook server"
          '';
        };
      }
    );
}