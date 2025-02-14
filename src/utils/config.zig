const std = @import("std");
const dotenv = @import("dotenv");

pub const Config = struct {
    db_name: []const u8,
    db_username: []const u8,
    db_password: []const u8,

    pub fn init() !Config {
        var gpa = std.heap.GeneralPurposeAllocator(.{}){};
        var aa = std.heap.ArenaAllocator.init(gpa.allocator());
        defer aa.deinit();
        const allocator = aa.allocator();

        var env_map = try std.process.getEnvMap(allocator);
        defer env_map.deinit();

        const env_value = env_map.get("ENV").?;
        if (std.mem.eql(u8, env_value, "development")) {
            try dotenv.load(allocator, .{});
        }

        return Config{
            .db_name = env_map(allocator, "DB_NAME").?,
            .db_username = env_map(allocator, "DB_USERNAME").?,
            .db_password = env_map(allocator, "DB_PASSWORD").?,
        };
    }
};

pub const config = Config.init();
