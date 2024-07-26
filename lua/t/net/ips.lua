local t = require "t"
local ip = require "t.net.ip"

return t.set:of(t.fn.combined(ip, tostring))
