local t = require "t"
local is = t.is

local mn = 256 -- 1 byte
local md = mn -- mod divisor

local cached = t.cached(tonumber)
return setmetatable({}, {
  __tonumber=function(self) return self.n or 0 end,
  __eq=function(self, o) return self.n==(self(o) or {}).n end,
  __tostring=function(self)
    local n = tonumber(self.n or 0)+0
    local d = n % md
    n=math.floor(n / mn)
    local c = n % md
    n=math.floor(n / mn)
    local b = n % md
    n=math.floor(n / mn)
    local a = n % md
    return table.concat({tostring(a), tostring(b), tostring(c), tostring(d)}, '.')
  end,
  __call=function(self, o)
  if type(o)=='nil' then return nil end
  if type(o)=='table' then
    if is.similar(self, o) then
      return o
    end
    return self(tostring(o))
  end
  local rv = {}
  if type(o)=='number' then
    if o<0 or o>=mn^4 then return nil end
    rv.n=o
  end
  if type(o)=='string' then
    rv.n=0
    if not o:match("^%d+%.%d+%.%d+%.%d+$") then return nil end
    for it in o:gmatch("%d+") do
      if tonumber(it)>255 then return nil end
      rv.n = (rv.n * mn) + tonumber(it, 10)
    end
  end
  return cached[rv.n] or cached(setmetatable(rv, getmetatable(self)))
  end,
})
