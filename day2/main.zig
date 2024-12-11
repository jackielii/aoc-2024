const std = @import("std");

const input = @embedFile("input.txt");

test "part1" {
    var lines = std.mem.tokenizeScalar(u8, input, '\n');
    var count: usize = 0;
    var report: [10]isize = undefined;
    while (lines.next()) |line| {
        // std.debug.print("{s}\n", .{line});
        var it = std.mem.tokenizeScalar(u8, line, ' ');
        var i: usize = 0;
        while (it.next()) |s| : (i += 1) {
            const n = try std.fmt.parseInt(isize, s, 10);
            report[i] = n;
        }
        if (isSafe(report[0..i]) == .safe) {
            count += 1;
        }
    }
    std.debug.print("part1: {}\n", .{count});
}

test "part2" {
    var lines = std.mem.tokenizeScalar(u8, input, '\n');
    var count: usize = 0;
    var report: [10]isize = undefined;
    while (lines.next()) |line| {
        // std.debug.print("{s}\n", .{line});
        var it = std.mem.tokenizeScalar(u8, line, ' ');
        var i: usize = 0;
        while (it.next()) |s| : (i += 1) {
            const n = try std.fmt.parseInt(isize, s, 10);
            report[i] = n;
        }

        if (isSafe(report[0..i]) == .safe) {
            count += 1;
            continue;
        }
        var j: usize = 0;
        while (j < i) : (j += 1) {
            var report1 = report;
            // std.debug.print("before: {any}\n", .{report1[0..i]});
            std.mem.copyForwards(isize, report1[j..i], report1[j + 1 .. i]);
            // std.debug.print("{}, after: {any}\n", .{ j, report1[0 .. i - 1] });
            if (isSafe(report1[0 .. i - 1]) == .safe) {
                count += 1;
                break;
            }
        }
    }
    std.debug.print("part1: {}\n", .{count});
}

const result = enum {
    safe,
    unsafe,
};

const order = enum {
    unset,
    inc,
    dec,
};

inline fn isSafe(report: []isize) result {
    var i: usize = 0;
    var o: order = .unset;
    // std.debug.print("{any}\t", .{report});
    while (i < report.len - 1) : (i += 1) {
        const a = report[i];
        const b = report[i + 1];
        var d = a - b;
        if (d == 0) {
            // std.debug.print("d=0\n", .{});
            return .unsafe;
        }
        if (o == .unset) {
            o = if (d < 0) .inc else .dec;
        }
        if ((d < 0 and o != .inc) or (d > 0 and o != .dec)) {
            // std.debug.print("not sorted {} {} {}\n", .{ a, b, d });
            return .unsafe;
        }
        d = @abs(d);
        if (d < 1 or d > 3) {
            // std.debug.print("out of range: {}\n", .{d});
            return .unsafe;
        }
    }
    return .safe;
}
