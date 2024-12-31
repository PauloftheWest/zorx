const std = @import("std");
const C = @import("czorx.zig");
const zorx = @import("zorx.zig");

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    const allocator = gpa.allocator();
    defer {
        _ = gpa.deinit();
    }

    const args = try std.process.argsAlloc(allocator);
    defer std.process.argsFree(allocator, args);

    if (args.len < 2) {
        std.debug.print("Need a path to a ini file.\n", .{});
        return;
    }

    const ini_path = args[1];
    try zorx.init(ini_path);
}
