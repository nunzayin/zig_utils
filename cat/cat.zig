const std = @import("std");
const stdout = std.io.getStdOut().writer();
const cwd = std.fs.cwd();
const BUFFER_SIZE = 262144;

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
        cat(arg, allocator);
    }
    if (no_arguments) cat("-", allocator);
}

fn cat(file_path: [:0]const u8, allocator: std.mem.Allocator) void {
    faulty_cat(file_path, allocator) catch |err| {
        std.debug.print("{}", .{err});
    };
}

fn faulty_cat(file_path: [:0]const u8, allocator: std.mem.Allocator) !void {
    const file =
        if (std.mem.eql(u8, file_path, "-"))
            std.io.getStdIn()
        else
            try cwd.openFileZ(file_path, .{});
    defer file.close();

    var buffer = try allocator.alloc(u8, BUFFER_SIZE);
    defer allocator.free(buffer);

    var bytes_read: usize = undefined;

    while (true) {
        bytes_read = try file.readAll(buffer);
        try stdout.writeAll(buffer[0..bytes_read]);
        if (bytes_read < BUFFER_SIZE) return;
    }
}
