const std = @import("std");
const builtin = @import("builtin");
const pg = @import("pg");
const Pool = pg.Pool;

pub const DbPool = struct {
    pool: *Pool,

    pub fn init(database: []const u8, username: []const u8, password: []const u8) !DbPool {
        var gpa = std.heap.GeneralPurposeAllocator(.{}){};
        const allocator = if (builtin.mode == .Debug) gpa.allocator() else std.heap.c_allocator;

        const pool = try Pool.init(allocator, .{ .size = 10, .connect = .{
            .port = 5432,
            .host = "127.0.0.1",
        }, .auth = .{
            .username = username,
            .database = database,
            .password = password,
            .timeout = 10_000,
        } });

        return DbPool{ .pool = pool };
    }

    pub fn deinit(self: DbPool) void {
        self.pool.deinit();
    }
};

// defer pool.deinit();
