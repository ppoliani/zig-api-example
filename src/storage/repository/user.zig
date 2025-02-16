const std = @import("std");
const Pool = @import("pg").Pool;
const DbPool = @import("../connection.zig").DbPool;
const User = @import("../model/user.zig").User;

pub fn create_user(db_pool: *DbPool, new_user: User) !void {
    const query =
        \\ INSERT INTO users (name, email, age)
        \\ VALUES ($1, $2, $3)
        \\ ON CONFLICT (name, email, age) DO NOTHING
    ;

    _ = try db_pool.pool.exec(query, .{ new_user.name, new_user.email, new_user.age });
}

pub fn get_users(db_pool: *DbPool) !void {
    const query =
        \\ SELECT * FROM users
    ;

    const result = try db_pool.pool.exec(query, .{});
    defer result.deinit();

    while (try result.next()) |row| {
        const id = row.get(i32, 0);
        const name = row.get([]const u8, 0);
        const email = row.get([]const u8, 0);

        std.debug.print("{any}\n", .{ id, name, email });
    }
}
