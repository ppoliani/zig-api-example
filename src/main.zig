const zinc = @import("zinc");
const std = @import("std");
const Store = @import("./utils/store.zig").Store;
const user_route = @import("./endpoints/user/route.zig");

pub fn main() !void {
    const engine = try zinc.init(.{ .port = 8080 });
    defer engine.deinit();
    const router = engine.getRouter();
    const store = try Store.init();
    defer store.deinit();

    std.debug.print("db_name {s}\n", .{store.config.db_name});
    std.debug.print("db_name {s}\n", .{store.config.db_password});
    std.debug.print("db_name {s}\n", .{store.config.db_name});

    try user_route.register(try router.group("/users"));
    try router.get("/", home);

    try engine.run();
}

fn home(ctx: *zinc.Context) !void {
    try ctx.text("Home page", .{});
}
