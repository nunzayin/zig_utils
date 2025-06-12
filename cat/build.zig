const std = @import("std");

pub fn build(b: *std.Build) void {
    const exe = b.addExecutable(.{
        .name = "cat",
        .root_source_file = b.path("cat.zig"),
        .target = b.graph.host,
        .optimize = .ReleaseSmall,
    });

    b.installArtifact(exe);
}
