local ttf = require("ttf")
local path = "/dns/data.cfg"
settings = ttf.load(path)

print("Type the name of the dns you want to create?")
local name = io.read()

print("Type your uuid")
local uu = io.read()



settings[name] = uu
ttf.save(settings, path)