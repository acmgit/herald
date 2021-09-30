local h = herald
local S = h.S
local cname = "template"
local short = "t"
local activate = minetest.settings:get_bool("herald.cmd_" .. cname, true)

if(not activate) then return end

h.register_help({
                            Name = cname,
                            Usage = "/c " .. cname .. " <" .. cname .. ">",
                            Description = S("Template Command with Parameter <" .. cname .. ">."),
                            Parameter = "<" .. cname .. ">",
                            Shortcut = "/c " .. short .. " <" .. cname .. ">",
                        }
                       )

h.registered_commands[cname] = function(player, parameter)

--[[
     *******************************************************
     ***         Insert your code to execute here        ***
     *******************************************************
    parameter = Table with command and parameter(s)
    parameter[1] = command
    parameter[2] = parameter 1
    parameter[3] = parameter 3
    ...
    parameter[x] = parameter x
]]--


end -- h[template

h.registered_commands[short] = function(player, parameter)

        sc.registered_commands[cname](player, parameter)

end -- h.registered_commands[template_shortcut
