const std = @import("std");
const tk = @import("tokamak");
const Store = @import("./utils/store.zig").Store;
const UserRoutes = @import("./endpoints/user/route.zig").UserRoutes;

pub fn main() !void {
    var store = try Store.init();
    defer store.deinit();
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};

    const routes = &.{
        tk.logger(.{}, &.{
            .group("/users", UserRoutes),
            .get("/", home),
        }),
    };

    const server = try tk.Server.init(
        gpa.allocator(),
        routes,
        .{
            .listen = .{ .port = 8080 },
            .injector = tk.Injector.init(&store, null),
        },
    );

    try server.start();
}

fn home() ![]const u8 {
    return "hello world";
}
