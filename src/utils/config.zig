const std = @import("std");
const dotenv = @import("dotenv");
const getEnvVarOwned = std.process.getEnvVarOwned;

pub const Config = struct {
    db_name: []const u8,
    db_username: []const u8,
    db_password: []const u8,

    pub fn init() Config {
        const gpa = std.heap.GeneralPurposeAllocator(.{}){};
        const aa = std.heap.ArenaAllocator.init(gpa.allocator());
        defer aa.deinit();

        const allocator = aa.allocator();

        if (std.mem.eql(u8, try getEnvVarOwned(allocator, "ENV"), "development")) {
            try dotenv.load(allocator, .{});
        }

        return Config{
            .db_name = try getEnvVarOwned(allocator, "DB_NAME"),
            .db_username = try getEnvVarOwned(allocator, "DB_USERNAME"),
            .db_password = try getEnvVarOwned(allocator, "DB_PASSWORD"),
        };
    }
};
