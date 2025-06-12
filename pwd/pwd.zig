const std = @import("std");
const stdout = std.io.getStdOut().writer();

pub fn main() !void {
    var debug_allocator = std.heap.DebugAllocator(.{}).init;
    defer std.debug.assert(debug_allocator.deinit() == .ok);
    const allocator = debug_allocator.allocator();

    var pwd = std.ArrayList(u8)
        .fromOwnedSlice(allocator, try std.fs.realpathAlloc(allocator, "."));
    defer pwd.deinit();
    try pwd.append("\n"[0]);

    try stdout.writeAll(pwd.items);
}
