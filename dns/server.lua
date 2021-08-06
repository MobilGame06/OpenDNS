local component = require("component")
local event = require('event')
local term = require('term')
local ttf = require("ttf")

local modem = component.modem

local port = 404

local path = "/home/lol.cfg"
settings = ttf.load(path)



local localAddress = ''

for address, _ in component.list("modem", false) do
    localAddress = address
    break
  end

  modem.open(port)

  print("Server started")
  print("Listening on port:" ..port)
  term.write("Adress: ")
  term.write(localAddress)

  while true do
      local _, _, from, port, _, command, param = event.pull("modem.message")
      local command = string.lower(tostring(command))
      local param = string.gsub(tostring(param), '\n', '')
      print("Request from "..from)
      if command == "lookup" then
        addr = tostring(settings[param])
        print('DNS Lookup: '.. param .. ' -> ' .. addr)
        modem.send(from, port, addr)
      end
  end