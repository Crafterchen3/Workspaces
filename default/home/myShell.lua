local function fRead()
    term.setCursorBlink(true)
    while true do
        a,b,c = os.pullEvent()
        if a == "char" then
            term.write(b)
        end
        if a == "key" then
            x,y = term.getCursorPos()
            if b == keys.backspace and x > 1 then
                term.setCursorPos(x-1,y)
                term.write(" ")
                term.setCursorPos(x-1,y)
            end
            if b == keys.tab then
                return
            end
            if b == keys.enter then
                print()
            end
        end
    end
end

fRead()
term.setCursorBlink(false)
