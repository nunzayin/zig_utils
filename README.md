# `zig_utils`

Collection of userspace utils inspired by GNU coreutils implemented in Zig.

> [!WARNING]
> These utilities were made for educational purposes.
> They are NOT meant to successfully replace the original ones.

## Building

Simply enter the directory of the utility you want to build and then
issue the following command:

```bash
zig build [your preferred flags]
```

By default (with no flags), Zig build script will compile the program
with `ReleaseSmall` optimization options and produce a binary to the
`$REPO_ROOT/$UTIL_ROOT/zig-out/bin/` directory. For example, building
`cat`:

```bash
cd cat
zig build --summary all
```

This will create `$REPO_ROOT/cat/zig-out/bin/cat` binary.

To clean build, simply delete `$UTIL_ROOT/.zig-cache` and
`$UTIL_ROOT/zig-out` directories and then perform the building. Optionally
you can execute `$REPO_ROOT/clean.sh` shell script to clean all the caches from
util directories.

## Credits

Made by **nz** aka **nunzayin** aka **Nick Zaber**

## License

See the [`LICENSE`](./LICENSE)
