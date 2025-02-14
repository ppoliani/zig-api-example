const zinc = @import("zinc");
const User = @import("../../storage/model/user.zig").User;

pub fn exec(ctx: *zinc.Context) !void {
    const user = User.create_dummy_user();
    try ctx.json(user, .{});
}
