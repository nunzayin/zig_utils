const std = @import("std");
const stdout = std.io.getStdOut().writer();

pub fn main() !void {
    var debugAllocator = std.heap.DebugAllocator(.{}).init;
    defer _ = debugAllocator.deinit();
    const allocator = debugAllocator.allocator();

    const pwd = try std.fs.realpathAlloc(allocator, ".");
    defer allocator.free(pwd);

    try stdout.writeAll(pwd);
    try stdout.writeAll("\n");
}
