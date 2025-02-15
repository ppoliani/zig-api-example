const std = @import("std");
const zinc = @import("zinc");
const User = @import("../../storage/model/user.zig").User;
const Store = @import("../../utils//store.zig").Store;
const create_user = @import("../../storage/repository/user.zig").create_user;

pub fn exec(ctx: *zinc.Context) !void {
    const store: *Store = @ptrCast(@alignCast(ctx.data));
    const user = blk: {
        if (try ctx.getJson(User)) |user| {
            break :blk user;
        }

        return ctx.response.sendStatus(std.http.Status.bad_request);
    };

    try create_user(&store.db, user);
}
