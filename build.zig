const std = @import("std");
const zorx_build = @import("build-lib.zig");

pub fn build(b: *std.Build) void {
    const target: std.Build.ResolvedTarget = b.standardTargetOptions(.{});
    const optimize: std.builtin.OptimizeMode = b.standardOptimizeOption(.{});

    const lib = zorx_build.build_lib(b, target, optimize);

    b.installArtifact(lib);

    const exe = b.addExecutable(.{
        .name = "zorx",
        .root_source_file = b.path("src/main.zig"),
        .target = target,
        .optimize = optimize,
    });

    exe.addSystemIncludePath(.{ .cwd_relative = "./ext/orx/code/include/"});
    exe.addSystemIncludePath(.{ .cwd_relative = "./src/"});
    exe.linkLibC();

    exe.addLibraryPath(.{ .cwd_relative = "./ext/orx/code/lib/dynamic/"});
    exe.linkSystemLibrary("orxd");

    b.installArtifact(exe);
}
