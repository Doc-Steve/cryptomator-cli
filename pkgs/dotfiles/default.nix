{ lib
, stdenv
, installShellFiles
, fetchFromGitHub
, buildGoModule
}:

buildGoModule rec {
  pname = "dotfiles-cli";
  version = "v0.3.2";

  src = fetchFromGitHub {
    owner = "PhilippHeuer";
    repo = "dotfiles-cli";
    rev = "2735e427c1bd366249b975d552f052e5d8634f25";
    sha256 = "sha256-I/UY0jaIxKZ1aC9gUy/vtxzyq4gNtUeORHtfdpvrNow=";
  };
  vendorHash = "sha256-lfCp0ngobwDgmmZHuhlStFnnj1xUHObutEnVVRC0KEo=";

  ldflags = [
    "-s"
    "-w"
    "-X main.version=${version}"
    "-X main.commit=none"
    "-X main.date=none"
    "-X main.status=clean"
  ];

  nativeBuildInputs = [
    installShellFiles
  ];

  # disable checks
  doCheck = false;

  # completions
  postInstall = ''
      # rename binary
      mv $out/bin/* $out/bin/dotfiles

      # install shell completion
      installShellCompletion --cmd dotfiles \
        --bash <($out/bin/dotfiles completion bash) \
        --fish <($out/bin/dotfiles completion fish) \
        --zsh  <($out/bin/dotfiles completion zsh)
    '';

  # metadata
  meta = with lib; {
    homepage = "https://github.com/PhilippHeuer/dotfiles-cli";
    description = "dotfiles-cli";
    license = licenses.mit;
    platforms = platforms.unix;
    maintainers = with maintainers; [ ];
    mainProgram = "dotfiles";
  };
}
