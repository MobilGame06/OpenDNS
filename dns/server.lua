local component = require("component")
local event = require('event')
local term = require('term')

local modem = component.modem

local port = 404

dnsdata = {
    ['test'] = '00000000-0000-0000-0000-000000000000'
}


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
        addr = tostring(dnsdata[param])
        print('DNS Lookup: '.. param .. ' -> ' .. addr)
        modem.send(from, port, addr)
      end
  end