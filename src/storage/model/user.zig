pub const User = struct {
    const Self = @This();
    name: []const u8,
    email: []const u8,
    age: u8,

    pub fn create_dummy_user() User {
        return User{
            .name = "pavlos",
            .email = "pavlos@gmail.com",
            .age = 20,
        };
    }
};
