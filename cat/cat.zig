const std = @import("std");
const stdout = std.io.getStdOut();
const cwd = std.fs.cwd();
const MAX_BUFFER_SIZE = 262144;

pub fn main() !void {
    var debug_allocator = std.heap.DebugAllocator(.{}).init;
    defer std.debug.assert(debug_allocator.deinit() == .ok);
    const allocator = debug_allocator.allocator();

    var arg_iter = try std.process.argsWithAllocator(allocator);
    defer arg_iter.deinit();

    _ = arg_iter.skip();

    var no_arguments = true;

    while (arg_iter.next()) |arg| {
        no_arguments = false;
        try cat(arg, allocator);
    }
    if (no_arguments) try cat("-", allocator);
}

fn cat(file_path: [:0]const u8, allocator: std.mem.Allocator) !void {
    const is_stdin = std.mem.eql(u8, file_path, "-");

    const file =
        if (is_stdin)
            std.io.getStdIn()
        else
            cwd.openFileZ(file_path, .{}) catch |err| {
                std.debug.print("{s}: {}\n", .{ file_path, err });
                return;
            };
    defer file.close();

    const buffer_size = blk: {
        if (is_stdin) break :blk MAX_BUFFER_SIZE;
        if (file.metadata()) |metadata|
            break :blk @min(metadata.size(), MAX_BUFFER_SIZE)
        else |err| {
            std.debug.print("{s}: {} (max buffer size will be used)\n", .{ file_path, err });
            break :blk MAX_BUFFER_SIZE;
        }
    };

    var buffer = try allocator.alloc(u8, buffer_size);
    defer allocator.free(buffer);

    var bytes_read: usize = undefined;

    while (true) {
        bytes_read = file.readAll(buffer) catch |err| {
            std.debug.print("{s}: {}\n", .{ file_path, err });
            return;
        };
        try stdout.writeAll(buffer[0..bytes_read]);
        if (bytes_read < buffer.len) return;
    }
}
