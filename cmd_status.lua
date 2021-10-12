local h = Herald
local S = h.S
local cname = "status"
local short = "st"
local activate = minetest.settings:get_bool("herald.cmd_" .. cname, true)

if(not activate) then return end

h.register_help({
                            Name = cname,
                            Usage = "/her " .. cname ,
                            Description = S("Show's you more Info's about Herald."),
                            Parameter = "<>",
                            Shortcut = "/her " .. short,
                        }
                       )

h.registered_commands[cname] = function(player, parameter)
    local wd = h.weekday
    local md = h.monthday
    local mo = h.month
    local ti = h.time               -- Time
    local pe = 0                    -- permanent Timer
    local on = 0                    -- not permanent Timer
    local ver = h.version           -- Version of Herald
    local at = 0                    -- All Timer

    if(h.events ~= nil) then
        for k,v in pairs(h.events) do
            if(v.Typ == "o") then         -- is Timer not permanent?
                on = on + 1

            else -- if(v.Typ
                pe = pe + 1             -- is a permanent Timer

            end -- if(v.Typ
            at = at + 1                 -- count all Timer

        end -- for k,v

    end -- if(h.events)

    local w = {}
    w = {   S("Sunday"), S("Monday"), S("Tuesday"), S("Wednesday"),
            S("Thursday"), S("Friday"), S("Saturday")}

    local m = {}
    m = {  S("January"), S("February"), S("March"),
           S("April"), S("Mai"), S("June"),
           S("July"), S("August"), S("September"),
           S("October"), S("November"), S("December")}

    h.print(player, h.color["green"] .. S("Status of Herald:") .. "\n")
    h.print(player, h.color["orange"] .. S("Current Month") .. "       : " ..
            h.color["yellow"] .. mo .. " = " .. m[tonumber(mo)])
    h.print(player, h.color["orange"] .. S("Current Day") .. "         : " .. h.color["yellow"] .. md)
    h.print(player, h.color["orange"] .. S("Current Weekday") .. "     : " ..
            h.color["yellow"] .. wd .. " = " .. w[tonumber(wd)+1])
    h.print(player, h.color["orange"] .. S("Current Time") .. "        : " .. h.color["yellow"] .. ti)
    h.print(player, h.color["orange"] .. S("Timers") .. "              : " .. h.color["yellow"] .. at)
    h.print(player, h.color["orange"] .. S("Permanent Timer") .. "     : " .. h.color["yellow"] .. pe)
    h.print(player, h.color["orange"] .. S("Not permanent Timer") .. " : " .. h.color["yellow"] .. on)
    h.print(player, h.color["orange"] .. S("Version") .. "             : " .. h.color["yellow"] .. ver)

end -- function h.registerd_commands["Status"

h.registered_commands[short] = function(player, parameter)

        h.registered_commands[cname](player, parameter)

end -- h.registered_commands["st"
