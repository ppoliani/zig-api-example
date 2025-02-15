const zinc = @import("zinc");
const get_users = @import("./get_users.zig");
const Store = @import("../../utils/store.zig").Store;
const create_user = @import("./create_user.zig");

pub fn register(router: *zinc.RouterGroup) !void {
    try router.get("/", get_users.exec);
    try router.post("/", create_user.exec);
}
