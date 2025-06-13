const std = @import("std");

pub fn main() !void {
    var debug_allocator = std.heap.DebugAllocator(.{}).init;
    defer std.debug.assert(debug_allocator.deinit() == .ok);
    const allocator = debug_allocator.allocator();

    const stdout = std.io.getStdOut();

    var arg_iter = try std.process.argsWithAllocator(allocator);
    defer arg_iter.deinit();

    var args = std.ArrayList(u8).init(allocator);
    defer args.deinit();

    _ = arg_iter.skip();
    while (arg_iter.next()) |arg| {
        try args.appendSlice(arg[0..arg.len]);
        try args.append(" "[0]);
    }
    args.items[args.items.len - 1] = "\n"[0];
    try stdout.writeAll(args.items);
}
