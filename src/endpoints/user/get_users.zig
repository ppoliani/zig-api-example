const tk = @import("tokamak");
const User = @import("../../storage/model/user.zig").User;
const Store = @import("../../utils//store.zig").Store;

pub fn exec(res: *tk.Response) !void {
    const user = User.create_dummy_user();
    try res.json(user, .{});
}
