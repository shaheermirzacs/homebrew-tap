class Omp < Formula
  desc "Coding agent with local transcript and Markdown patches"
  homepage "https://github.com/shaheermirzacs/oh-my-pi"
  url "https://github.com/shaheermirzacs/oh-my-pi/releases/download/v18.20.3-patched/omp-darwin-arm64",
      using: :nounzip
  version "18.20.3"
  sha256 "09546edf575cd75702a5116998b2108f24c3d7e146a6d433b027856382dd7098"
  license "MIT"

  depends_on arch: :arm64
  depends_on :macos

  def install
    bin.install "omp-darwin-arm64" => "omp"
    (bin/"omp").chmod 0555
    with_env(HOME: buildpath) do
      generate_completions_from_executable(bin/"omp", "completions", shells: [:bash, :zsh, :fish])
    end
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/omp --version")
  end
end
