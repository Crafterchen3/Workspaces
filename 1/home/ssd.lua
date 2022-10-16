function get(tab,index)
    i = 0
    for k,v in pairs(tab) do
        i = i + 1
        if i == index then
            return k,v
        end
    end
    return "none",nil
end

function max(tab)
    i = 0
    for k,v in pairs(tab) do
        i = i + 1
    end
    return i
end

function filter(name)
    if string.sub(string.reverse(name),string.len(name)) == "_" then
        return false
    else
        return true
    end
end
        
function getRandomName(tab,typ)
    while true do
        rand = math.random(max(_G))
        name,value = get(_G,rand)
        if type(value) == typ and filter(name) then
            return name,value
        end
    end
end

function getRandomContents()
    tab = {}
    str = ""
    for i=0,math.random(3)-2 do
        table.insert(tab,math.random(50))
    end
    for k,v in pairs(tab) do
        if k == 1 then
            str = v..","
        elseif k == table.maxn(tab) then
            str = str..v
        else
            str = str..v..","
        end
    end
    return str
end
        

term.setTextColor(colors.white)
while true do
    str = ""
    k,tab = getRandomName(_G,"table")
    str = k.."."
    k,v = getRandomName(tab,"function")
    str = str..k.."("..getRandomContents()..")"
    print(str)
    sleep(1)
end

