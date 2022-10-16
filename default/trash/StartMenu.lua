favorites = {{name="Add",run="AddFav",update=true},{name="Shell",run="shell"},{name="Worm",run="Worm"}}
settings.define("favorites",{default=favorites,type="table"})
favorites = settings.get("favorites")
img = paintutils.loadImage("Title.nfp")
h = 7 
function draw()
term.setBackgroundColor(colors.lightGray)
term.clear()
paintutils.drawImage(img,2,2)
for k,v in pairs(favorites) do
    b = k *7  -5 
    paintutils.drawFilledBox(b+1,2+h,b+ 5,5+h ,colors.red)
    term.setBackgroundColor(colors.lightGray)
    term.setCursorPos(b+1,7+h)
    term.write(v.name )
end 
end
draw()

while true do 
    a,z,x,y = os.pullEvent("mouse_click")
    for k,v in pairs(favorites) do
        b = k * 7 - 5
        if x >= b+1 and x <= b+5 and y >= 2+h and y <= 5+h then
            term.setBackgroundColor(colors.black)
            term.setTextColor(colors.white)
            term.setCursorPos(1,1)
            term.clear()
            shell.run(v.run)
            draw()
            break
        end
    end
    favorites = settings.get("favorites")
end
