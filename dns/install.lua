local term = require("term")
local fs = require("filesystem")

term.clear()

print("Choose what to install.")
print("[1] Server")
print("[2] Client")
local input = io.read()

if input == "1" then
    fs.makeDirectory("/dns")
os.execute("wget 'https://raw.githubusercontent.com/MobilGame06/OpenDNS/main/dns/lib/ttf.lua' /lib/ttf.lua")
os.execute("wget 'https://raw.githubusercontent.com/MobilGame06/OpenDNS/main/dns/dns/data.cfg' /dns/data.cfg")
os.execute("wget 'https://raw.githubusercontent.com/MobilGame06/OpenDNS/main/dns/server.lua' /home/server.lua")
os.execute("wget 'https://raw.githubusercontent.com/MobilGame06/OpenDNS/main/dns/createnew.lua' /home/create.lua")

elseif input == "2" then
os.execute("wget 'https://raw.githubusercontent.com/MobilGame06/OpenDNS/main/dns/lib/dns%20library.lua' /lib/dns.lua")
end 

term.clear()