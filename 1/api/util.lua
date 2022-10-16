--Event API
local event = {}
event.pull = os.pullEvent
event.pullraw = os.pullEventRaw
event.queue = os.queueEvent

function event.waitForKey(key)
    while true do
        local a,k = event.pull("key")
        if key == nil then
            return k
        elseif k == key then
            return true
        end
    end
end
_G.event = event

--Rednet API
function rednet.sendPacket(receiverID, packet, protocol)
    local str = textutils.serializeJSON(packet)
    return rednet.send(receiverID, str, protocol)
end

function rednet.broadcastPacket(packet, protocol)
    local str = textutils.serializeJSON(packet)
    return rednet.broadcast(str,protocol)
end

function rednet.receivePacket(protocol, timeout)
    local a,b,c = rednet.receive(protocol, timeout)
    return textutils.unserialiseJSON(b)
end 
