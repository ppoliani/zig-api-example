const std = @import("std");
const Pool = @import("pg").Pool;
const User = @import("../model/user.zig").User;

pub fn create_user(pool: *Pool, new_user: User) !void {
    var conn = try pool.acquire();
    defer conn.release();

    const query =
        \\ INSERT INTO users (name, email, age)
        \\ VALUES ($1, $2, $3)
        \\ ON CONFLICT (name, email, age) DO NOTHING
    ;

    try conn.exec(query, .{ new_user.name, new_user.password, new_user.age });
}

pub fn get_users(pool: *Pool) !void {
    var conn = try pool.acquire();
    defer conn.release();

    const query =
        \\ SELECT * FROM users
    ;

    const result = try conn.exec(query, .{});
    defer result.deinit();

    while (try result.next()) |row| {
        const id = row.get(i32, 0);
        const name = row.get([]const u8, 0);
        const email = row.get([]const u8, 0);

        std.debug.print("{any}\n", .{ id, name, email });
    }
}
