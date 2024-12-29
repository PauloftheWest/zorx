const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const lib = b.addStaticLibrary(.{
        .name = "zorx",
        // In this case the main source file is merely a path, however, in more
        // complicated build scripts, this could be a generated file.
        .root_source_file = b.path("src/zorx.zig"),
        .target = target,
        .optimize = optimize,
    });

    lib.addSystemIncludePath(.{ .cwd_relative = "./ext/orx/code/include/"});
    lib.linkLibC();

    b.installArtifact(lib);

    const exe = b.addExecutable(.{
        .name = "zorx",
        .root_source_file = b.path("src/main.zig"),
        .target = target,
        .optimize = optimize,
    });

    exe.addSystemIncludePath(.{ .cwd_relative = "./ext/orx/code/include/"});
    exe.addSystemIncludePath(.{ .cwd_relative = "./src/"});
    exe.addLibraryPath(.{ .cwd_relative = "./ext/orx/code/lib/dynamic/"});
    exe.linkLibC();
    exe.linkSystemLibrary("orxd");

    exe.addCSourceFile(.{ .file = .{ .cwd_relative = "src/wrap.c" } });

    b.installArtifact(exe);
}
