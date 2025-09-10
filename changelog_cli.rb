class ChangelogCli < Formula
  desc "A simple opinionated CLI to generate changelog based on the conventional commit history."
  homepage "https://github.com/orestesgaolin/dart_utilities"
  url "https://github.com/orestesgaolin/dart_utilities/archive/refs/tags/changelog_cli-v0.8.0.tar.gz"
  sha256 "8a758b8a2db7081d071489a59aabf1402377573d3892c06dd3738060e1496c55"
  license "MIT"

  def install
    binary_name = case OS.mac?
                  when true
                    Hardware::CPU.intel? ? "changelog_cli_macos_x86" : "changelog_cli_macos"
                  else
                    OS.linux? ? "changelog_cli_linux" : "changelog_cli.exe"
                  end
                  
    binary_url = "https://github.com/orestesgaolin/dart_utilities/releases/download/changelog_cli-v0.8.0/#{binary_name}"
    binary_sha256 = case binary_name
                    when "changelog_cli_macos" then "e76ecd293b8a7ee4a3b7f7701ff37a015c94c923ed0b02380c36ff4669fb9338"
                    when "changelog_cli_macos_x86" then "2a279ee15b2a2cb27d2dd5ec4db2ba241c61f0cdf78b035f3a9224930c0e2a81"
                    when "changelog_cli_linux" then "53bf51768610b9642574165e3ae7da8fbf0213393db6c4ad5a3a7760d507443d"
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
