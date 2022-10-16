term.setBackgroundColor(colors.gray)
term.clear()

function redirect(win)
    term.redirect(win.win)
    term.setBackgroundColor(win.win.getBackgroundColor())
    term.setTextColor(win.win.getTextColor())
    term.setCursorBlink(win.win.getCursorBlink())
    term.setCursorPos(win.win.getCursorPos())
end

function initiateWindow(win)
    redirect(win)
    coroutine.resume(win.thread)
end

function createWindow(x,y,w,h,file)
    win = {}
    win.win = window.create(cur,x,y,w,h)
    win.thread = coroutine.create(function () shell.run(file) end)
    initiateWindow(win)
    return win
end

wins = {}
curWin = 1
cur = term.current()

bRunning = true
while bRunning do
    a,mkey,mx,my = event.pull()
    if a == "mouse_click" then
        x = mx
        y = my
        b,c,mx,my = event.pull("mouse_click")
        w = mx - x
        h = my - y
        paintutils.drawBox(x,y,mx,my,colors.white)
        term.setCursorPos(x,y)
        term.write("Program: ")
        run = read()
        wins[table.getn(wins)+1] = createWindow(x,y,w,h,run)
    end
    if a == "key" and mkey == keys.enter then
        bRunning = false
    end
end

redirect(wins[curWin])

--main loop
bRunning = true
while bRunning do
    raw = table.pack(event.pullraw())
    if raw[1] == "key" and raw[2] == keys.leftAlt then
        if table.getn(wins) == 1 then
        elseif curWin == table.getn(wins) then curWin = 1
        else curWin = curWin + 1
        end
        redirect(wins[curWin])
    end
    coroutine.resume(wins[curWin].thread,table.unpack(raw))
    if coroutine.status(wins[curWin].thread) == "dead" then
        bRunning = false
    end
end
