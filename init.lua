-- *********************
-- ***               ***
-- ***    Herald     ***
-- ***               ***
-- ***    (?) by     ***
-- ***               ***
-- ***    A.C.M.     ***
-- ***               ***
-- *********************


-- An Announcer-System for Minetest(-Server).

Herald = {}

local H = Herald -- omg, i'm really a lazy programmer

H.modname = minetest.get_current_modname()
H.modpath = minetest.get_modpath(H.modname)

H.version = "1.0"

-- Checking all Steps Seconds.
H.steps = 60
H.time = os.date("%H:%M")

H.events = {}
H.helpsystem = {}
H.registered_commands = {}

H.S = nil
local S
if(minetest.get_translator ~= nil) then
    S = minetest.get_translator(H.modname)
    H.S = S
end

dofile(H.modpath .. "/lib.lua")
dofile(H.modpath .. "/cmd_help.lua")
dofile(H.modpath .. "/cmd_list.lua")
dofile(H.modpath .. "/cmd_colorlist.lua")
dofile(H.modpath .. "/cmd_delete.lua")
dofile(H.modpath .. "/cmd_set.lua")
dofile(H.modpath .. "/cmd_change.lua")

H.events = {
                    ["test5"] = {Time = "02:49", color=H.color["green"], Msg = "Test-Event ..."},
                    ["test3"] = {Time = "02:49", color=H.color["yellow"], Msg = "Test-Event 2 ..."},
                    ["test7"] = {Time = "02:50", color=H.color["red"], Msg = "Test-Event 3 ....."},
                    ["test1"] = {Time = "02:49", color=H.color["yellow"], Msg = "Test-Event 2 ..."},
                }

minetest.register_privilege("Herald", S("Manages the Announce-Timer."))

minetest.register_chatcommand("her",{
    param = "<command> <parameter>",
    privs = {
		interact = true,
		shout = true
	},
    description = "Gives Herald a command with or without Parameter." .. "\n",
    func = function(player, cmd)
                H.last_command = cmd
                if(cmd.type == "string") then
                    cmd = cmd:lower()
                end
                local command = H.split(cmd)
                H.check(player, command)

            end -- function

}) -- minetest.register_chatcommand

function H.Update()
    local HTime = os.date("%H:%M")
    H.time = HTime
    local HEvent = H.events

    for k,v in pairs(HEvent) do
        if(v.Time == HTime) then
            H.print_all(v.color .. v.Msg)
        end
    end

end -- function Update ()

local timer = 0

minetest.register_globalstep(function(dtime)
                                 timer = timer + dtime
                                    if timer >= H.steps then
                                        H.Update()
                                        timer = 0
                                    end
                            end)

H.show_version()
