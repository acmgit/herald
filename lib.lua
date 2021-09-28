local lib = Herald
local mn = lib.modname
local S = lib.S

--[[
   ****************************************************************
   *******              List of Colors                       ******
   ****************************************************************
]]--

lib.color = {}
lib.color["green"] = minetest.get_color_escape_sequence('#00FF00')
lib.color["red"] = minetest.get_color_escape_sequence('#FF0000')
lib.color["orange"] = minetest.get_color_escape_sequence('#FF6700')
lib.color["blue"] = minetest.get_color_escape_sequence('#0000FF')
lib.color["yellow"] = minetest.get_color_escape_sequence('#FFFF00')
lib.color["purple"] = minetest.get_color_escape_sequence('#FF00FF')
lib.color["pink"] = minetest.get_color_escape_sequence('#FFAAFF')
lib.color["white"] = minetest.get_color_escape_sequence('#FFFFFF')
lib.color["black"] = minetest.get_color_escape_sequence('#000000')
lib.color["grey"] = minetest.get_color_escape_sequence('#888888')
lib.color["light_blue"] = minetest.get_color_escape_sequence('#8888FF')
lib.color["light_green"] = minetest.get_color_escape_sequence('#88FF88')
lib.color["light_red"] = minetest.get_color_escape_sequence('#FF8888')

--[[
   ****************************************************************
   *******        Function split(parameter)                  ******
   ****************************************************************
    Split Command and Parameter and write it to a table
--]]
function lib.split(parameter)
        local cmd = {}
        for word in string.gmatch(parameter, "[%w%-%:%.2f%_%,%ä%ö%ü%Ä%Ö%Ü]+") do
            table.insert(cmd, word)

        end -- for word

        return cmd

end -- function lib.split

--[[
    ****************************************************************
    *******        Function check(command)                    ******
    ****************************************************************
    Check if the command is valid
--]]
function lib.check(player, cmd)
        local red = lib.color["red"]
        local orange = lib.color["orange"]

        if(cmd ~= nil and cmd[1] ~= nil) then
            if(lib.registered_commands[cmd[1]] ~= nil) then
                -- Command is valid, execute it with parameter
                lib.registered_commands[cmd[1]](player, cmd)

            else -- A command is given, but
            -- Command not found, report it.
                if(cmd[1] ~= nil) then
                    lib.print(player, red .. mn ..": " .. S("Unknown Command") .. " \"" ..
                                    orange .. cmd[1] .. red .. "\".")

                else
                    if(lib.registered_commands["help"]) then
                        lib.registered_commands["help"](player, cmd)

                    else
                        lib.print(player, lib.red .. S("Unknown Command. No helpsystem available."))

                    end --if(distancer["help"]

                end -- if(cmd[1]

            end -- if(distancer[cmd[1

        else
            lib.print(player, lib.color["red"] .. S("No Command for ") .. mn .. S(" given."))
            lib.print(player, lib.color["red"] .. S("Try /her help."))

        end -- if(not cmd)

end -- function lib.check(cmd

--[[
   ****************************************************************
   *******         Function register_help()                  ******
   ****************************************************************
    Registers a new Entry in the Helpsystem for an Command.
]]--
function lib.register_help(entry)

    lib.helpsystem[entry.Name] = {
                                Name = entry.Name,
                                Usage = entry.Usage,
                                Description = entry.Description,
                                Parameter = entry.Parameter,
                                Shortcut = entry.Shortcut,
                            }

end

--[[
   ****************************************************************
   *******     Function display_chat_message(message)        ******
   ****************************************************************
]]--

function lib.print(player, text)
    local lprint = minetest.chat_send_player
    --local playername = minetest.get_player_by_name(player)
    lprint(player, text)

end -- function print(

function lib.print_all(text)
    local lprint = minetest.chat_send_all
    lprint(text)
end


--[[
   ****************************************************************
   *******         Function show_version()                   ******
   ****************************************************************
]]--

function lib.show_version()
    print("[MOD]" .. lib.modname .. " v " .. lib.version .. " loaded. \n")
    minetest.log("ACTION","[MOD]" .. lib.modname .. " v " .. lib.version .. " loaded.")
    
end -- lib.show_version
