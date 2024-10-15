require "yaml"

class ChangelogCli < Formula
  desc "A simple opinionated CLI to generate changelog based on the conventional commit history."
  homepage "https://github.com/orestesgaolin/dart_utilities"
  url "https://github.com/orestesgaolin/dart_utilities/archive/refs/tags/changelog_cli-v0.2.0.tar.gz"
  sha256 "02e1075cb133ec50147adaec7492fe5e92e6db86ebec471359a8e39384892806"
  license "MIT"

  depends_on "dart-lang/dart/dart" => :build

  def install
    # Tell the pub server where these installations are coming from.
    ENV["PUB_ENVIRONMENT"] = "homebrew:changelog_cli"

    # Change directories into the changelog_cli package directory.
    Dir.chdir('changelog_cli')

    system _dart/"dart", "pub", "get"
  
    _install_script_snapshot

    chmod 0555, "#{bin}/changelog_cli"
  end

  private

  def _dart
    @_dart ||= Formula["dart-lang/dart/dart"].libexec/"bin"
  end

  def _version
    @_version ||= YAML.safe_load(File.read("pubspec.yaml"))["version"]
  end

  def _install_script_snapshot
    system _dart/"dart", "compile", "jit-snapshot",
           "-Dversion=#{_version}",
           "-o", "changelog_cli.dart.app.snapshot",
           "bin/changelog_cli.dart"
    lib.install "changelog_cli.dart.app.snapshot"
    
    cp _dart/"dart", lib

    (bin/"changelog_cli").write <<~SH
      #!/bin/sh
      exec "#{lib}/dart" "#{lib}/changelog_cli.dart.app.snapshot" "$@"
    SH
  end
end