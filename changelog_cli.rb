class ChangelogCli < Formula
  desc "A simple opinionated CLI to generate changelog based on the conventional commit history."
  homepage "https://github.com/orestesgaolin/dart_utilities"
  url "https://github.com/orestesgaolin/dart_utilities/archive/refs/tags/changelog_cli-v0.7.0.tar.gz"
  sha256 "b448d137d4c8512f65e622913adc1d792c75e7fb99728bd0e1c473515ba926cf"
  license "MIT"

  def install
    binary_name = case OS.mac?
                  when true
                    Hardware::CPU.intel? ? "changelog_cli_macos_x86" : "changelog_cli_macos"
                  else
                    OS.linux? ? "changelog_cli_linux" : "changelog_cli.exe"
                  end
                  
    binary_url = "https://github.com/orestesgaolin/dart_utilities/releases/download/changelog_cli-v0.7.0/#{binary_name}"
    binary_sha256 = case binary_name
                    when "changelog_cli_macos" then "8d76ce548f89a894b545adfff5e832857d9da7a734ae6222986e36a5152b68fa"
                    when "changelog_cli_macos_x86" then "949f84cbf105fa010c44c197019831100959f55b2619b72c5a8e953570d50b36"
                    when "changelog_cli_linux" then "2f4011741f73e2fbb99188d361f5e615cd9372a022cf5f5c5febd4e2f021f67a"
                    when "changelog_cli.exe" then ""
                    end

    # Use full path to avoid conflicts
    system "curl", "-L", binary_url, "-o", "#{buildpath}/changelog_cli_bin"
    chmod 0555, "#{buildpath}/changelog_cli_bin"
    bin.install "#{buildpath}/changelog_cli_bin" => "changelog_cli"
  end

  test do
    system "#{bin}/changelog_cli", "--version"
  end
end
