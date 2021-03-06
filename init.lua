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
H.time = nil
H.Weekday = nil
H.Monthday = nil
H.Month = nil

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
dofile(H.modpath .. "/cmd_status.lua")

H.storage = minetest.get_mod_storage()
H.Load_Timer()

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
    H.split_date()                                        -- Update the Time

    if(H.events == nil) then H.events = {} return end

    for k,v in pairs(H.events) do                         -- check the events
        if(v.Time == H.time) then                         -- Fire the Event
            H.print_all("Server"," " .. v.Color .. v.Msg) -- Server is the player
            minetest.log("action", "Timer: " .. k .. " has fired with: " .. v.Msg)

            if(v.Typ:lower()) == "o" then                 -- Timer fires only one time
                H.events[v.Time] = nil
                H.events[v.Color] = nil
                H.events[v.Typ] = nil
                H.events[v.Msg] = nil
                H.events[k] = nil
                H.Save_Timer()

            end -- if(v.Type

        end -- if (v.Time

    end -- for k,v

end -- function Update ()

H.split_date()

local timer = 0

minetest.register_globalstep(function(dtime)
                                 timer = timer + dtime
                                    if timer >= H.steps then
                                        H.Update()
                                        timer = 0
                                    end
                            end)

H.show_version()
