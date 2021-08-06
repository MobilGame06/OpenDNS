local term = require("term")

term.clear()

print("Choose what to install.")
print("[1] Server")
print("[2] Client")
local input = io.read()

if input == "1" then
    print("1")
elseif input == "2" then
    print("2")
end 