const std = @import("std");

pub fn main() !void {
    var debugAllocator = std.heap.DebugAllocator(.{}).init;
    defer _ = debugAllocator.deinit();
    const allocator = debugAllocator.allocator();

    const stdout = std.io.getStdOut().writer();

    var argIter = try std.process.argsWithAllocator(allocator);
    defer argIter.deinit();

    var args = std.ArrayList(u8).init(allocator);
    defer args.deinit();

    _ = argIter.skip();
    while (argIter.next()) |arg| {
        try args.appendSlice(arg[0..arg.len]);
        try args.append(" "[0]);
    }
    args.items[args.items.len - 1] = "\n"[0];
    try stdout.writeAll(args.items);
}
