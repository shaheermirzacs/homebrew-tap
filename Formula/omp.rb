class Omp < Formula
  desc "Coding agent with local transcript and Markdown patches"
  homepage "https://github.com/shaheermirzacs/oh-my-pi"
  url "https://github.com/shaheermirzacs/oh-my-pi/releases/download/v19.0.1-patched/omp-darwin-arm64",
      using: :nounzip
  version "19.0.1"
  sha256 "bffa1320eb59627ab051f5185b91ca49fa252a8813df5d5880e62ad6a5d14720"
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
