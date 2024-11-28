local t=t or require "t"
local tonum=function(x) return tonumber(x) end
local byte=t.number.byte
local array=t.array
local pak=table.pack
local pat="^%s*(%d+)%.(%d+)%.(%d+)%.(%d+)(/?%d*)%s*$"
local ok={['']=true,['/32']=true}
return function(x)
  x=tostring(x)
  local nums=array(pak(string.match(x, pat)))
  if type(nums[5])=='nil' or ok[nums[5]] then nums[5]=nil end
  if #nums~=4 then return nil end
  nums=(nums*tonum)*byte
  return #nums==4 and table.concat(nums, '.') or nil
end