# Cloud Foundry Buildpack for Rust

This buildpack is a modified version of https://github.com/emk/heroku-buildpack-rust with some important differences.
Since the target environment is SAP Cloud Foundry, the following steps have been removed:

1. Heroku specific configuration such as the use of a `Procfile`
2. The steps to install and run [`diesel`](https://diesel.rs) database migrations

## Usage

Set the buildpack in your `manifest.yml`:

```yaml
---
applications:
- name: my-cool-rust-project
  memory: 64M
  buildpacks:
  - https://github.com/lighthouse-no/cf-buildpack-rust
```

## Rust Version

In the vast majority of cases, you will want your application built using the stable Rust channel.

However, should you wish to use either the `nightly` channel, or pin your application to a specific Rust version, then use a `rustup` [`rust-toolchain`](https://github.com/rust-lang/rustup#the-toolchain-file) file.

***IMPORTANT***<br>
If the `VERSION` variable is set in `RustConfig`, this will take precedence over any value in the `rust-toolchain` file.

### Cargo Build Flags

`cargo` build flags can be set using the `RUST_CARGO_BUILD_FLAGS` variable in `RustConfig` file.

For example:

```sh
RUST_CARGO_BUILD_FLAGS="--release -p some_package --bin some_binary --bin some_other_binary"
```

By default, `RUST_CARGO_BUILD_FLAGS` will be `--release`.

## Testing with Docker

To test changes to the buildpack using the included `test-buildpack.yml`, run:

```sh
./test_buildpack.sh
```

This uses the standard `rust` Docker image.
