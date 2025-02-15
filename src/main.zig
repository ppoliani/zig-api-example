const zinc = @import("zinc");
const Store = @import("./utils/store.zig").Store;
const user_route = @import("./endpoints/user/route.zig");

pub fn main() !void {
    var store = try Store.init();
    defer store.deinit();
    var config = zinc.Config.Engine{ .port = 8080 };
    config.setData(&store);
    const engine = try zinc.init(config);
    defer engine.deinit();
    const router = engine.getRouter();

    try user_route.register(try router.group("/users"));
    try router.get("/", home);

    try engine.run();
}

fn home(ctx: *zinc.Context) !void {
    try ctx.text("Home page", .{});
}
