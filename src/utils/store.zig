const Config = @import("./config.zig").Config;
const DbPool = @import("../storage/connection.zig").DbPool;

pub const Store = struct {
    config: Config,
    db: DbPool,

    pub fn init() !Store {
        const config = try Config.init();
        const db = try DbPool.init(config.db_name, config.db_username, config.db_passowrd);
        return Store{ .config = config, .db = db };
    }

    pub fn deinit(self: Store) void {
        self.db.deinit();
    }
};

pub const store = Store.init() catch unreachable;
