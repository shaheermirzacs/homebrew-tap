# Homebrew tap

Patched [omp](https://github.com/shaheermirzacs/oh-my-pi) builds for Apple Silicon macOS.

## Install

```sh
brew install shaheermirzacs/tap/omp
```

Remove any other Homebrew `omp` first, and check `which -a omp` for other installs earlier on `PATH`.

Upgrade with `brew upgrade shaheermirzacs/tap/omp`. Keep `update.auto` disabled and don't run `omp update`; it targets upstream and would replace the patched build.

## Versioning

- Upstream tags (`v18.20.2`) are upstream's code, untouched.
- Patched releases are tagged `<upstream tag>-patched` (`v18.20.2-patched`).
- `omp --version` and the formula `version` match upstream (`18.20.2`).

## Upgrading to a new upstream release

In the fork checkout (`origin` = this fork, `upstream` = can1357/oh-my-pi):

```sh
git fetch upstream                  # brings in upstream tags, e.g. v18.20.3
git switch main
git merge v18.20.3                  # resolve conflicts, keep the patches
bun install --frozen-lockfile
bun run build:native
bun test packages/coding-agent/test/input-controller-keybindings.test.ts \
  packages/coding-agent/test/modes/controllers/input-controller-tool-expansion.test.ts \
  packages/tui/test/assistant-message-prose-color.test.ts
bun run ci:release:build-binaries --targets darwin-arm64
packages/coding-agent/binaries/omp-darwin-arm64 --version      # 18.20.3
packages/coding-agent/binaries/omp-darwin-arm64 --smoke-test
git push origin main
gh release create v18.20.3-patched packages/coding-agent/binaries/omp-darwin-arm64 \
  --repo shaheermirzacs/oh-my-pi --target "$(git rev-parse HEAD)" --title v18.20.3-patched --notes "Upstream v18.20.3 plus local patches."
shasum -a 256 packages/coding-agent/binaries/omp-darwin-arm64
```

Then in this tap, set `Formula/omp.rb`'s `url` tag, `version`, and `sha256`, remove any `revision` line, and commit and push.

Changing patches without a new upstream release: publish `vX.Y.Z-patched.1` (`.2`, …) the same way and add or increment `revision` in the formula. Never move or overwrite a published tag or asset.

The binaries are ad-hoc signed, not notarized.
