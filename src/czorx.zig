//! By convention, root.zig is the root source file when making a library. If
//! you are making an executable, the convention is to delete this file and
//! start with main.zig instead.
const std = @import("std");
const testing = std.testing;

pub const kernel = @cImport({@cInclude("orxKernel.h");});
pub const orx = @cImport({@cInclude("orx.h");});

// core
pub const core = .{
    .command = @cImport({@cInclude("core/orxCommand.h");}),
    .config = @cImport({@cInclude("core/orxConfig.h");}),
    .console = @cImport({@cInclude("core/orxConsole.h");}),
    .resource = @cImport({@cInclude("core/orxResource.h");}),
    .thread = @cImport({@cInclude("core/orxThread.h");}),
    .locale = @cImport({@cInclude("core/orxLocale.h");}),
    .system = @cImport({@cInclude("core/orxSystem.h");}),
    .clock = @cImport({@cInclude("core/orxClock.h");}),
    .event = @cImport({@cInclude("core/orxEvent.h");}),
};

pub const anim = .{
    .anim = @cImport({@cInclude("anim/orxAnim.h");}),
    .animPointer = @cImport({@cInclude("anim/orxAnimPointer.h");}),
    .animSet = @cImport({@cInclude("anim/orxAnimSet.h");}),
};

pub const base = .{
    .type = @cImport({@cInclude("base/orxType.h");}),
    .decl = @cImport({@cInclude("base/orxDecl.h");}),
    .build = @cImport({@cInclude("base/orxBuild.h");}),
    .module = @cImport({@cInclude("base/orxModule.h");}),
    .version = @cImport({@cInclude("base/orxVersion.h");}),
};

pub const debug = .{
    .FPS = @cImport({@cInclude("debug/orxFPS.h");}),
    .debug = @cImport({@cInclude("debug/orxDebug.h");}),
    .profiler = @cImport({@cInclude("debug/orxProfiler.h");}),
};

pub const display = .{
    .font = @cImport({@cInclude("display/orxFont.h");}),
    .display = @cImport({@cInclude("display/orxDisplay.h");}),
    .texture = @cImport({@cInclude("display/orxTexture.h");}),
    .screenshot = @cImport({@cInclude("display/orxScreenshot.h");}),
    .graphic = @cImport({@cInclude("display/orxGraphic.h");}),
    .text = @cImport({@cInclude("display/orxText.h");}),
};

pub const io = .{
    //io/orxKeyboard.h
    .keyboard = @cImport({@cInclude("io/orxKeyboard.h");}),
    //io/orxInput.h
    .input = @cImport({@cInclude("io/orxInput.h");}),
    //io/orxMouse.h
    .mouse = @cImport({@cInclude("io/orxMouse.h");}),
    //io/orxJoystick.h
    .joystick = @cImport({@cInclude("io/orxJoystick.h");}),
    //io/orxFile.h
    .file = @cImport({@cInclude("io/orxFile.h");}),
};

pub const object = .{
    //object/orxFX.h
    .fx = @cImport({@cInclude("object/orxFX.h");}),
    //object/orxTrigger.h
    .trigger = @cImport({@cInclude("object/orxTrigger.h");}),
    //object/orxObject.h
    .object = @cImport({@cInclude("object/orxObject.h");}),
    //object/orxTimeLine.h
    .timeline = @cImport({@cInclude("object/orxTimeLine.h");}),
    //object/orxFXPointer.h
    .fxpointer = @cImport({@cInclude("object/orxFXPointer.h");}),
    //object/orxFrame.h
    .frame = @cImport({@cInclude("object/orxFrame.h");}),
    //object/orxStructure.h
    .structure = @cImport({@cInclude("object/orxStructure.h");}),
    //object/orxSpawner.h
    .spawner = @cImport({@cInclude("object/orxSpawner.h");}),
};

pub const math = .{
    .aabox = @cImport({@cInclude("math/orxAABox.h");}),
    .vector = @cImport({@cInclude("math/orxVector.h");}),
    .obox = @cImport({@cInclude("math/orxOBox.h");}),
    .math = @cImport({@cInclude("math/orxMath.h");}),
};

pub const memory = .{
    //memory/orxBank.h
    .bank = @cImport({@cInclude("memory/orxBank.h");}),
    //memory/orxMemory.h
    .memory = @cImport({@cInclude("memory/orxMemory.h");}),
};

pub const render = .{
    //render/orxShaderPointer.h
    .shaderpointer = @cImport({@cInclude("render/orxShaderPointer.h");}),
    //render/orxViewport.h
    .viewport = @cImport({@cInclude("render/orxViewport.h");}),
    //render/orxRender.h
    .render = @cImport({@cInclude("render/orxRender.h");}),
    //render/orxShader.h
    .shader = @cImport({@cInclude("render/orxShader.h");}),
    //render/orxCamera.h
    .camera = @cImport({@cInclude("render/orxCamera.h");}),
};

pub const sound = .{
    .soundPointer = @cImport({@cInclude("sound/orxSoundPointer.h");}),
    .soundSystem = @cImport({@cInclude("sound/orxSoundSystem.h");}),
    .sound = @cImport({@cInclude("sound/orxSound.h");}),
};

pub const util = .{
    .string = @cImport({@cInclude("utils/orxString.h");}),
    .hashtable = @cImport({@cInclude("utils/orxHashTable.h");}),
    .linkedlist = @cImport({@cInclude("utils/orxLinkList.h");}),
    .tree = @cImport({@cInclude("utils/orxTree.h");}),
};

//orxPluginAPI.h
//physics/orxBody.h
//physics/orxPhysics.h
//orxUtils.h
//plugin/orxPluginUser.h
//plugin/orxPluginCore.h
//plugin/orxPluginType.h
//plugin/define/orxPlugin_Keyboard.h
//plugin/define/orxPlugin_Joystick.h
//plugin/define/orxPlugin_Render.h
//plugin/define/orxPlugin_Physics.h
//plugin/define/orxPlugin_Display.h
//plugin/define/orxPlugin_Mouse.h
//plugin/define/orxPlugin_CoreDefine.h
//plugin/define/orxPlugin_CoreID.h
//plugin/define/orxPlugin_SoundSystem.h
//plugin/orxPlugin.h
//orxInclude.h

export fn add(a: i32, b: i32) i32 {
    return a + b;
}

test "basic add functionality" {
    try testing.expect(add(3, 7) == 10);
}
