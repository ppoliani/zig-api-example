const zinc = @import("zinc");
const User = @import("../../storage/model/user.zig").User;
const Store = @import("../../utils//store.zig").Store;

pub fn exec(ctx: *zinc.Context) !void {
    const user = User.create_dummy_user();
    try ctx.json(user, .{});
}
