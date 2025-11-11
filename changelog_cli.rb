class ChangelogCli < Formula
  desc "A simple opinionated CLI to generate changelog based on the conventional commit history."
  homepage "https://github.com/orestesgaolin/dart_utilities"
  url "https://github.com/orestesgaolin/dart_utilities/archive/refs/tags/changelog_cli-v0.9.1.tar.gz"
  sha256 "14904c191355d1e3728feb82ea8c10fc1582cf39ea50f41b31c0f6b089deafd8"
  license "MIT"

  def install
    binary_name = case OS.mac?
                  when true
                    Hardware::CPU.intel? ? "changelog_cli_macos_x86" : "changelog_cli_macos"
                  else
                    OS.linux? ? "changelog_cli_linux" : "changelog_cli.exe"
                  end
                  
    binary_url = "https://github.com/orestesgaolin/dart_utilities/releases/download/changelog_cli-v0.9.1/#{binary_name}"
    binary_sha256 = case binary_name
                    when "changelog_cli_macos" then "2ef791dfeb838c1eedea0b526d2d138bd53c40da9637802ee19c1a6325181927"
                    when "changelog_cli_macos_x86" then "bc037469922a5f191b03c3c62af74908d7a3c1b3da087bc4e8ecf7dbe046db8f"
                    when "changelog_cli_linux" then "67fcab55133a0f7b750eccf930b168cdc328872cc8697b0a638f3795531b81c3"
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
