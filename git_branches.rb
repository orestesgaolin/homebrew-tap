class GitBranches < Formula
  desc "Terminal UI to find merged & stale local git branches and batch-delete or push them."
  homepage "https://github.com/orestesgaolin/dart_utilities"
  url "https://github.com/orestesgaolin/dart_utilities/archive/refs/tags/git_branches-v0.2.1.tar.gz"
  sha256 "ee607c679883f1b294275025ae06c30609d3947b967c2828c9408b8c1d119438"
  license "MIT"

  def install
    binary_name = if OS.mac?
                    odie "git_branches does not provide an Intel macOS binary" if Hardware::CPU.intel?
                    "git_branches_macos"
                  elsif OS.linux?
                    "git_branches_linux"
                  else
                    "git_branches.exe"
                  end

    binary_url = "https://github.com/orestesgaolin/dart_utilities/releases/download/git_branches-v0.2.1/#{binary_name}"
    binary_sha256 = case binary_name
                    when "git_branches_macos" then "8b116719d8a7783af6b99ff0b0f5cc85cd434a9acf2ef43c3850de7d42ad58d1"
                    when "git_branches_linux" then "1136c124d04a02b80105a323707d2db3f29dd25c779862e5d675fef36912f52c"
                    when "git_branches.exe" then "64a88d30ad16f9131d24b454518b3888a75d0eed3f3590ae8a1b5398ae7d9372"
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
