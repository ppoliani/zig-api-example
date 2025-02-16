const Route = @import("tokamak").Route;
const get_users = @import("./get_users.zig");
const Store = @import("../../utils/store.zig").Store;
const create_user = @import("./create_user.zig");

pub const UserRoutes = &.{
    Route.get("/", get_users.exec),
    Route.post("/", create_user.exec),
};
