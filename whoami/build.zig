const std = @import("std");

pub fn build(b: *std.Build) void {
    const exe = b.addExecutable(.{
        .name = "whoami",
        .root_source_file = b.path("whoami.zig"),
        .target = b.graph.host,
        .optimize = .ReleaseSmall,
        .link_libc = true,
    });

    b.installArtifact(exe);
}
