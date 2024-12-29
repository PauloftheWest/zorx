//! By convention, root.zig is the root source file when making a library. If
//! you are making an executable, the convention is to delete this file and
//! start with main.zig instead.
const std = @import("std");
const C = @import("czorx.zig");
const wrap = @cImport({@cInclude("wrap.h");});
const testing = std.testing;

var keep_going: bool = true;
var base_dir: []u8 = undefined;
var main_config: []u8 = undefined;

fn orx_bootstrap(...) callconv(.c) C.base.type.orxSTATUS {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
	const allocator = gpa.allocator();

    const bdir = allocator.alloc(u8, base_dir.len + 1) catch {
        return C.base.type.orxSTATUS_FAILURE;
    };
    defer allocator.free(bdir);

    std.mem.copyForwards(u8, bdir, base_dir);
    bdir[bdir.len - 1] = 0;

    // Add config storage to find the initial config file
    //TODO: This doesn't check for directory's existence.
    if (C.core.resource.orxResource_AddStorage(C.core.config.orxCONFIG_KZ_RESOURCE_GROUP, bdir.ptr, C.base.type.orxFALSE) == C.base.type.orxSTATUS_FAILURE) {
        log("Unable to load config directory!");
    }
    return C.base.type.orxSTATUS_SUCCESS;
}

//void orxFASTCALL Update(const orxCLOCK_INFO *_pstClockInfo, void *_pContext)
fn orx_update(pstClockInfo: [*c]const C.core.clock.orxCLOCK_INFO, p: ?*anyopaque) callconv(.c) void {
    _ = pstClockInfo;
    _ = p;

    if (C.io.input.orxInput_HasBeenActivated("Quit") == C.base.type.orxTRUE) {
        //orxEvent_SendShort(orxEVENT_TYPE_SYSTEM, orxSYSTEM_EVENT_CLOSE);
        _ = C.core.event.orxEvent_SendShort(C.core.event.orxEVENT_TYPE_SYSTEM, C.core.system.orxSYSTEM_EVENT_CLOSE);
    }

}

fn orx_init(...) callconv(.c) C.base.type.orxSTATUS {

    // Register the Update function to the core clock
    if (C.core.clock.orxClock_Register(
        C.core.clock.orxClock_Get(C.core.clock.orxCLOCK_KZ_CORE), 
        orx_update, 
        null, 
        C.base.module.orxMODULE_ID_MAIN,
        C.core.clock.orxCLOCK_PRIORITY_NORMAL) == C.base.type.orxSTATUS_FAILURE) {
        log("Unable to register clock!");
        return C.base.type.orxSTATUS_FAILURE;
    }

    // Create the scene
    _ = C.object.object.orxObject_CreateFromConfig("Scene");

    // Create the viewport
    _ = C.render.viewport.orxViewport_CreateFromConfig("MainViewport");

    return C.base.type.orxSTATUS_SUCCESS;
}

fn orx_run() C.base.type.orxSTATUS {
    return C.base.type.orxSTATUS_SUCCESS;
}

fn orx_exit(...) callconv(.c) void {
}

fn orx_main_setup(...) callconv(.c) void {
    C.base.module.orxModule_AddDependency(C.base.module.orxMODULE_ID_MAIN, C.base.module.orxMODULE_ID_INPUT);
    C.base.module.orxModule_AddDependency(C.base.module.orxMODULE_ID_MAIN, C.base.module.orxMODULE_ID_LOCALE);
    C.base.module.orxModule_AddDependency(C.base.module.orxMODULE_ID_MAIN, C.base.module.orxMODULE_ID_OBJECT);

    C.base.module.orxModule_AddOptionalDependency(C.base.module.orxMODULE_ID_MAIN, C.base.module.orxMODULE_ID_RENDER);
    C.base.module.orxModule_AddOptionalDependency(C.base.module.orxMODULE_ID_MAIN, C.base.module.orxMODULE_ID_SCREENSHOT);
}

pub fn log(format: [*c]const u8) void {
    const src = @src();
    C.debug.debug._orxDebug_Log(C.debug.debug.orxDEBUG_LEVEL_LOG, src.fn_name, src.file, src.line, format);
}

fn orx_DefaultEventHandler(p: [*c]const C.core.event.orxEVENT) callconv(.c) c_uint {
    if (p.*.eType == C.core.event.orxEVENT_TYPE_SYSTEM
        and p.*.eID == C.core.system.orxSYSTEM_EVENT_CLOSE) {
        keep_going = false;
    }

    return C.base.type.orxSTATUS_SUCCESS;
}

const orxEvent = extern union {
    u32FrameCount: u32,
    stTouch : extern struct {
        dTime: f64,
        u32ID: u32,
        fX: f32,
        fY: f32,
        fPressure: f32,
    },
    stAccelerometer: extern struct {
        dTime: f64,
        vAcceleration: C.math.vector.orxVECTOR,
    },
    stDrop: extern struct {
        azValueList: *[*]const u8,
        u32Number: u32,
    },
    stClipboard: extern struct {
        zValue: [*]const u8,
    },
};

pub fn init(ini_path: []u8) !void {
    // Must get the base_dir and main config for bootstraping.
    var pos: usize = 0;

    for (0..ini_path.len) |i| {
        if (ini_path[i] == '/' or ini_path[i] == '\\') {
            pos = i;
        }
    }

    base_dir = ini_path[0..pos+1];
    main_config = ini_path[pos+1..];

    _ = C.core.config.orxConfig_SetBootstrap(orx_bootstrap);
    _ = C.debug.debug._orxDebug_Init();

    log("zorx initializing");

    C.base.module.orxModule_Register(C.base.module.orxMODULE_ID_MAIN, "MAIN", orx_main_setup, orx_init, orx_exit);

    const orx_args: [1] [*c]u8 = .{@constCast(main_config.ptr)};
    _ = C.orx.orxParam_SetArgs(1, @constCast(@ptrCast(&orx_args)));

//#ifdef __orxSTATIC__
    // Silences param & plugin warnings 
    //orxDEBUG_ENABLE_LEVEL(orxDEBUG_LEVEL_PLUGIN, orxFALSE);
    //orxDEBUG_ENABLE_LEVEL(orxDEBUG_LEVEL_PARAM, orxFALSE);
//#endif /* __orxSTATIC */

    // Inits the engine 
    if (C.base.module.orxModule_Init(C.base.module.orxMODULE_ID_MAIN) == C.base.type.orxSTATUS_FAILURE) {
        log("Failed to intialize main module!");
        return;
    }

    var stPayload: orxEvent = undefined;
    var eClockStatus: C.base.type.orxSTATUS = C.base.type.orxSTATUS_SUCCESS;
    //var eMainStatus: C.base.type.orxSTATUS;

    // Registers default event handler 
    if (C.core.event.orxEvent_AddHandler(C.core.event.orxEVENT_TYPE_SYSTEM, orx_DefaultEventHandler) == C.base.type.orxSTATUS_FAILURE) {
        log("Failed to add event system.");
        return;
    }

    if (C.core.event.orxEvent_SetHandlerIDFlags(orx_DefaultEventHandler, 
        C.core.event.orxEVENT_TYPE_SYSTEM, 
        null, 
        1 << C.core.system.orxSYSTEM_EVENT_CLOSE,
        C.core.event.orxEVENT_KU32_MASK_ID_ALL) == C.base.type.orxSTATUS_FAILURE) {
        log("Failed to set handler flags for default event handler.");
        return;
    }

    // Clears payload 
    _ = C.memory.memory.orxMemory_Zero(&stPayload, @sizeOf(C.core.system.orxSYSTEM_EVENT_PAYLOAD));

    // Main loop 
    while (keep_going) {
        // Sends frame start event 
        var event: C.core.event.orxEVENT = .{
            .eType = C.core.event.orxEVENT_TYPE_SYSTEM,
            .eID = C.core.system.orxSYSTEM_EVENT_GAME_LOOP_START,
            .hSender = null,
            .hRecipient = null,
            .pstPayload = &stPayload,
        };

        if (C.core.event.orxEvent_Send(@ptrCast(&event)) == C.base.type.orxSTATUS_FAILURE) {
            log("Unable to send Game loop start event.");
        }

        // Runs game specific code 
        _ = orx_run();

        // Updates clock system 
        eClockStatus = C.core.clock.orxClock_Update();

        // Sends frame stop event
        // TODO: Does a new event need to be created?
        event = .{
            .eType = C.core.event.orxEVENT_TYPE_SYSTEM,
            .eID = C.core.system.orxSYSTEM_EVENT_GAME_LOOP_STOP,
            .hSender = null,
            .hRecipient = null,
            .pstPayload = &stPayload,
        };

        if (C.core.event.orxEvent_Send(@ptrCast(&event)) == C.base.type.orxSTATUS_FAILURE) {
            log("Unable to send Game loop stop event.");
        }

        // Updates frame count 
        stPayload.u32FrameCount += 1;
    }

    // Removes event handler 
    _ = C.core.event.orxEvent_RemoveHandler(C.core.event.orxEVENT_TYPE_SYSTEM, orx_DefaultEventHandler);

    // Exits from the engine 
    C.base.module.orxModule_Exit(C.base.module.orxMODULE_ID_MAIN);

    log("zorx Exiting");
    _ = C.debug.debug._orxDebug_Exit();
}
