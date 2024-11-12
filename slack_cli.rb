require "yaml"

class SlackCli < Formula
  desc "A simple opinionated CLI to send messages to Slack."
  homepage "https://github.com/orestesgaolin/dart_utilities"
  url "https://github.com/orestesgaolin/dart_utilities/archive/refs/tags/slack_cli-v0.2.0.tar.gz"
  sha256 "a4e1b2f9eb6cb26394e6b3f40008601ba8d6bf857a429dbb7bd08c86f8018f7b"
  license "MIT"

  depends_on "dart-lang/dart/dart" => :build

  def install
    # Tell the pub server where these installations are coming from.
    ENV["PUB_ENVIRONMENT"] = "homebrew:slack_cli"

    # Change directories into the slack_cli package directory.
    Dir.chdir('slack_cli')

    system _dart/"dart", "pub", "get"
  
    _install_script_snapshot

    chmod 0555, "#{bin}/slack_cli"
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
           "-o", "slack_cli.dart.app.snapshot",
           "bin/slack_cli.dart"
    lib.install "slack_cli.dart.app.snapshot"
    
    cp _dart/"dart", lib

    (bin/"slack_cli").write <<~SH
      #!/bin/sh
      exec "#{lib}/dart" "#{lib}/slack_cli.dart.app.snapshot" "$@"
    SH
  end
end