const std = @import("std");

pub fn build(b: *std.Build) void {
    const exe = b.addExecutable(.{
        .name = "echo",
        .root_source_file = b.path("echo.zig"),
        .target = b.graph.host,
        .optimize = .ReleaseSmall,
    });

    b.installArtifact(exe);
}
