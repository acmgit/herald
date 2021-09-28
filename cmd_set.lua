local h = Herald
local S = h.S
local cname = "set"
local short = "s"
local activate = minetest.settings:get_bool("herald.cmd_" .. cname, true)

if(not activate) then return end

h.register_help({
                            Name = cname,
                            Usage = "/her " .. cname ,
                            Description = S("Set's a new Timer with the <Name> at" ..
                                            " <Time> and writes the <Message> in this <Color>."),
                            Parameter = S("<Name> <Time> <Color> <Message>"),
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
    local etime = parameter[3]
    local ecolor = h.color[parameter[4]]
    local emsg = ""

    for i,v in pairs(parameter) do
        if i >= 5 then
            emsg = emsg .. v .. " "

        end

    end


    if(ename == nil) then h.print(player, h.color["orange"] .. S("No Name for the timer given.")) return end
    if(etime == nil) then h.print(player, h.color["orange"] .. S("No Time for the timer given.")) return end
    if(ecolor == nil) then h.print(player, h.color["orange"] .. S("No Color for the Message given.")) return end
    if(emsg == nil) then h.print(player, h.color["orange"] .. S("No Message for the timer given.")) return end

    for i,v in pairs(h.events) do
        if(i == ename) then
            h.print(player, h.color["orange"] .. S("Take care, the Timername exists !!"))
            return

        end

    end

    h.print_all(h.color["orange"] .. player .. h.color["green"] .. S(" has set a new Timer with the Name ") ..
                h.color["orange"] .. ename .. h.color["green"] .. ".")
    h.events[ename] = {Time = etime, color = ecolor, Msg = emsg}
    minetest.log("action", player .. " has set a new Timer " .. ename .. " to Time " .. etime .. " and the Message " .. emsg)
    h.storage:from_table({fields=h.events})

end -- h["set"

h.registered_commands[short] = function(player, parameter)

        h.registered_commands[cname](player, parameter)

end -- h["s"
