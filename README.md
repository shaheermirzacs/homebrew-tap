# Homebrew tap

Patched [omp](https://github.com/shaheermirzacs/oh-my-pi) builds for Apple Silicon macOS.

## Install

```sh
brew install shaheermirzacs/tap/omp
```

If Homebrew already has another `omp` installed, remove that installation before installing this formula. A separate `omp` earlier on `PATH` still takes precedence; check `which -a omp`.

Use `brew upgrade shaheermirzacs/tap/omp` for upgrades. Keep `update.auto` disabled and do not use `omp update`: the unchanged upstream updater targets upstream releases and may replace your patched build.

## Versioning

The executable and formula retain the upstream version (`18.20.2` initially). The fork's `v18.20.2` release tag identifies the patched commit; upstream's tag remains unchanged. Upstream upgrades are manual, not automatic.

For additional patches to the same upstream version, publish `omp-darwin-arm64` under a new immutable fork tag (for example, `v18.20.2-sklk.1`), update the formula URL and SHA-256, and increment the formula's `revision`. Keep `version` equal to the upstream version and keep the asset filename unchanged because the install step uses that filename. Never overwrite an asset already referenced by this tap.

## Publish the next upstream version

In the fork checkout, fetch the upstream tag from `origin`, merge it into `sklk`, resolve conflicts, and verify the patches. The `fork` remote points at the personal fork; `origin` remains upstream. Push `sklk` to `fork`.

Build on Apple Silicon macOS with Bun 1.4.4 or the version required by that upstream release, using a matching native addon in `packages/natives/native/`:

```sh
bun install --frozen-lockfile
bun run build:native
bun run ci:release:build-binaries --targets darwin-arm64
packages/coding-agent/binaries/omp-darwin-arm64 --version
packages/coding-agent/binaries/omp-darwin-arm64 --smoke-test
shasum -a 256 packages/coding-agent/binaries/omp-darwin-arm64
```

Publish the binary as `omp-darwin-arm64` in a GitHub Release pointing at the patched `sklk` commit. The fork release tag must point at that patched commit, not the inherited upstream tag. Update `Formula/omp.rb` with the release URL, upstream version, and SHA-256; remove any old formula `revision` when advancing the upstream version. Commit and push the formula.

The binaries are ad-hoc signed, not Developer ID signed or notarized. This tap uses GitHub Releases, not GitHub Packages. No automated publishing workflows or upstream build-service credentials are required.
