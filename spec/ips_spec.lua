describe('ips', function()
  local t, is, ip, ips, li
  setup(function()
    t = require("t")
    is = t.is
    ip = require "t.net.ip"
    ips = require "t.net.ips"
  end)
  before_each(function()
    li = ips()
  end)
  it("is.of.set", function()
    assert.truthy(is.of.set(ips))
    assert.truthy(is.of.set(ips()))
    assert.truthy(is.of.set(li))
  end)
	it("check callable", function()
		assert.callable(ip)
		assert.callable(ips)
	end)
  it("new()", function()
		assert.equal(0, #li)
  end)
	it("adds/del items", function()
    assert.same({}, li)
		_ = li + '1.1.1.1'
		assert.truthy(li['1.1.1.1'])
		assert.same(ips({'1.1.1.1'}), li)
		assert.same(ips('1.1.1.1'), li)

		assert.truthy(li + '1.2.3.4')
		assert.truthy(li['1.2.3.4'])

		assert.truthy(li + '1.2.5.8')
		assert.truthy(li['1.2.5.8'])

		assert.truthy(li - '1.2.3.4')
		assert.falsy(li['1.2.3.4'])

		assert.truthy(li - '0.0.0.0')
		assert.same(ips({'1.1.1.1', '1.2.5.8'}), li)
		assert.same(ips('1.1.1.1', '1.2.5.8'), li)
	end)
	it("concat", function()
		local a = ips('1.1.1.1', '1.2.3.4', '1.2.5.8', '1.2.3.4')
		local b = ips({'1.1.1.1', '1.2.3.4', '1.2.5.8'}, '1.2.3.4')
		local c = ips({'1.1.1.1', '1.2.3.4'}, {'1.2.5.8', '1.2.3.4'})
		local d = ips('1.1.1.1') .. ips('1.2.3.4') .. ips('1.2.5.8') .. ips('1.2.3.4')
		local e = ips('1.1.1.1', '1.2.3.4') .. ips('1.2.5.8') .. ips('1.2.3.4')
		local f = ips('1.1.1.1', '1.2.3.4') .. ips('1.2.5.8', '1.2.3.4')
		assert.same(a, b, c, d, e, f)
	end)
	it("tostring", function()
    local r1 = {["1.1.1.1\n1.2.3.4"]=true, ["1.2.3.4\n1.1.1.1"]=true}
    local r2 = {["1.1.1.1\n1.2.3.4\n8.8.4.4"]=true, ["1.1.1.1\n8.8.4.4\n1.2.3.4"]=true,
                ["1.2.3.4\n1.1.1.1\n8.8.4.4"]=true, ["1.2.3.4\n8.8.4.4\n1.1.1.1"]=true,
                ["8.8.4.4\n1.1.1.1\n1.2.3.4"]=true, ["8.8.4.4\n1.2.3.4\n1.1.1.1"]=true,}
		assert.equal('', tostring(li))
		_ = li + '1.1.1.1'
    assert.truthy(li['1.1.1.1'])
		assert.equal('1.1.1.1', tostring(li))
		_ = li + '1.1.1.1' + '1.2.3.4'
    assert.truthy(li['1.1.1.1'])
    assert.truthy(li['1.2.3.4'])
		assert.is_true(r1[tostring(li)])
		_ = li + '8.8.4.4'
		assert.is_true(r2[tostring(li)])
	end)
  it("type name check", function()
    assert.type('t/net/ips', ips)
    assert.type('t/net/ips', ips())
    assert.type('t/net/ips', ips('1.2.3.4'))
  end)
end)
