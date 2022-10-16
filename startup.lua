function draw(x,y)

local ccart, ccart_fg, ccart_bg, ccart_adv_fg, ccart_adv_bg, ccart_width
ccart = ([[\159\143\143\143\143\143\143\143\144
\150\136\144     \150
\150\130 \131    \150
\150       \150
\150       \150
\150      \140\150
]]):gsub("\\130", "\130"):gsub("\\131", "\131"):gsub("\\136", "\136"):gsub("\\140", "\140"):gsub("\\143", "\143"):gsub("\\144", "\144"):gsub("\\150", "\149"):gsub("\\159", "\159")

ccart_fg = [[ffffffff7
f00fffff7
f0f0ffff7
ffffffff8
ffffffff8
f888888f8
fffffffff]]

ccart_bg = [[77777777f
7ffffffff
7ffffffff
8ffffffff
8ffffffff
88888888f
fffffffff]]

ccart_adv_fg = [[ffffffff4
f00fffff4
f0f0ffff4
ffffffff4
ffffffff4
f444444d4
fffffffff]]

ccart_adv_bg = [[44444444f
4ffffffff
4ffffffff
4ffffffff
4ffffffff
44444444f
fffffffff]]

ccart_width = 10


local lines, sw, sh = 2, term.getSize()
term.clear()
for i = 1, string.len(ccart), ccart_width do 
    term.setCursorPos(x, lines+y)
    term.blit(string.sub(ccart, i, i+ccart_width-2), string.sub(term.isColor() and ccart_adv_fg or ccart_fg, i, i+ccart_width-2), string.sub(term.isColor() and ccart_adv_bg or ccart_bg, i, i+ccart_width-2))
    print("  ")
    lines = lines + 1
end
end

term.clear()
sleep(0.1)
local old = {}
local workspace = {current=1,n=1}

if fs.exists("/workspace.json") == false then
    file = fs.open("/workspace.json","w")
    file.write(textutils.serialise(workspace))
    file.close()
    fs.makeDir("1")
    fs.copy("/rom","/1/rom")
else
    file = fs.open("/workspace.json","r")
    workspace = textutils.unserialise(file.readAll())
    file.close()
end


function shell.createWorkspace()
    old.makeDir("/"..tostring(workspace.n+1))
    old.copy("/rom","/"..tostring(workspace.n+1).."/rom")
    workspace.n = workspace.n + 1
    file = old.open("/workspace.json","w")
    file.flush()
    file.write(textutils.serialise(workspace))
    file.close()
end

local function getPath(path)
    local resolved = shell.resolve(path)
    return "/"..workspace.current.."/"..resolved
end

local function copy()
    for k,v in pairs(fs) do
        old[k] = v
    end
end

copy()

function shell.getWorkspace()
    return workspace
end

function fs.open(file,mode)
    return old.open(getPath(file),mode)
end

function fs.list(a)
    return old.list(getPath(a))
end

function fs.move(a,b)
    return old.move(getPath(a),getPath(b))
end

function fs.delete(a)
    return old.delete(getPath(a))
end

function fs.exists(a)
    return old.exists(getPath(a))
end

function fs.copy(a,b)
    return old.copy(getPath(a),getPath(b))
end

function fs.isDir(a)
    return old.isDir(getPath(a))
end

function progress()
    w,h = term.getSize()
    draw(w/2-4,h/2-5)
    paintutils.drawBox(w/3,h/2-1+5,w/3*2,h/2+1+5,colors.gray)
    pixels = w/3 -2
    term.setCursorPos(w/3+1,h/2+5)
    for i=0,pixels do
        if math.mod(i,2) == 0 then
            term.setBackgroundColor(colors.green)
        else
            term.setBackgroundColor(colors.lime)
        end
        term.write(" ")
        sleep(60/pixels/60)
    end
end

function bootManager()
    term.clear()
    term.setCursorPos(1,1)
    local n = workspace.current
    w,h = term.getSize()
    term.setCursorPos(1,h)
    term.write("Press F2 for boot options")
    local change = false
    parallel.waitForAny(function() while change == false do e,key = os.pullEvent("key") if key == keys.f2 then change = true end end end,progress)
    if change then
        sleep()
        term.setBackgroundColor(colors.black)
        term.setCursorPos(1,1)
        print("Currently selected workspace: "..n)
        print("Please type the preffered workspace: ")
        id = tonumber(read())
        if workspace.n<id then
            print("Workspace "..id.." doesn't exist. Create it? [Y/N]")
            ev,key = os.pullEvent("key")
            if key == keys.y then
                shell.createWorkspace()
                workspace.current = id
            end
        else
            workspace.current = id
        end
        file = old.open("/workspace.json","w")
        file.flush()
        file.write(textutils.serialise(workspace))
        file.close()
        bootManager()
    end
end

bootManager()
term.setBackgroundColor(colors.black)
term.clear()
term.setCursorPos(1,1)
term.setTextColor(colors.purple)
print("Workspaces v1.0")
term.setTextColor(colors.white)
shell.run("/rom/startup.lua")


