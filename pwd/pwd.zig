const std = @import("std");
const stdout = std.io.getStdOut().writer();

pub fn main() !void {
    var debugAllocator = std.heap.DebugAllocator(.{}).init;
    defer _ = debugAllocator.deinit();
    const allocator = debugAllocator.allocator();

    var pwd = std.ArrayList(u8)
        .fromOwnedSlice(allocator, try std.fs.realpathAlloc(allocator, "."));
    defer pwd.deinit();
    try pwd.append("\n"[0]);

    try stdout.writeAll(pwd.items);
}
