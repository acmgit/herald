local h = Herald
local S = h.S
local cname = "change"
local short = "c"
local activate = minetest.settings:get_bool("herald.cmd_" .. cname, true)

if(not activate) then return end

h.register_help({
                            Name = cname,
                            Usage = "/her " .. cname ,
                            Description = S("Changes the Timer with the <Name>" ..
                                            "at <Time> and writes the <Message> in this <Color>."),
                            Parameter = S("<Name> <Time> <Color> <Message>"),
                            Shortcut = "/her " .. short,
                        }
                       )

h.registered_commands[cname] = function(player, parameter)
    local priv = minetest.check_player_privs(player, {Herald=true}) -- Check the Privs, if the Player can do this

    if(not priv) then
        h.print(player, h.color["orange"] .. S("You are not an Herald to do this. Missing privileg Herald."))
        return

    end -- if(not priv

    local ename = parameter[2]
    local etime = parameter[3]
    local etyp = parameter[4]
    local ecolor = h.color[parameter[5]]
    local emsg = ""

    for i,v in pairs(parameter) do
        if i >= 6 then
            emsg = emsg .. v .. " "

        end

    end -- for i,v


    if(ename == nil) then h.print(player, h.color["orange"] .. S("No Name for the timer given.")) return end
    if(etime == nil) then h.print(player, h.color["orange"] .. S("No Time for the timer given.")) return end
    if(etyp == nil) then h.print(player, h.color["orange"] .. S("No Typ for the timer given.")) return end
    if(ecolor == nil) then h.print(player, h.color["orange"] .. S("No Color for the Message given.")) return end
    if(emsg == nil) then h.print(player, h.color["orange"] .. S("No Message for the timer given.")) return end

    local exist = false
    for i,v in pairs(h.events) do
        if(i == ename) then
            exist = true

        end

    end

    if(not exist) then h.print(player, h.color["orange"] .. S("There is no Timer with the name ") ..
                               h.color["yellow"] .. ename .. h.color["orange"] .. ".") return end

    h.print_all(player, h.color["orange"] .. player .. h.color["green"] .. S(" has changed the Timer with the Name ") ..
                h.color["orange"] .. ename .. h.color["green"] .. ".")
    h.events[ename] = {Time = etime, Color = ecolor, Typ = etyp, Msg = emsg}
    h.storage:from_table({fields=h.events})
    minetest.log("action",player .. " has changed the Timer " .. ename .. " to Time " ..
                 etime .. ", Typ " .. etyp .. " and the Message " .. emsg)

end -- h["set"

h.registered_commands[short] = function(player, parameter)

        h.registered_commands[cname](player, parameter)

end -- h["s"
