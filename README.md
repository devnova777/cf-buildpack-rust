# SAP Cloud Foundry Buildpack for Rust

This buildpack uses the standard `rust` image and targets the SAP Cloud Foundry environment.

## Usage

Set the buildpack in your `manifest.yml`:

```yaml
---
applications:
- name: my-cool-rust-project
  memory: 4096M
  buildpacks:
  - https://github.com/lighthouse-no/cf-buildpack-rust
```

CVloud Foundry starts this application based on the coontents of a `Procfile`.

In the top level of your repo, create a `Procfile` that contains the line:

```Procfile
web: ./target/release/my-cool-rust-project
```

The application name defined in the `Procfile` must match the name in `manifest.yml`.
Also, the cargo build profile (`release` in this case) must match your configured build profile (see below).

## Rust Toolchain

In the vast majority of cases, you will want your application built using the `stable` Rust channel.

However, should you wish to use either the `nightly` channel, or pin your application to a specific Rust version, then create a file called `rust-toolchain` in your repo's top level directory containing the specific toolchain name you wish to use.
For example:

```sh
$ cat rust-toolchain
nightly
```

If present, the `rust-toolchain` file should contain only a single value.

See [`Rust toolchains`](https://rust-lang.github.io/rustup/concepts/toolchains.html) for more details about Rust channels.

## Cargo Environment Variables

Any environment variables used by `cargo` can be defined in a file called `RustConfig` in your repo's top level directory.
For instance:

```sh
$ cat RustConfig
RUST_LIB_BACKTRACE=1
RUST_BACKTRACE=full
RUST_LOG=warn
```

See [Rust Environment Variables](https://rust-lang.github.io/rustup/environment-variables.html) for more details.

The `RustConfig` file may also contain additional variables used by this buildpack:

| `RustConfig` Variable | Default Value | Description
|---|---|---
| `VERSION` | `"stable"` | Change this value if you want to use the nightly build or a specific Rust version.<br>***IMPORTANT***<br>If a value of `VERSION` is define here, it will override the value in `rust-toolchain`.
| `BUILD_PATH` | `""` | If your source code is not in the top-level directory of your repo, define the pathname in this variable
| `RUST_CARGO_BUILD_PROFILE` | `"release"` | Rust build profile
| `RUST_CARGO_BUILD_FLAGS` | `""` | Optional build flags.<br>For example `"-p some_package --bin some_binary --bin some_other_binary"`

The `cargo build` command will then be issued using the pattern:

```sh
cargo build --$RUST_CARGO_BUILD_PROFILE $RUST_CARGO_BUILD_FLAGS
```

Therefore, you should not specify the Rust build profile in `RUST_CARGO_BUILD_FLAGS`.

## Testing with Docker

Changes to the buildpack can be tested using the included shell script `test-buildpack.sh`.
This uses the standard `rust` Docker image.

-----
&copy; 2023 Lighthouse Consulting AS
