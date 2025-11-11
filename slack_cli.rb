require "yaml"

class SlackCli < Formula
  desc "A simple opinionated CLI to send messages to Slack."
  homepage "https://github.com/orestesgaolin/dart_utilities"
  url "https://github.com/orestesgaolin/dart_utilities/archive/refs/tags/slack_cli-v0.2.2.tar.gz"
  sha256 "7fe7967e750305f5bf5ef49133f82cbc939c4e2641434d70a0708a98746d0722"
  license "MIT"

  def install
    binary_name = case OS.mac?
                  when true
                    Hardware::CPU.intel? ? "slack_cli_macos_x86" : "slack_cli_macos"
                  else
                    OS.linux? ? "slack_cli_linux" : "slack_cli.exe"
                  end
                  
    binary_url = "https://github.com/orestesgaolin/dart_utilities/releases/download/slack_cli-v0.2.2/#{binary_name}"
    binary_sha256 = case binary_name
                    when "slack_cli_macos" then ""
                    when "slack_cli_macos_x86" then ""
                    when "slack_cli_linux" then ""
                    when "slack_cli.exe" then ""
                    end

    # Use full path to avoid conflicts
    system "curl", "-L", binary_url, "-o", "#{buildpath}/slack_cli_bin"
    chmod 0555, "#{buildpath}/slack_cli_bin"
    bin.install "#{buildpath}/slack_cli_bin" => "slack_cli"
  end

  test do
    system "#{bin}/slack_cli", "--version"
  end
end