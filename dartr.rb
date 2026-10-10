class Dartr < Formula
  desc "Rust port of the Dart analyzer: dart analyze, dart format, language server"
  homepage "https://github.com/orestesgaolin/dartr"
  version "0.1.0-preview.2"
  license "BSD-3-Clause"

  base_url = "https://github.com/orestesgaolin/dartr/releases/download/v#{version}"

  # Default (macOS arm64). Other platforms override it below, or stop in
  # `install` with a clear message.
  url "#{base_url}/dartr-#{version}-aarch64-apple-darwin.tar.gz"
  sha256 "1393f5fed3fcaa4cc9cd502acf078240c26afc59977015fa848f6d6873a51d54"

  on_linux do
    url "#{base_url}/dartr-#{version}-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "ba4dda8a2b1a6c16e97a56d086d842a4b20a9ee4c6d604828c8f7c0ff58c5483"
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
