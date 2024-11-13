require "yaml"

class SlackCli < Formula
  desc "A simple opinionated CLI to send messages to Slack."
  homepage "https://github.com/orestesgaolin/dart_utilities"
  url "https://github.com/orestesgaolin/dart_utilities/archive/refs/tags/slack_cli-v0.2.1.tar.gz"
  sha256 "2d9a5b8ba6e9234d45044fd388c9fcb8973a5f6c153e7ed2357d1f0bf2d3eb4e"
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