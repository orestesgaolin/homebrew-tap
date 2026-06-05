class GitChain < Formula
  desc "Terminal UI to visualize and sync stacked git branch chains and their PRs."
  homepage "https://github.com/orestesgaolin/dart_utilities"
  url "https://github.com/orestesgaolin/dart_utilities/archive/refs/tags/git_chain-v0.5.6.tar.gz"
  sha256 "38f17b0ecb47dc8c1e3833feca1a823815e21c3f3ef1eb14bb005e1d5a2f6acf"
  license "MIT"

  def install
    binary_name = if OS.mac?
                    odie "git_chain does not provide an Intel macOS binary" if Hardware::CPU.intel?
                    "git_chain_macos_arm64.zip"
                  elsif OS.linux?
                    odie "git_chain only provides an x86_64 Linux binary" unless Hardware::CPU.intel?
                    "git_chain_linux_x64.zip"
                  else
                    odie "git_chain is not supported on this platform"
                  end

    binary_url = "https://github.com/orestesgaolin/dart_utilities/releases/download/git_chain-v0.5.6/#{binary_name}"
    binary_sha256 = case binary_name
                    when "git_chain_macos_arm64.zip" then "7d1840ba406a73597c99ec27b88c081a8a6458a78de2b2fc3ebf43cd3e3031da"
                    when "git_chain_linux_x64.zip" then "735833ceb23530197e7550ae6ab3d967c61ba04ee21f73734206f2fbab20161b"
                    end

    system "curl", "-L", binary_url, "-o", "#{buildpath}/git_chain.zip"
    downloaded_sha256 = Utils.safe_popen_read("shasum", "-a", "256", "#{buildpath}/git_chain.zip").split.first
    odie "Downloaded binary checksum mismatch" if downloaded_sha256 != binary_sha256

    system "unzip", "-q", "#{buildpath}/git_chain.zip", "-d", buildpath
    chmod 0555, "#{buildpath}/bin/git_chain"
    bin.install "#{buildpath}/bin/git_chain"
    lib.install Dir["#{buildpath}/lib/*"]
  end

  test do
    system "#{bin}/git_chain", "--help"
  end
end
