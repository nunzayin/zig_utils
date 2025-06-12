const std = @import("std");
const stdout = std.io.getStdOut().writer();

pub fn main() !void {
    var debugAllocator = std.heap.DebugAllocator(.{}).init;
    defer _ = debugAllocator.deinit();
    const allocator = debugAllocator.allocator();

    try stdout.writeAll(try std.fs.realpathAlloc(allocator, "."));
    try stdout.writeAll("\n");
}
