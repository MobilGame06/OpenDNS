local component = require('component')
local event = require('event')
local modem = component.modem
local port = 404
local address = '00000000-0000-0000-0000-000000000000'

modem.open(port)

function _setPort(p)
    port = tonumber(p)
  end

  function _getPort()
      return port
  end

  function _setAddress(addr)
      address = tostring(addr)
  end

  function _getAddress()
    return address
  end

  function _lookup(dns, timeout)
    modem.open(port)
    timeout = timeout or 1
    if modem.send(address, port, 'lookup', dns) then
        local _, _, from, rport, _, reply = event.pull(timeout, 'modem_message')

        if reply == nil then
            return false
        elseif reply == 'nil' then
            return nil
        elseif from == address then
            return reply
        end 
   
   
   
   
    else
        return false
    end       
  end

  return {
    setPort = _setPort,
    getPort = _getPort,
    setAddress = _setAddress,
    getAddress = _getAddress,
    lookup = _lookup
  }
