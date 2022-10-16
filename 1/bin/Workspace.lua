
local function redirect(obj)
    term.redirect(obj)
    obj.redraw()
    term.setCursorPos(obj.getCursorPos())
    term.setCursorBlink(obj.getCursorBlink())
end

function _G.debug.debugProgram(sProgram)
    root = term.current()
    redirect(DebugView)
    print()
    print(sProgram)
    print()
    coroutine.resume(main2,"debug",sProgram)
    local bRunning = true
    while bRunning do
        s = table.pack(os.pullEventRaw())
        if s[1] ~= "debugFinish" then
            coroutine.resume(main2,table.unpack(s))
        else
            bRunning = false
        end
    end
    redirect(root)
end


cur = term.current()
wx,wy = cur.getSize()
MainView = window.create(cur,1,1,wx/3*2,wy)
DebugView = window.create(cur,wx/3*2+2,1,wx/3  ,wy )
cur.setBackgroundColor(colors.gray)
cur.clear() 
MainView.setBackgroundColor(colors.black)
MainView.clear()
DebugView.setBackgroundColor(colors.black)
DebugView.clear()
redirect(MainView)
main = coroutine.create(function () shell.run("multishell") end)
coroutine.resume(main)
redirect(DebugView)
main2 = coroutine.create(function () shell.run("multishell /bin/data/Debug.lua") end)
coroutine.resume(main2)
redirect(MainView)
currentMain = 1
while true do
    raw = table.pack(os.pullEventRaw())
    
    if raw[1] == "key" then
    if raw[2] == keys.leftAlt then
        if currentMain == 1 then
            currentMain = 0
            redirect(DebugView)
        else
            currentMain = 1
            redirect(MainView)
        end
    end
    end
    if raw[1] == "mouse_drag" or raw[1] == "mouse_click" or raw[1] == "mouse_up" then
        
    end
    
    if coroutine.status(main) == "dead" then
            return
    end
    
    if currentMain == 1 then
        coroutine.resume(main,table.unpack(raw))
    else
        coroutine.resume(main2,table.unpack(raw))
    end
end
term.redirect(cur)
