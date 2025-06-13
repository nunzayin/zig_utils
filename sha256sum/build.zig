const std = @import("std");

pub fn build(b: *std.Build) void {
    const exe = b.addExecutable(.{
        .name = "sha256sum",
        .root_source_file = b.path("sha256sum.zig"),
        .target = b.graph.host,
        .optimize = .ReleaseSmall,
    });

    b.installArtifact(exe);
}
