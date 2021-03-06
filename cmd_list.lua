local h = Herald
local S = h.S
local cname = "list"
local short = "li"
local activate = minetest.settings:get_bool("herald.cmd_" .. cname, true)

if(not activate) then return end

h.register_help({
                            Name = cname,
                            Usage = "/her " .. cname ,
                            Description = S("Lists all stored Timer."),
                            Parameter = "<>",
                            Shortcut = "/her " .. short,
                        }
                       )

h.registered_commands[cname] = function(player, parameter)
    local entry = ""
    h.print(player, h.color["green"] .. S("List of all Timers:"))
    if(h.events == nil) then return end

    for k,v in pairs(h.events) do
        entry = h.color["orange"] .. "Name: " .. h.color["yellow"] .. k ..
                h.color["orange"] .. " Time: " .. h.color["yellow"] .. v.Time ..
                h.color["orange"] .. " Typ: " .. h.color["yellow"] .. v.Typ ..
                h.color["orange"] .. " Message: " .. h.color["yellow"] .. v.Color .. v.Msg
        h.print(player, entry)

    end -- for k,v in

end -- function h.registerd_commands["list"

h.registered_commands[short] = function(player, parameter)

        h.registered_commands[cname](player, parameter)

end -- h.registered_commands["l"
