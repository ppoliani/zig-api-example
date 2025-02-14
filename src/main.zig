const zinc = @import("zinc");
const user_route = @import("./endpoints/user/route.zig");

pub fn main() !void {
    const engine = try zinc.init(.{ .port = 8080 });
    defer engine.deinit();
    const router = engine.getRouter();

    try user_route.register(try router.group("/users"));
    try router.get("/", home);

    try engine.run();
}

fn home(ctx: *zinc.Context) !void {
    try ctx.text("Home page", .{});
}
