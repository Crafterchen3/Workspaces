local cur = term.native()
shell.setPath(shell.path()..":/bin/")

for k,v in pairs(fs.list("/api/")) do
    dofile("/api/"..v)
end

shell.run("screenfetch")
sleep(0.25)
local w,h = cur.getSize()
local main = window.create(cur,1,1,w,h)
local notifiy = window.create(cur,w/2-20,2,40,5)
term.redirect(main)

function os.sendNotification(Title,Message)
    cback = term.getBackgroundColor()
    ctext = term.getTextColor()
    term.redirect(notifiy)
    term.setBackgroundColor(colors.gray)
    term.setTextColor(colors.white)
    term.clear()
    term.setCursorPos(2,2)
    term.write(Title)
    term.setCursorPos(2,4)
    term.write(Message)
    paintutils.drawBox(1,1,40,5,colors.lightGray)
    term.setTextColor(colors.yellow)
    term.setCursorPos(3,5)
    term.write("V:View X:Close")
    run = true
    while run do
       a,key = os.pullEvent("key")
       if key == keys.x then
           run = false
           term.redirect(main)
           main.redraw()
       end
    end
    term.setBackgroundColor(cback)
    term.setTextColor(ctext)
end


local completion = require "cc.shell.completion"
--shell.run("Workspace.lua")
shell.setCompletionFunction("bin/dedit.lua",completion.build(completion.file))
shell.run("/bin/Workspace.lua")
shell.setDir("")
shell.run("clear")
