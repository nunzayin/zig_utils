const std = @import("std");

pub fn main() !void {
    var debugAllocator = std.heap.DebugAllocator(.{}).init;
    const allocator = debugAllocator.allocator();
    const stdout = std.io.getStdOut().writer();
    const args = std.process.argsAlloc(allocator);
    defer std.process.argsFree(allocator, args);
    for (args[1..]) |arg| {
        try stdout.writeAll(arg);
        try stdout.writeAll(" ");
    }
    try stdout.writeAll("\n");
    try stdout.write(args);
}
