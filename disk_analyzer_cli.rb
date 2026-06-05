class DiskAnalyzerCli < Formula
  desc "A CLI to analyze disk usage and identify large files and directories."
  homepage "https://github.com/orestesgaolin/dart_utilities"
  url "https://github.com/orestesgaolin/dart_utilities/archive/refs/tags/disk_analyzer_cli-v1.1.1.tar.gz"
  sha256 "dc65861fa2c61ad6dda326fff446d237cf0202ef4d38100aa3b75594a9662646"
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

    binary_url = "https://github.com/orestesgaolin/dart_utilities/releases/download/disk_analyzer_cli-v1.1.1/#{binary_name}"
    binary_sha256 = case binary_name
                    when "disk_analyzer_cli_macos_arm64.zip" then "c8be37725190e8e0f94292c25949afa3e52113bbb999086dc8013a59238caba7"
                    when "disk_analyzer_cli_linux_x64.zip" then "6482f82bfe91ad947b2f634fa8011ded8ae0d72a0852d9e7ba548ec294099a9e"
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