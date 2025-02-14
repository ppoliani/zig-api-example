const std = @import("std");
const pg = @import("pg");
const Pool = pg.Pool;

const Connection = struct {
    pool: Pool,

    pub fn init(database: []const u8, username: []const u8, password: []const u8) !Connection {
        var gpa = std.heap.GeneralPurposeAllocator(.{}){};

        const pool = try Pool.init(gpa.allocator(), .{ .size = 5, .connect = .{
            .port = 5432,
            .host = "127.0.0.1",
        }, .auth = .{
            .username = username,
            .database = database,
            .password = password,
            .timeout = 10_000,
        } });

        return Connection{ .pool = pool };
    }

    pub fn deinit(self: Connection) !void {
        self.pool.deinit();
    }
};

// defer pool.deinit();
