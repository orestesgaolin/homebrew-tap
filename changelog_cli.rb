class ChangelogCli < Formula
  desc "A simple opinionated CLI to generate changelog based on the conventional commit history."
  homepage "https://github.com/orestesgaolin/dart_utilities"
  # url "https://github.com/orestesgaolin/dart_utilities/archive/refs/tags/changelog_cli-v0.5.1.tar.gz"
  # sha256 "1cf8469c262791fd1ed780f0f4ca6c24835ac56abb8845efed08ea2592212c97"
  license "MIT"

  def install
    binary_name = case OS.mac?
                  when true
                    Hardware::CPU.intel? ? "changelog_cli_macos_x86" : "changelog_cli_macos"
                  else
                    OS.linux? ? "changelog_cli_linux" : "changelog_cli.exe"
                  end
                  
    binary_url = "https://github.com/orestesgaolin/dart_utilities/releases/download/changelog_cli-v0.5.1/#{binary_name}"
    binary_sha256 = case binary_name
                    when "changelog_cli_macos" then "39ea8af23356b89ba2d9deef936dc8fa3532d90353710b2793cc5f9c84925ea1"
                    when "changelog_cli_macos_x86" then "620691f7e4a5cc95249804413e28e6f57fc198890f92e72e4ad610aaa58cd7d6"
                    when "changelog_cli_linux" then "8d00fbd45ab672bebe7d632df881fd23f0cc5fd6bcd839610ba0a32197a7ff01"
                    when "changelog_cli.exe" then "74403174a30aab9040415b6b1489a067f1e2dc06c63e806e10b5ec71aee7df34"
                    end

    # Download the appropriate binary for the system
    system "curl", "-L", binary_url, "-o", "changelog_cli"
    chmod 0555, "changelog_cli"
    bin.install "changelog_cli"
  end

  test do
    system "#{bin}/changelog_cli", "--version"
  end
end
