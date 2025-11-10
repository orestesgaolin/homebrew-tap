class ChangelogCli < Formula
  desc "A simple opinionated CLI to generate changelog based on the conventional commit history."
  homepage "https://github.com/orestesgaolin/dart_utilities"
  url "https://github.com/orestesgaolin/dart_utilities/archive/refs/tags/changelog_cli-v0.9.0.tar.gz"
  sha256 "6e4383013a7c3dea158a007503bd9ad460be32c4d91a70a16ad3ef173243239d"
  license "MIT"

  def install
    binary_name = case OS.mac?
                  when true
                    Hardware::CPU.intel? ? "changelog_cli_macos_x86" : "changelog_cli_macos"
                  else
                    OS.linux? ? "changelog_cli_linux" : "changelog_cli.exe"
                  end
                  
    binary_url = "https://github.com/orestesgaolin/dart_utilities/releases/download/changelog_cli-v0.9.0/#{binary_name}"
    binary_sha256 = case binary_name
                    when "changelog_cli_macos" then "c28678bc80660a4603d77e2283712322419c07afea699a4ec71d13a440351a77"
                    when "changelog_cli_macos_x86" then "8fc8d304b44e66a1965a715d9c73597f09a0f2794fa70f126c945bb9ab1dd805"
                    when "changelog_cli_linux" then "0ae4cebc51d7aecaadac1f1adee3b099f97f794bd4bd9fa988698914a1c40f3c"
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
