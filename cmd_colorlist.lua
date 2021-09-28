local h = Herald
local S = h.S
local cname = "colorlist"
local short = "cl"
local activate = minetest.settings:get_bool("herald.cmd_" .. cname, true)

if(not activate) then return end

h.register_help({
                            Name = cname,
                            Usage = "/her " .. cname ,
                            Description = S("Lists all available Colors."),
                            Parameter = "<>",
                            Shortcut = "/her " .. short,
                        }
                       )

h.registered_commands[cname] = function(player, parameter)
    local entry = ""
    h.print(player, h.color["green"] .. S("List of all Heraldcolors:"))

    for k,v in pairs(h.color) do
        entry = v .. k
        h.print(player, entry)
    end


end -- sc["list"

h.registered_commands[short] = function(player, parameter)

        h.registered_commands[cname](player, parameter)

end -- sc["l"
