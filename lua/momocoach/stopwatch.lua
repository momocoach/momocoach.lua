local auth = require("momocoach.auth")
local util = require('momocoach.util')

local M = {}

function M.duration(sw)
  local diff = (vim.fn.localtime()*1000 - sw.timestamp)/1000
  local t = sw.timestamp == 0 and 0 or diff
  return util.renderTimestamp(sw.duration + (t>0 and t or 0))
end

function M.durationWithoutSecond(sw)
  local diff = (vim.fn.localtime()*1000 - sw.timestamp)/1000
  local t = sw.timestamp == 0 and 0 or diff
  return util.renderTimestampWithoutSecond(sw.duration + (t>0 and t or 0))
end

local function show(sw)
  local status = 'running'

  if (sw.timestamp == 0 and sw.duration == 0) then
    status = 'not started'
  elseif (sw.timestamp == 0 and sw.duration ~= 0) then
    status = 'in pause'
  end

  util.echo('stopwatch ' .. status .. ' ' .. M.duration(sw))
end

function M._get()
  local userdata = auth.get_cred()
  return vim.json.decode(vim.fn.system(util.api('stopwatch', userdata.clientid, userdata.secret)))
end

function M.get()
  show(M._get())
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


function M._stop()
  local userdata = auth.get_cred()
  return vim.json.decode(vim.fn.system(util.api('stopwatch', userdata.clientid, userdata.secret) .. ' -X DELETE'))
end

function M.stop()
  show(M._stop())
end

return M
