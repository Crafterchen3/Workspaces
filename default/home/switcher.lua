cur = term.current()
x,y = cur.getSize()
win1 = window.create(cur,1,1,x/2-1,y)
win2 = window.create(cur,x/2,1,x/2,y)
proccess = {}
proccess[1] = coroutine.create(shell.run)
proccess[2] = coroutine.create(shell.run)
term.redirect(win1)
coroutine.resume(proccess[1],"shell")
term.redirect(win2)
coroutine.resume(proccess[2],"worm")
currentProc = 1
term.redirect(win1)
win1.redraw()
while true do
    pack = table.pack(os.pullEventRaw())
    if pack[1] == "key" and pack[2] == keys.rightAlt then
        if currentProc == 1 then
            term.redirect(win2)
            win2.redraw()
            currentProc = 2
        else
            term.redirect(win1)
            win1.redraw()
            currentProc = 1
        end
    end
    coroutine.resume(proccess[currentProc])
end
