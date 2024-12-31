const std = @import("std");

pub fn build_lib(b: *std.Build, target: ?std.Build.ResolvedTarget, optimize: std.builtin.OptimizeMode) *std.Build.Step.Compile {
    const zorx = b.addStaticLibrary(.{
        .name = "zorx",
        .root_source_file = b.path("src/zorx.zig"),
        .target = target,
        .optimize = optimize,
    });

    zorx.addSystemIncludePath(.{ .cwd_relative = "./ext/orx/code/include/"});
    zorx.linkLibC();

    return zorx;
}
