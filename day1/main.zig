const std = @import("std");

const content = @embedFile("input.txt");

test "part1" {
    // const fname = "input.txt";
    const alloc = std.testing.allocator;

    // const content = try std.fs.cwd().readFileAlloc(alloc, fname, 1 * 1024 * 1024);
    // defer alloc.free(content);

    var leftList = std.ArrayList(i64).init(alloc);
    defer leftList.deinit();
    var rightList = std.ArrayList(i64).init(alloc);
    defer rightList.deinit();

    var itLines = std.mem.tokenizeScalar(u8, content, '\n');
    while (itLines.next()) |line| {
        // std.debug.print("{s}\n", .{line});
        var it = std.mem.tokenizeScalar(u8, line, ' ');
        const left = it.next().?;
        const right = it.next().?;
        std.debug.assert(it.next() == null);

        const ileft = try std.fmt.parseInt(i64, left, 10);
        const iright = try std.fmt.parseInt(i64, right, 10);

        try leftList.append(ileft);
        try rightList.append(iright);
    }

    std.sort.heap(i64, leftList.items, {}, less);
    std.sort.heap(i64, rightList.items, {}, less);

    std.debug.assert(leftList.items.len == rightList.items.len);

    var total: i64 = 0;
    for (leftList.items, rightList.items) |a, b| {
        total += if (a < b) b - a else a - b;
    }
    std.debug.print("part1: total: {}\n", .{total});
}

test "part2" {
    const alloc = std.testing.allocator;

    var leftList = std.ArrayList(i64).init(alloc);
    defer leftList.deinit();
    var rightList = std.AutoArrayHashMap(i64, i64).init(alloc);
    defer rightList.deinit();

    var itLines = std.mem.tokenizeScalar(u8, content, '\n');
    while (itLines.next()) |line| {
        // std.debug.print("{s}\n", .{line});
        var it = std.mem.tokenizeScalar(u8, line, ' ');
        const left = it.next().?;
        const right = it.next().?;
        std.debug.assert(it.next() == null);

        const ileft = try std.fmt.parseInt(i64, left, 10);
        const iright = try std.fmt.parseInt(i64, right, 10);

        try leftList.append(ileft);
        const res = try rightList.getOrPut(iright);
        if (!res.found_existing) {
            res.value_ptr.* = 0;
        }
        res.value_ptr.* += 1;
    }

    var total: i64 = 0;
    for (leftList.items) |a| {
        const count = rightList.get(a) orelse 0;
        total += a * count;
    }
    std.debug.print("part2: total: {}\n", .{total});
}

fn less(_: void, a: i64, b: i64) bool {
    return a < b;
}
