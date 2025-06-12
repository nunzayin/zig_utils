const std = @import("std");

pub fn build(b: *std.Build) void {
    const exe = b.addExecutable(.{
        .name = "pwd",
        .root_source_file = b.path("pwd.zig"),
        .target = b.graph.host,
        .optimize = .ReleaseSmall,
    });

    b.installArtifact(exe);
}
