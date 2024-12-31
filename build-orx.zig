
    const orxlib = b.addStaticLibrary(.{
        .name = "orx",
        .target = target,
        .optimize = optimize,
    });

    //orxlib.addCSourceFile(.{ .file = .{ .cwd_relative = "src/wrap.c" } });
    orxlib.addSystemIncludePath(.{ .cwd_relative = "ext/orx/code/include/"});
    orxlib.addSystemIncludePath(.{ .cwd_relative = "ext/orx/extern/glfw-3/include/"});
    orxlib.addSystemIncludePath(.{ .cwd_relative = "ext/orx/extern/stb_vorbis/"});
    orxlib.addSystemIncludePath(.{ .cwd_relative = "ext/orx/extern/stb_image/"});
    orxlib.addSystemIncludePath(.{ .cwd_relative = "ext/orx/extern/rpmalloc/rpmalloc/"});
    orxlib.addSystemIncludePath(.{ .cwd_relative = "ext/orx/extern/xxHash/"});
    orxlib.addSystemIncludePath(.{ .cwd_relative = "ext/orx/extern/miniaudio/"});
    orxlib.addSystemIncludePath(.{ .cwd_relative = "ext/orx/extern/qoi/"});
    orxlib.addSystemIncludePath(.{ .cwd_relative = "ext/orx/extern/qoa/"});
    orxlib.addSystemIncludePath(.{ .cwd_relative = "ext/orx/extern/basisu/include/"});

    const orx_defs = &.{ 
        "-D__orxEMBEDDED__",
        "-D_GNU_SOURCE", 
        "-Wno-unused-function",
        "-Wno-unused-but-set-variable",
    };

    orxlib.addCSourceFile(.{ .file = .{ .cwd_relative = "ext/orx/code/build/template/include/extensions/[+bundle lz4]/lz4.c"} , .flags = orx_defs } );
    orxlib.addCSourceFile(.{ .file = .{ .cwd_relative = "ext/orx/code/build/template/include/extensions/[+bundle lz4]/lz4hc.c"}, .flags = orx_defs } );
    //orxlib.addCSourceFile(.{ .file = .{ .cwd_relative = "ext/orx/code/build/template/include/extensions/[+sndh AtariAudio]/external/Musashi/m68kops.c"}, .flags = orx_defs } );
    //orxlib.addCSourceFile(.{ .file = .{ .cwd_relative = "ext/orx/code/build/template/include/extensions/[+sndh AtariAudio]/external/Musashi/m68kfpu.c"}, .flags = orx_defs } );
    //orxlib.addCSourceFile(.{ .file = .{ .cwd_relative = "ext/orx/code/build/template/include/extensions/[+sndh AtariAudio]/external/Musashi/m68kcpu.c"}, .flags = orx_defs } );
    //orxlib.addCSourceFile(.{ .file = .{ .cwd_relative = "ext/orx/code/build/template/include/extensions/[+sndh AtariAudio]/external/ice_24.c"}, .flags = orx_defs } );
    orxlib.addCSourceFile(.{ .file = .{ .cwd_relative = "ext/orx/code/build/template/include/extensions/[+mod ibxm]/ibxm.c"}, .flags = orx_defs } );
    orxlib.addCSourceFile(.{ .file = .{ .cwd_relative = "ext/orx/code/src/core/orxEvent.c"}, .flags = orx_defs } );
    orxlib.addCSourceFile(.{ .file = .{ .cwd_relative = "ext/orx/code/src/core/orxResource.c"}, .flags = orx_defs } );
    orxlib.addCSourceFile(.{ .file = .{ .cwd_relative = "ext/orx/code/src/core/orxConsole.c"}, .flags = orx_defs } );
    orxlib.addCSourceFile(.{ .file = .{ .cwd_relative = "ext/orx/code/src/core/orxThread.c"}, .flags = orx_defs } );
    orxlib.addCSourceFile(.{ .file = .{ .cwd_relative = "ext/orx/code/src/core/orxConfig.c"}, .flags = orx_defs } );
    orxlib.addCSourceFile(.{ .file = .{ .cwd_relative = "ext/orx/code/src/core/orxSystem.c"}, .flags = orx_defs } );
    orxlib.addCSourceFile(.{ .file = .{ .cwd_relative = "ext/orx/code/src/core/orxClock.c"}, .flags = orx_defs } );
    orxlib.addCSourceFile(.{ .file = .{ .cwd_relative = "ext/orx/code/src/core/orxCommand.c"}, .flags = orx_defs } );
    orxlib.addCSourceFile(.{ .file = .{ .cwd_relative = "ext/orx/code/src/core/orxLocale.c"}, .flags = orx_defs } );
    orxlib.addCSourceFile(.{ .file = .{ .cwd_relative = "ext/orx/code/src/display/orxTexture.c"}, .flags = orx_defs } );
    orxlib.addCSourceFile(.{ .file = .{ .cwd_relative = "ext/orx/code/src/display/orxText.c"}, .flags = orx_defs } );
    orxlib.addCSourceFile(.{ .file = .{ .cwd_relative = "ext/orx/code/src/display/orxGraphic.c"}, .flags = orx_defs } );
    orxlib.addCSourceFile(.{ .file = .{ .cwd_relative = "ext/orx/code/src/display/orxDisplay.c"}, .flags = orx_defs } );
    orxlib.addCSourceFile(.{ .file = .{ .cwd_relative = "ext/orx/code/src/display/orxScreenshot.c"}, .flags = orx_defs } );
    orxlib.addCSourceFile(.{ .file = .{ .cwd_relative = "ext/orx/code/src/display/orxFont.c"}, .flags = orx_defs } );
    orxlib.addCSourceFile(.{ .file = .{ .cwd_relative = "ext/orx/code/src/sound/orxSoundPointer.c"}, .flags = orx_defs } );
    orxlib.addCSourceFile(.{ .file = .{ .cwd_relative = "ext/orx/code/src/sound/orxSound.c"}, .flags = orx_defs } );
    orxlib.addCSourceFile(.{ .file = .{ .cwd_relative = "ext/orx/code/src/sound/orxSoundSystem.c"}, .flags = orx_defs } );
    orxlib.addCSourceFile(.{ .file = .{ .cwd_relative = "ext/orx/code/src/anim/orxAnimSet.c"}, .flags = orx_defs } );
    orxlib.addCSourceFile(.{ .file = .{ .cwd_relative = "ext/orx/code/src/anim/orxAnimPointer.c"}, .flags = orx_defs } );
    orxlib.addCSourceFile(.{ .file = .{ .cwd_relative = "ext/orx/code/src/anim/orxAnim.c"}, .flags = orx_defs } );
    orxlib.addCSourceFile(.{ .file = .{ .cwd_relative = "ext/orx/code/src/math/orxMath.c"}, .flags = orx_defs } );
    orxlib.addCSourceFile(.{ .file = .{ .cwd_relative = "ext/orx/code/src/math/orxVector.c"}, .flags = orx_defs } );
    orxlib.addCSourceFile(.{ .file = .{ .cwd_relative = "ext/orx/code/src/object/orxFrame.c"}, .flags = orx_defs } );
    orxlib.addCSourceFile(.{ .file = .{ .cwd_relative = "ext/orx/code/src/object/orxTrigger.c"}, .flags = orx_defs } );
    orxlib.addCSourceFile(.{ .file = .{ .cwd_relative = "ext/orx/code/src/object/orxObject.c"}, .flags = orx_defs } );
    orxlib.addCSourceFile(.{ .file = .{ .cwd_relative = "ext/orx/code/src/object/orxTimeLine.c"}, .flags = orx_defs } );
    orxlib.addCSourceFile(.{ .file = .{ .cwd_relative = "ext/orx/code/src/object/orxSpawner.c"}, .flags = orx_defs } );
    orxlib.addCSourceFile(.{ .file = .{ .cwd_relative = "ext/orx/code/src/object/orxFX.c"}, .flags = orx_defs } );
    orxlib.addCSourceFile(.{ .file = .{ .cwd_relative = "ext/orx/code/src/object/orxStructure.c"}, .flags = orx_defs } );
    orxlib.addCSourceFile(.{ .file = .{ .cwd_relative = "ext/orx/code/src/object/orxFXPointer.c"}, .flags = orx_defs } );
    orxlib.addCSourceFile(.{ .file = .{ .cwd_relative = "ext/orx/code/src/render/orxViewport.c"}, .flags = orx_defs } );
    orxlib.addCSourceFile(.{ .file = .{ .cwd_relative = "ext/orx/code/src/render/orxRender.c"}, .flags = orx_defs } );
    orxlib.addCSourceFile(.{ .file = .{ .cwd_relative = "ext/orx/code/src/render/orxShaderPointer.c"}, .flags = orx_defs } );
    orxlib.addCSourceFile(.{ .file = .{ .cwd_relative = "ext/orx/code/src/render/orxCamera.c"}, .flags = orx_defs } );
    orxlib.addCSourceFile(.{ .file = .{ .cwd_relative = "ext/orx/code/src/render/orxShader.c"}, .flags = orx_defs } );
    orxlib.addCSourceFile(.{ .file = .{ .cwd_relative = "ext/orx/code/src/utils/orxTree.c"}, .flags = orx_defs } );
    orxlib.addCSourceFile(.{ .file = .{ .cwd_relative = "ext/orx/code/src/utils/orxString.c"}, .flags = orx_defs } );
    orxlib.addCSourceFile(.{ .file = .{ .cwd_relative = "ext/orx/code/src/utils/orxHashTable.c"}, .flags = orx_defs } );
    orxlib.addCSourceFile(.{ .file = .{ .cwd_relative = "ext/orx/code/src/utils/orxLinkList.c"}, .flags = orx_defs } );
    //orxlib.addCSourceFile(.{ .file = .{ .cwd_relative = "ext/orx/code/src/main/orxMain.c"}, .flags = orx_defs } );
    orxlib.addCSourceFile(.{ .file = .{ .cwd_relative = "ext/orx/code/src/main/orxParam.c"}, .flags = orx_defs } );
    orxlib.addCSourceFile(.{ .file = .{ .cwd_relative = "ext/orx/code/src/io/orxJoystick.c"}, .flags = orx_defs } );
    orxlib.addCSourceFile(.{ .file = .{ .cwd_relative = "ext/orx/code/src/io/orxInput.c"}, .flags = orx_defs } );
    orxlib.addCSourceFile(.{ .file = .{ .cwd_relative = "ext/orx/code/src/io/orxFile.c"}, .flags = orx_defs } );
    orxlib.addCSourceFile(.{ .file = .{ .cwd_relative = "ext/orx/code/src/io/orxKeyboard.c"}, .flags = orx_defs } );
    orxlib.addCSourceFile(.{ .file = .{ .cwd_relative = "ext/orx/code/src/io/orxMouse.c"}, .flags = orx_defs } );
    orxlib.addCSourceFile(.{ .file = .{ .cwd_relative = "ext/orx/code/src/base/orxType.c"}, .flags = orx_defs } );
    orxlib.addCSourceFile(.{ .file = .{ .cwd_relative = "ext/orx/code/src/base/orxModule.c"}, .flags = orx_defs } );
    orxlib.addCSourceFile(.{ .file = .{ .cwd_relative = "ext/orx/code/src/debug/orxProfiler.c"}, .flags = orx_defs } );
    orxlib.addCSourceFile(.{ .file = .{ .cwd_relative = "ext/orx/code/src/debug/orxFPS.c"}, .flags = orx_defs } );
    orxlib.addCSourceFile(.{ .file = .{ .cwd_relative = "ext/orx/code/src/debug/orxDebug.c"}, .flags = orx_defs } );
    orxlib.addCSourceFile(.{ .file = .{ .cwd_relative = "ext/orx/code/src/physics/orxPhysics.c"}, .flags = orx_defs } );
    orxlib.addCSourceFile(.{ .file = .{ .cwd_relative = "ext/orx/code/src/physics/orxBody.c"}, .flags = orx_defs } );
    orxlib.addCSourceFile(.{ .file = .{ .cwd_relative = "ext/orx/code/src/memory/orxBank.c"}, .flags = orx_defs } );
    orxlib.addCSourceFile(.{ .file = .{ .cwd_relative = "ext/orx/code/src/memory/orxMemory.c"}, .flags = orx_defs } );
    orxlib.addCSourceFile(.{ .file = .{ .cwd_relative = "ext/orx/code/src/plugin/orxPlugin.c"}, .flags = orx_defs } );
    orxlib.addCSourceFile(.{ .file = .{ .cwd_relative = "ext/orx/code/plugins/Mouse/GLFW/orxMouse.c"}, .flags = orx_defs } );
    orxlib.addCSourceFile(.{ .file = .{ .cwd_relative = "ext/orx/code/plugins/Mouse/Dummy/orxMouse.c"}, .flags = orx_defs } );
    //orxlib.addCSourceFile(.{ .file = .{ .cwd_relative = "ext/orx/code/plugins/Mouse/android/orxMouse.c"}, .flags = orx_defs } );
    orxlib.addCSourceFile(.{ .file = .{ .cwd_relative = "ext/orx/code/plugins/Demo/orxBounce.c"}, .flags = orx_defs } );
    orxlib.addCSourceFile(.{ .file = .{ .cwd_relative = "ext/orx/code/plugins/Keyboard/GLFW/orxKeyboard.c"}, .flags = orx_defs } );
    orxlib.addCSourceFile(.{ .file = .{ .cwd_relative = "ext/orx/code/plugins/Keyboard/Dummy/orxKeyboard.c"}, .flags = orx_defs } );
    orxlib.addCSourceFile(.{ .file = .{ .cwd_relative = "ext/orx/code/plugins/Render/Home/orxRender.c"}, .flags = orx_defs } );
    orxlib.addCSourceFile(.{ .file = .{ .cwd_relative = "ext/orx/code/plugins/Physics/Dummy/orxPhysics.c"}, .flags = orx_defs } );
    orxlib.addCSourceFile(.{ .file = .{ .cwd_relative = "ext/orx/code/plugins/Display/GLFW/orxDisplay.c"}, .flags = orx_defs } );
    orxlib.addCSourceFile(.{ .file = .{ .cwd_relative = "ext/orx/code/plugins/Display/Dummy/orxDisplay.c"}, .flags = orx_defs } );
    //orxlib.addCSourceFile(.{ .file = .{ .cwd_relative = "ext/orx/code/plugins/Display/android/orxDisplay.c"}, .flags = orx_defs } );
    orxlib.addCSourceFile(.{ .file = .{ .cwd_relative = "ext/orx/code/plugins/Joystick/GLFW/orxJoystick.c"}, .flags = orx_defs } );
    orxlib.addCSourceFile(.{ .file = .{ .cwd_relative = "ext/orx/code/plugins/Joystick/Dummy/orxJoystick.c"}, .flags = orx_defs } );
    orxlib.addCSourceFile(.{ .file = .{ .cwd_relative = "ext/orx/code/plugins/Sound/MiniAudio/orxSoundSystem.c"}, .flags = orx_defs } );
    orxlib.addCSourceFile(.{ .file = .{ .cwd_relative = "ext/orx/code/plugins/Sound/Dummy/orxSoundSystem.c"}, .flags = orx_defs } );
    orxlib.linkLibC();

    b.installArtifact(orxlib);

    //exe.linkLibrary(orxlib);
    //exe.linkSystemLibrary("GL");
    //exe.linkSystemLibrary("pthread");
    //exe.linkSystemLibrary("rt");
    //exe.linkSystemLibrary("m");
    //exe.linkSystemLibrary("dl");
    //exe.linkSystemLibrary("Xrandr");
    //exe.linkSystemLibrary("X11");
    //exe.addLibraryPath(.{ .cwd_relative = "ext/orx/extern/glfw-3/lib/linux64/"});
    //exe.linkSystemLibrary("glfw3");
    //exe.addLibraryPath(.{ .cwd_relative = "ext/orx/extern/LiquidFun-1.1.0/lib/linux64/"});
    //exe.linkSystemLibrary("liquidfun");
    //exe.addLibraryPath(.{ .cwd_relative = "ext/orx/extern/basisu/lib/linux/64/"});
    //exe.linkSystemLibrary("basisu");
    //exe.addLibraryPath(.{ .cwd_relative = "ext/orx/extern/libwebp/lib/linux64/"});
    //exe.linkSystemLibrary("webpdecoder");
    //exe.linkLibCpp();
