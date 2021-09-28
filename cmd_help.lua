local lib = Herald
local S = lib.S
local cname = "help"
local short = "h"
local activate = minetest.settings:get_bool("herald.cmd_" .. cname, true)

if(not activate) then return end
local green = lib.color["green"]
local yellow = lib.color["yellow"]
local orange = lib.color["orange"]

lib.register_help({
                            Name = cname,
                            Usage = "/her " .. cname .. " <> | <command>",
                            Description = S("Helpsystem for ") .." " .. lib.modname .. ".",
                            Parameter = "<> | " .. S("<command>") .. green .. "." ..
                                        "\n" .. orange .. "<>" ..
                                        green.. " - " .. S("Shows you the entire help for ") .. lib.modname ..
                                        "." .. "\n" .. orange .. S("<command>") ..
                                        green .. " - " .. S("Shows you the help for ") ..
                                        lib.modname .. "-" .. S("command") .. ".",
                            Shortcut = "/her " .. short .. " <> | <command>",
                        }
                       )

lib.registered_commands[cname] = function(player, parameter)
    if(parameter[2] == "" or parameter[2] == nil) then
        lib.print(player, green .. S("Commands for ") .. lib.modname .. " " .. orange ..
                        lib.version .. green .. ".")
        for _,value in pairs(lib.helpsystem) do
            lib.print(player, yellow .. "---------------")
            lib.print(player, green .. S("Name: ") .. orange .. value.Name)
            lib.print(player, green .. S("Description: ") .. yellow .. value.Description)
            lib.print(player, green .. S("Usage: ") .. orange .. value.Usage)
            lib.print(player, green .. S("Parameter: ") .. orange .. value.Parameter)
            lib.print(player, green .. S("Shortcut: ") .. orange .. value.Shortcut)

        end -- for _,value

        lib.print(player, yellow .. "---------------")

    else
        if(lib.helpsystem[parameter[2]] ~= nil) then
            lib.print(player, green .. S("Name: ") .. orange ..
                            lib.helpsystem[parameter[2]].Name)
            lib.print(player, green .. S("Description: ") .. yellow ..
                            lib.helpsystem[parameter[2]].Description)
            lib.print(player, green .. S("Usage: ") .. orange ..
                            lib.helpsystem[parameter[2]].Usage)
            lib.print(player, green .. S("Parameter: ") .. orange ..
                            lib.helpsystem[parameter[2]].Parameter)
            lib.print(player, green .. S("Shortcut: ") .. orange ..
                            lib.helpsystem[parameter[2]].Shortcut)

        else
            lib.print(player, lib.red .. S("No entry in help for command") .. " <" ..
                            orange .. parameter[2] .. lib.red .. "> " .. S("found" .. "."))

        end -- if(lib.help[parameter[2

    end -- if(parameter[2]

end -- function help

lib.registered_commands[short] = function(player, parameter)

        lib.registered_commands[cname](player, parameter)

end -- lib["h"
