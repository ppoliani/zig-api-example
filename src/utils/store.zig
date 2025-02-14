const Config = @import("./config.zig").Config;
const DbConnection = @import("../storage/connection.zig").DbConnection;

pub const Store = struct {
    config: Config,
    db: DbConnection,

    pub fn init() !Store {
        const config = try Config.init();
        const db = try DbConnection.init(config.db_name, config.db_username, config.db_passowrd);
        return Store{ .config = config, .db = db };
    }
};

pub const store = Store.init() catch unreachable;
