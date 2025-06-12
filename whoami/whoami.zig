const std = @import("std");
const stdout = std.io.getStdOut().writer();

pub fn main() !void {
    try stdout.writeAll(std.mem.span(std.c.getpwuid(std.os.linux.geteuid()).?.name.?));
    try stdout.writeAll("\n");
}
