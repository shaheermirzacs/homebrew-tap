class Omp < Formula
  desc "Coding agent with local transcript and Markdown patches"
  homepage "https://github.com/shaheermirzacs/oh-my-pi"
  url "https://github.com/shaheermirzacs/oh-my-pi/releases/download/v18.21.0-patched/omp-darwin-arm64",
      using: :nounzip
  version "18.21.0"
  sha256 "359f1fc7df5687756f314896e9e1c8b57b4c9c8908ce534a60e28bae0e64466f"
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
