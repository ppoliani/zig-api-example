const std = @import("std");
const zinc = @import("zinc");
const User = @import("../../storage/model/user.zig").User;
const Store = @import("../../utils//store.zig").Store;

pub fn exec(ctx: *zinc.Context) !void {
    const store: *Store = @ptrCast(@alignCast(ctx.data));
    std.debug.print("db_name {s}\n", .{store.config.db_name});
    const user = User.create_dummy_user();
    try ctx.json(user, .{});
}
