class Omp < Formula
  desc "Coding agent with local transcript and Markdown patches"
  homepage "https://github.com/shaheermirzacs/oh-my-pi"
  url "https://github.com/shaheermirzacs/oh-my-pi/releases/download/v18.20.2-patched/omp-darwin-arm64",
      using: :nounzip
  version "18.20.2"
  sha256 "d6c45c50428ffc295957d3a6de4b7277a207881deb74377cabf2676e5a470cf5"
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
