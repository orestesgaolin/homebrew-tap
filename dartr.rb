class Dartr < Formula
  desc "Rust port of the Dart analyzer: dart analyze, dart format, language server"
  homepage "https://github.com/orestesgaolin/dartr"
  version "0.1.0-preview.3"
  license "BSD-3-Clause"

  base_url = "https://github.com/orestesgaolin/dartr/releases/download/v#{version}"

  # Default (macOS arm64). Other platforms override it below, or stop in
  # `install` with a clear message.
  url "#{base_url}/dartr-#{version}-aarch64-apple-darwin.tar.gz"
  sha256 "504d378ac1eb23a2d04c0fff6bd1e4451c2f512df7d1b9f2d6f6b4a0fda45433"

  on_linux do
    url "#{base_url}/dartr-#{version}-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "fd91ab85d3ccd13b402d1a025aca1dd6fe12f89547414d6ddbc2ac7dc617ffa8"
  end

  def install
    if OS.mac? && Hardware::CPU.intel?
      odie "dartr does not provide an Intel macOS binary (macOS arm64 and Linux x86_64 only)"
    elsif OS.linux? && !Hardware::CPU.intel?
      odie "dartr does not provide a Linux arm64 binary (macOS arm64 and Linux x86_64 only)"
    elsif !OS.mac? && !OS.linux?
      odie "dartr supports macOS arm64 and Linux x86_64 only"
    end

    bin.install "bin/dartr"
    # The VS Code shim looks for `dartr` in its own folder (docs/editor-setup.md).
    libexec.install "tools/shim/dartr_shim.dart"
    libexec.install_symlink bin/"dartr"
    doc.install "README.md", "THIRD_PARTY_NOTICES.md"
  end

  def caveats
    <<~EOS
      dartr reads the Dart libraries from a Dart or Flutter SDK on PATH (`dart` must work).
      VS Code (Dart-Code): set "dart.analyzerPath" to
        #{opt_libexec}/dartr_shim.dart
    EOS
  end

  test do
    assert_match "3.13.3", shell_output("#{bin}/dartr --version")
  end
end
