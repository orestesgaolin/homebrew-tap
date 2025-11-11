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
                    when "slack_cli_macos" then "455e9f3d2b1d0fc8286510e9198503226c8c215af65ee210fcd9e752fbaefa93"
                    when "slack_cli_macos_x86" then "dad645b21a82f703545458aa2a782eb0bedf8b4691e6157a16ac9c26c2c7592b"
                    when "slack_cli_linux" then "fdf53232d9fdf8fb8e4d473cf93fca5b1eb6239de7bda92e335028d36aa031f2"
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