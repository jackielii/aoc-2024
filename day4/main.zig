const std = @import("std");

test "part1" {
    var count: usize = 0;

    // get lines, column_width etc
    const column_width = std.mem.indexOfScalar(u8, input, '\n') orelse @panic("no eol found");
    var lines: [][]const u8 = undefined;
    defer std.testing.allocator.free(lines);
    {
        var list = std.ArrayList([]const u8).init(std.testing.allocator);
        defer list.deinit();
        var it = std.mem.splitScalar(u8, input, '\n');
        var i: usize = 0;
        while (it.next()) |line| {
            i += 1;
            if (line.len != column_width) { // last line
                continue;
            }
            try list.append(line);
        }
        lines = try list.toOwnedSlice();
    }

    // horizontal
    {
        var i: usize = 0;
        while (i < lines.len) : (i += 1) {
            var j: usize = 0;
            while (j < column_width - 3) : (j += 1) {
                if (lines[i][j] == 'X' and
                    lines[i][j + 1] == 'M' and
                    lines[i][j + 2] == 'A' and
                    lines[i][j + 3] == 'S')
                {
                    // std.debug.print("  line:{}, col: {}\n", .{ i, j });
                    count += 1;
                }
            }
        }
    }
    // std.debug.print("horizontal: {}\n", .{count});

    // vertical
    {
        var i: usize = 0;
        while (i < lines.len - 3) : (i += 1) {
            var j: usize = 0;
            while (j < column_width) : (j += 1) {
                if (lines[i][j] == 'X' and
                    lines[i + 1][j] == 'M' and
                    lines[i + 2][j] == 'A' and
                    lines[i + 3][j] == 'S')
                {
                    // std.debug.print("  line:{}, col: {}\n", .{ i, j });
                    count += 1;
                }
            }
        }
    }
    // std.debug.print("vertical: {}\n", .{count});

    // right diagonal
    {
        var i: usize = 0;
        while (i < lines.len - 3) : (i += 1) {
            var j: usize = 0;
            while (j < column_width - 3) : (j += 1) {
                if (lines[i][j] == 'X' and
                    lines[i + 1][j + 1] == 'M' and
                    lines[i + 2][j + 2] == 'A' and
                    lines[i + 3][j + 3] == 'S')
                {
                    // std.debug.print("  line:{}, col: {}\n", .{ i, j });
                    count += 1;
                }
            }
        }
    }
    // std.debug.print("right diagonal: {}\n", .{count});

    // left diagonal
    {
        var i: usize = 0;
        while (i < lines.len - 3) : (i += 1) {
            var j: usize = column_width;
            while (j > 3) {
                j -= 1;
                if (lines[i][j] == 'X' and
                    lines[i + 1][j - 1] == 'M' and
                    lines[i + 2][j - 2] == 'A' and
                    lines[i + 3][j - 3] == 'S')
                {
                    // std.debug.print("  line:{}, col: {}\n", .{ i, j });
                    count += 1;
                }
            }
        }
    }
    // std.debug.print("left diagonal: {}\n", .{count});

    // reverse
    {
        var i: usize = 0;
        while (i < lines.len) : (i += 1) {
            var j: usize = column_width;
            while (j > 3) {
                j -= 1;
                if (lines[i][j] == 'X' and
                    lines[i][j - 1] == 'M' and
                    lines[i][j - 2] == 'A' and
                    lines[i][j - 3] == 'S')
                {
                    // std.debug.print("  line:{}, col: {}\n", .{ i, j });
                    count += 1;
                }
            }
        }
    }
    // std.debug.print("reverse horizontal: {}\n", .{count});

    // reverse vertical
    {
        var i: usize = lines.len;
        while (i > 3) {
            i -= 1;
            var j: usize = column_width;
            while (j > 0) {
                j -= 1;
                if (lines[i][j] == 'X' and
                    lines[i - 1][j] == 'M' and
                    lines[i - 2][j] == 'A' and
                    lines[i - 3][j] == 'S')
                {
                    // std.debug.print("  line:{}, col: {}\n", .{ i, j });
                    count += 1;
                }
            }
        }
    }

    // reverse right diagonal
    {
        var i: usize = lines.len;
        while (i > 3) {
            i -= 1;
            var j: usize = 0;
            while (j < column_width - 3) : (j += 1) {
                if (lines[i][j] == 'X' and
                    lines[i - 1][j + 1] == 'M' and
                    lines[i - 2][j + 2] == 'A' and
                    lines[i - 3][j + 3] == 'S')
                {
                    // std.debug.print("  line:{}, col: {}\n", .{ i, j });
                    count += 1;
                }
            }
        }
    }
    // std.debug.print("reverse right diagonal:{}\n", .{count});

    // reverse left diagonal
    {
        var i: usize = lines.len;
        while (i > 3) {
            i -= 1;
            var j: usize = column_width;
            while (j > 3) {
                j -= 1;
                if (lines[i][j] == 'X' and
                    lines[i - 1][j - 1] == 'M' and
                    lines[i - 2][j - 2] == 'A' and
                    lines[i - 3][j - 3] == 'S')
                {
                    // std.debug.print("  line:{}, col: {}\n", .{ i, j });
                    count += 1;
                }
            }
        }
    }
    // std.debug.print("reverse left diagonal: {}\n", .{count});

    std.debug.print("part1: {}\n", .{count});
}

// // const example = "XMAS";
// const example =
//     \\MMMSXXMASM
//     \\MSAMXMSMSA
//     \\AMXSXMAAMM
//     \\MSAMASMSMX
//     \\XMASAMXAMM
//     \\XXAMMXXAMA
//     \\SMSMSASXSS
//     \\SAXAMASAAA
//     \\MAMMMXMMMM
//     \\MXMXAXMASX
// ;
// const input = example;
const input = @embedFile("input.txt");

test "part2" {
    // get lines, column_width etc
    const column_width = std.mem.indexOfScalar(u8, input, '\n') orelse @panic("no eol found");
    var lines: [][]const u8 = undefined;
    defer std.testing.allocator.free(lines);
    {
        var list = std.ArrayList([]const u8).init(std.testing.allocator);
        defer list.deinit();
        var it = std.mem.splitScalar(u8, input, '\n');
        var i: usize = 0;
        while (it.next()) |line| {
            i += 1;
            if (line.len != column_width) { // last line
                continue;
            }
            try list.append(line);
        }
        lines = try list.toOwnedSlice();
    }

    var count: usize = 0;
    {
        var i: usize = 0;
        while (i < lines.len - 2) : (i += 1) {
            var j: usize = 0;
            while (j < column_width - 2) : (j += 1) {
                // down
                if (lines[i][j] == 'M' and
                    lines[i][j + 2] == 'M' and
                    lines[i + 1][j + 1] == 'A' and
                    lines[i + 2][j] == 'S' and
                    lines[i + 2][j + 2] == 'S')
                {
                    // std.debug.print("  line:{}, col: {}\n", .{ i, j });
                    count += 1;
                }
                // right
                if (lines[i][j] == 'M' and
                    lines[i][j + 2] == 'S' and
                    lines[i + 1][j + 1] == 'A' and
                    lines[i + 2][j] == 'M' and
                    lines[i + 2][j + 2] == 'S')
                {
                    // std.debug.print("  line:{}, col: {}\n", .{ i, j });
                    count += 1;
                }
                // left
                if (lines[i][j] == 'S' and
                    lines[i][j + 2] == 'M' and
                    lines[i + 1][j + 1] == 'A' and
                    lines[i + 2][j] == 'S' and
                    lines[i + 2][j + 2] == 'M')
                {
                    // std.debug.print("  line:{}, col: {}\n", .{ i, j });
                    count += 1;
                }
                // up
                if (lines[i][j] == 'S' and
                    lines[i][j + 2] == 'S' and
                    lines[i + 1][j + 1] == 'A' and
                    lines[i + 2][j] == 'M' and
                    lines[i + 2][j + 2] == 'M')
                {
                    // std.debug.print("  line:{}, col: {}\n", .{ i, j });
                    count += 1;
                }
            }
        }
    }

    std.debug.print("part2: {}\n", .{count});
}
