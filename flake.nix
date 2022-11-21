{
  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs = { nixpkgs, flake-utils, ... }: flake-utils.lib.eachDefaultSystem (system:
    let pkgs = nixpkgs.legacyPackages.${system}; in
    with pkgs; {
      devShell = mkShell {
        name = "ascn";
        buildInputs = [
          ansible
          (google-cloud-sdk.withExtraComponents [
            google-cloud-sdk.components.kubectl
          ])
          (python3.withPackages (p: with p; [
            ansible
            requests
            google-auth
            kubernetes
          ]))
        ];
      };
    });
}
