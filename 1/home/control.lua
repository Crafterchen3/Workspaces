main = coroutine.create(function () shell.run("shell") end)

while true do
    raw = table.pack(os.pullEventRaw())
    coroutine.resume(main,table.unpack(raw))
end
