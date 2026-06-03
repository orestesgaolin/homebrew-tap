class DiskAnalyzerCli < Formula
  desc "A CLI to analyze disk usage and identify large files and directories."
  homepage "https://github.com/orestesgaolin/dart_utilities"
  url "https://github.com/orestesgaolin/dart_utilities/archive/refs/tags/disk_analyzer_cli-v1.0.1.tar.gz"
  sha256 "83d6c9cd643e6e85fcda6c9bb536693adaacf4a92de4212d188bdf5b1ce1d960"
  license "MIT"

  def install
    binary_name = if OS.mac?
                    odie "disk_analyzer_cli does not provide an Intel macOS binary" if Hardware::CPU.intel?
                    "disk_analyzer_cli_macos_arm64.zip"
                  elsif OS.linux?
                    odie "disk_analyzer_cli only provides an x86_64 Linux binary" unless Hardware::CPU.intel?
                    "disk_analyzer_cli_linux_x64.zip"
                  else
                    odie "disk_analyzer_cli is not supported on this platform"
                  end

    binary_url = "https://github.com/orestesgaolin/dart_utilities/releases/download/disk_analyzer_cli-v1.0.1/#{binary_name}"
    binary_sha256 = case binary_name
                    when "disk_analyzer_cli_macos_arm64.zip" then "32da7f2f27cb5ce8c41bb3a0ded51f2f262d5f07eb31d875c7c98deee4030d46"
                    when "disk_analyzer_cli_linux_x64.zip" then "3e8a94726fded3044eacdf6931b11636f628079e9e6921d4a4d9fed6ed9643dd"
                    end

    system "curl", "-L", binary_url, "-o", "#{buildpath}/disk_analyzer_cli.zip"
    downloaded_sha256 = Utils.safe_popen_read("shasum", "-a", "256", "#{buildpath}/disk_analyzer_cli.zip").split.first
    odie "Downloaded binary checksum mismatch" if downloaded_sha256 != binary_sha256

    system "unzip", "-q", "#{buildpath}/disk_analyzer_cli.zip", "-d", buildpath
    chmod 0555, "#{buildpath}/bin/disk_analyzer_cli"
    bin.install "#{buildpath}/bin/disk_analyzer_cli"
    lib.install Dir["#{buildpath}/lib/*"]
  end

  test do
    system "#{bin}/disk_analyzer_cli", "--version"
  end
end