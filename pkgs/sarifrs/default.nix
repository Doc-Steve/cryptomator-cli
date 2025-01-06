{
  lib,
  fetchFromGitHub,
  rustPlatform,
  libxcb,
}:

rustPlatform.buildRustPackage rec {
  pname = "sarif-rs";
  version = "v0.7.0";

  src = fetchFromGitHub {
    owner = "psastras";
    repo = "sarif-rs";
    rev = "shellcheck-sarif-" + version;
    sha256 = "sha256-x4UdeZQy0DjaIYJcNII40NHObJQ69VedgckFE7JTHGA=";
  };
  cargoHash = "sha256-OhR1pUo8oSd8zYO/lqHTyYG24j+PA8Mkq5U2m1hfTfE=";

  # build inputs
  buildInputs = [
    libxcb
  ];

  # disable checks
  doCheck = false;

  # metadata
  meta = with lib; {
    homepage = "https://github.com/psastras/sarif-rs";
    description = "A group of Rust projects for interacting with the SARIF format ";
    license = licenses.mit;
    platforms = platforms.linux;
    maintainers = with maintainers; [ ];
  };
}
