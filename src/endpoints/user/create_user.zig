const std = @import("std");
const tk = @import("tokamak");
const User = @import("../../storage/model/user.zig").User;
const Store = @import("../../utils//store.zig").Store;
const create_user = @import("../../storage/repository/user.zig").create_user;

pub fn exec(res: *tk.Response, store: *Store, user: User) !void {
    try create_user(&store.db, user);
    res.status = 201;
    return res.write();
}
