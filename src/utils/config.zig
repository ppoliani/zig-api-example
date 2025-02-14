const std = @import("std");
const dotenv = @import("dotenv");

pub const Config = struct {
    db_name: []const u8,
    db_username: []const u8,
    db_password: []const u8,

    pub fn init() !Config {
        var gpa = std.heap.GeneralPurposeAllocator(.{}){};
        const allocator = gpa.allocator();

        const env_value = try std.process.getEnvVarOwned(allocator, "ENV");
        if (std.mem.eql(u8, env_value, "development")) {
            try dotenv.load(allocator, .{});
        }

        var env_map = try std.process.getEnvMap(allocator);

        return Config{
            .db_name = env_map.get("DB_NAME").?,
            .db_username = env_map.get("DB_USERNAME").?,
            .db_password = env_map.get("DB_PASSWORD").?,
        };
    }
};

pub const config = Config.init();
