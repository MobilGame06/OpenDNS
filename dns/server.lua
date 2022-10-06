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

readcmd = false

local localAddress = ''

for address, _ in component.list("modem", false) do
    localAddress = address
    break
  end

  modem.open(port)
  term.clear()

  local t1 = thread.create(function()    
    readcmd = true
    while readcmd do
    term.setCursor(1,49)
    input = io.read()
    if input == "reboot" then
      os.execute("reboot")
    elseif input == "stop" then
      os.execute("shutdown")
    elseif input == "reload" then
      settings = ttf.load(path)
      term.write(cprefix.. "Reloaded\n")
      term.write("\n")
    elseif input == "help" then
      term.write("------------Help-------------\n")
      term.write(cprefix.. "[reboot] reboot your pc\n")
      term.write(cprefix.. "[stop] shutdown your pc\n")
      term.write(cprefix.. "[reload] reload the config\n")
      term.write(cprefix.. "[create] create a dns entry\n")
      term.write("\n")
    elseif input == "create" then
      create()
    else 
      term.write(cprefix.. "This command don't exist try to use help\n")
      term.write("\n")
    end 
  end
  end)

function create()
  local t2 = thread.create(function()
    readcmd = false
    term.write("\n")
    term.write("Type the name of the dns you want to create?\n")
    local name = io.read()
    term.write("Type your uuid\n")
    local uu = io.read()
    readcmd = true
    settings[name] = uu
    ttf.save(settings, path)
    os.execute("reboot")
  end)
end


  term.write(sprefix.. "Server started\n")
  term.write(sprefix.. "Listening on port: " ..port.."\n")
  term.write(sprefix.. "Adress: ")
  term.write(localAddress .."\n")
  term.write("\n")

  
  while true do
      local _, _, from, port, _, command, param = event.pull("modem.message")
      local command = string.lower(tostring(command))
      local param = string.gsub(tostring(param), '\n', '')
      term.clearLine()
      term.write(sprefix.. "Request from "..from .."\n")
      term.write("\n")
      if command == "lookup" then
        addr = tostring(settings[param])
        term.clearLine()
        term.write(sprefix.. 'DNS Lookup: '.. param .. ' -> ' .. addr)
        term.write("\n")
        modem.send(from, port, addr)
      end     
  end
