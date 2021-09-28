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
    h.print(player, S("List of all Timers:"))

    for k,v in pairs(h.events) do
        entry = "Name: " .. k .. " Time: " .. v.Time .. " Message: " .. v.color .. v.Msg
        h.print(player, entry)
    end


end -- sc["list"

h.registered_commands[short] = function(player, parameter)

        h.registered_commands[cname](player, parameter)

end -- sc["l"
