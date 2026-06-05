class GitBranches < Formula
  desc "Terminal UI to find merged & stale local git branches and batch-delete or push them."
  homepage "https://github.com/orestesgaolin/dart_utilities"
  url "https://github.com/orestesgaolin/dart_utilities/archive/refs/tags/git_branches-v0.1.0.tar.gz"
  sha256 ""
  license "MIT"

  def install
    binary_name = case OS.mac?
                  when true
                    Hardware::CPU.intel? ? "git_branches_macos_x86" : "git_branches_macos"
                  else
                    OS.linux? ? "git_branches_linux" : "git_branches.exe"
                  end

    binary_url = "https://github.com/orestesgaolin/dart_utilities/releases/download/git_branches-v0.1.0/#{binary_name}"
    binary_sha256 = case binary_name
                    when "git_branches_macos" then ""
                    when "git_branches_macos_x86" then ""
                    when "git_branches_linux" then ""
                    when "git_branches.exe" then ""
                    end

    # Use full path to avoid conflicts
    system "curl", "-L", binary_url, "-o", "#{buildpath}/git_branches_bin"
    chmod 0555, "#{buildpath}/git_branches_bin"
    bin.install "#{buildpath}/git_branches_bin" => "git_branches"
  end

  test do
    system "#{bin}/git_branches", "--help"
  end
end
