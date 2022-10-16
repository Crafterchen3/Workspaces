print("DEBUG VIEW")
shell.run("bg shell")
while true do
    a,sProgram = os.pullEvent("debug")
    print(sProgram)
    read()
    --shell.run("clear")
    shell.run(sProgram)
    os.queueEvent("debugFinish")
end

 
