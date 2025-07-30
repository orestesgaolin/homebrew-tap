class ChangelogCli < Formula
  desc "A simple opinionated CLI to generate changelog based on the conventional commit history."
  homepage "https://github.com/orestesgaolin/dart_utilities"
  url "https://github.com/orestesgaolin/dart_utilities/archive/refs/tags/changelog_cli-v0.6.0.tar.gz"
  sha256 "77d7c67e5aa06c066c0f70313df322f255d1c0bcb8c3d4b4baef0d3ce961023f"
  license "MIT"

  def install
    binary_name = case OS.mac?
                  when true
                    Hardware::CPU.intel? ? "changelog_cli_macos_x86" : "changelog_cli_macos"
                  else
                    OS.linux? ? "changelog_cli_linux" : "changelog_cli.exe"
                  end
                  
    binary_url = "https://github.com/orestesgaolin/dart_utilities/releases/download/changelog_cli-v0.6.0/#{binary_name}"
    binary_sha256 = case binary_name
                    when "changelog_cli_macos" then "c418bba1282b9869215653f0f069d48b670da65b5f0bc447ef2c0b931a7ba33f"
                    when "changelog_cli_macos_x86" then "ff9a9620759e4283403bbcc2ca970f5be5d57b9efeae1a7fe3cea4713b48eec9"
                    when "changelog_cli_linux" then "8380fca842b5b91f02f9da42a9d10aaa669b9d32fddc30d3b5804bd552cdf5b4"
                    when "changelog_cli.exe" then "873d6416d13e107b8f08624ec817f2f7cea74f827b723f1c7d301844fc84f10e"
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
