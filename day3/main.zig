const std = @import("std");

const input = @embedFile("input.txt");
// const input = "xmul(2,4)%&mul[3,7]!@^do_not_mul(5,5)+mul(32,64]then(mul(11,8)mul(8,5))";
// const input = "xmul(2,4)&mul[3,7]!^don't()_mul(5,5)+mul(32,64](mul(11,8)undo()?mul(8,5))";

test "part1" {
    var i: usize = 0;

    var total: usize = 0;
    while (i < input.len) : (i += 1) {
        // const x = i;

        // parse "mul"
        if (i + 2 >= input.len or !std.mem.eql(u8, input[i .. i + 3], "mul")) {
            continue;
        }
        i += 3;
        if (i >= input.len) break;

        // parse "("
        if (input[i] != '(') continue;
        i += 1;

        // parse left num
        var j: usize = 0;
        while (j < 3) : (j += 1) {
            if (i + j >= input.len) break;
            const c = input[i + j];
            if (c < '0' or '9' < c) break;
        }
        if (j == 0) continue;
        const left = try std.fmt.parseInt(usize, input[i .. i + j], 10);
        i += j;
        if (i >= input.len) break;

        // parse ","
        if (input[i] != ',') continue;
        i += 1;

        // parse right num
        j = 0;
        while (j < 3) : (j += 1) {
            if (i + j >= input.len) break;
            const c = input[i + j];
            if (c < '0' or '9' < c) break;
        }
        if (j == 0) continue;
        const right = try std.fmt.parseInt(usize, input[i .. i + j], 10);
        i += j;
        if (i >= input.len) break;

        // parse ")"
        if (input[i] != ')') continue;

        // std.debug.print("at {}, left {}, right: {} input: {s}\n", .{ i, left, right, input[x .. i + 1] });
        total += left * right;
    }

    std.debug.print("Part 1: {}\n", .{total});
}

test "part2" {
    var i: usize = 0;

    var total: usize = 0;
    var do = true;
    const DONT = "don't()";
    const DO = "do()";
    while (i < input.len) : (i += 1) {
        // const x = i;

        // parse do / don't
        if (i + DO.len < input.len and std.mem.eql(u8, input[i .. i + DO.len], DO)) {
            do = true;
            i += DO.len;
        } else if (i + DONT.len < input.len and std.mem.eql(u8, input[i .. i + DONT.len], DONT)) {
            do = false;
            i += DONT.len;
        }
        // std.debug.print("do: {}\n", .{do});

        // parse "mul"
        if (i + 2 >= input.len or !std.mem.eql(u8, input[i .. i + 3], "mul")) {
            continue;
        }
        i += 3;
        if (i >= input.len) break;

        // parse "("
        if (input[i] != '(') continue;
        i += 1;

        // parse left num
        var j: usize = 0;
        while (j < 3) : (j += 1) {
            if (i + j >= input.len) break;
            const c = input[i + j];
            if (c < '0' or '9' < c) break;
        }
        if (j == 0) continue;
        const left = try std.fmt.parseInt(usize, input[i .. i + j], 10);
        i += j;
        if (i >= input.len) break;

        // parse ","
        if (input[i] != ',') continue;
        i += 1;

        // parse right num
        j = 0;
        while (j < 3) : (j += 1) {
            if (i + j >= input.len) break;
            const c = input[i + j];
            if (c < '0' or '9' < c) break;
        }
        if (j == 0) continue;
        const right = try std.fmt.parseInt(usize, input[i .. i + j], 10);
        i += j;
        if (i >= input.len) break;

        // parse ")"
        if (input[i] != ')') continue;

        // std.debug.print("at {}, left {}, right: {} input: {s}\n", .{ i, left, right, input[x .. i + 1] });
        if (do)
            total += left * right;
    }

    std.debug.print("Part 2: {}\n", .{total});
}
