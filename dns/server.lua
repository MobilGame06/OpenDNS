local component = require("component")
local event = require('event')
local term = require('term')
local ttf = require("ttf")
local thread = require("thread")

local modem = component.modem

local sprefix = "[SYSTEM] "
local cprefix = "[CommandSystem] "

local port = 404

local path = "/dns/data.cfg"
settings = ttf.load(path)



local localAddress = ''

for address, _ in component.list("modem", false) do
    localAddress = address
    break
  end

  modem.open(port)
  term.clear()

  local t1 = thread.create(function()    
    while true do
    term.setCursor(1,50)
    input = io.read()
    if input == "reboot" then
      os.execute("reboot")
    elseif input == "stop" then
      os.execute("shutdown")
    end 
  end
  end)



  term.write(sprefix.. "Server started\n")
  term.write(sprefix.. "Listening on port: " ..port.."\n")
  term.write(sprefix.. "Adress: ")
  term.write(localAddress .."\n")
  


  
  while true do
      local _, _, from, port, _, command, param = event.pull("modem.message")
      local command = string.lower(tostring(command))
      local param = string.gsub(tostring(param), '\n', '')
      term.clearLine()
      term.write(sprefix.. "Request from "..from)
      if command == "lookup" then
        addr = tostring(settings[param])
        term.clearLine()
        term.write(sprefix.. 'DNS Lookup: '.. param .. ' -> ' .. addr)
        term.write("\n")
        modem.send(from, port, addr)
      end     
  end
