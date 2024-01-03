local auth = require("momocoach.auth")
local util = require('momocoach.util')

local M = {}

local function show(sw)
  local diff = (vim.fn.localtime()*1000 - sw.timestamp)/1000
  local t = sw.timestamp == 0 and 0 or diff
  local duration = sw.duration + (t>0 and t or 0)
  local status = 'running'

  if (sw.timestamp == 0 and sw.duration == 0) then
    status = 'not started'
  elseif (sw.timestamp == 0 and sw.duration ~= 0) then
    status = 'in pause'
  end
  util.echo('stopwatch ' .. status .. ' ' .. util.renderTimestamp(duration))
end

function M.get()
  local userdata = auth.get_cred()
  local sw = vim.json.decode(vim.fn.system(util.api('stopwatch', userdata.clientid, userdata.secret)))
  show(sw)
end

function M.start()
  local userdata = auth.get_cred()
  local sw = vim.json.decode(vim.fn.system(util.api('stopwatch', userdata.clientid, userdata.secret) .. ' -X POST'))
  show(sw)
end

function M.pause()
  local userdata = auth.get_cred()
  local sw = vim.json.decode(vim.fn.system(util.api('stopwatch', userdata.clientid, userdata.secret) .. ' -X PUT'))
  show(sw)
end

function M.stop()
  local userdata = auth.get_cred()
  local sw = vim.json.decode(vim.fn.system(util.api('stopwatch', userdata.clientid, userdata.secret) .. ' -X DELETE'))
  show(sw)
end

return M
