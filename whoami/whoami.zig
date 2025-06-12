const std = @import("std");

pub fn main() !void {
    try std.io.getStdOut().writer()
        .writeAll(std.mem.span(std.c.getpwuid(std.os.linux.geteuid()).?.name.?));
}
