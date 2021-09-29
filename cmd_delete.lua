local h = Herald
local S = h.S
local cname = "delete"
local short = "del"
local activate = minetest.settings:get_bool("herald.cmd_" .. cname, true)

if(not activate) then return end

h.register_help({
                            Name = cname,
                            Usage = "/her " .. cname ,
                            Description = S("Deletes the Timer called <name>."),
                            Parameter = "<name>",
                            Shortcut = "/her " .. short,
                        }
                       )

h.registered_commands[cname] = function(player, parameter)
    local priv = minetest.check_player_privs(player, {Herald=true}) -- Check the Privs, if the Player can do this

    if(not priv) then
        h.print(player, h.color["orange"] .. S("You are not an Herald to do this. Missing privileg Herald."))
        return

    end
    local ename = parameter[2]

    if(h.events[ename]) then
        local ttime = h.events[ename].Time
        local tcol = h.events[ename].Color
        local ttyp = h.events[ename].Typ
        local tMsg = h.events[ename].Msg

        h.print_all(player, h.color["orange"] .. player .. h.color["yellow"] .. " deletes the Timer " ..
                            h.color["orange"] .. ename  .. h.color["yellow"] .. " Time: " ..
                            h.color["orange"] .. ttime .. h.color["yellow"] .. " Typ: " ..
                            h.color["orange"] .. ttyp .. h.color["yellow"] .. " Msg: " ..tcol .. tMsg)

        h.events[ename].Time = nil
        h.events[ename].Color = nil
        h.events[ename].Msg = nil
        h.events[ename].Typ = nil
        h.events[ename] = nil

        minetest.log("action", player .. " has deleted the Timer " .. ename .. " with the Time " ..
                     ttime .. ", Typ " ..  ttyp .. " and the Message " .. tMsg)

        h.Save_Timer()

    else
        h.print(player, h.color["orange"] .. "Timer " .. h.color["yellow"] .. ename ..
                        h.color["orange"] .. " not found!")

    end


end -- sc["delete"

h.registered_commands[short] = function(player, parameter)

        h.registered_commands[cname](player, parameter)

end -- sc["l"
