const zinc = @import("zinc");
const get_users = @import("./get_users.zig");

pub fn register(router: *zinc.RouterGroup) !void {
    try router.get("/", get_users.exec);
}
