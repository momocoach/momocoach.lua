local auth = require("momocoach.auth")
local util = require('momocoach.util')
local stopwatch = require('momocoach.stopwatch')

local M = {}


local function show(t)
  util.echo(t.time .. ' logged')
end


function M.create(params)
  local userdata = auth.get_cred()
  local data = {
    date = util.getCurrentDate(),
    time= params[3],
    label = params[4],
    description = table.concat(params, ' ', 5)
  }

  if #params < 5 then
    util.echo('timelog create wrong params ' .. #params)
    return
  end

  if not util.isValidTimeFormat(data.time) then
    util.echo('timelog invalid time format: ' .. data.time)
    return
  end

  if #data.label == 0  then
    util.echo('timelog, missing project or client')
    return
  end

  if #data.description == 0  then
    util.echo('timelog, missing description')
    return
  end

  local t = vim.json.decode(
    vim.fn.system(util.api('time', userdata.clientid, userdata.secret) .. ' -X POST --json \''  ..
      string.gsub(vim.json.encode(data), "'", "'\\''") .. '\'')
  )

  show(t)
end


function M.stopwatch(params)
  local userdata = auth.get_cred()
  local sw = stopwatch._get()
  local data = {
    date = util.getCurrentDate(),
    time= stopwatch.durationWithoutSecond(sw),
    label = params[3],
    description = table.concat(params, ' ', 4)
  }

  if #params < 4 then
    util.echo('timelog create wrong params ' .. #params)
    return
  end

  if not util.isValidTimeFormat(data.time) then
    util.echo('timelog invalid time format: ' .. data.time)
    return
  end

  if #data.label == 0  then
    util.echo('timelog, missing project or client')
    return
  end

  if #data.description == 0  then
    util.echo('timelog, missing description')
    return
  end
  local t = vim.json.decode(
    vim.fn.system(util.api('time', userdata.clientid, userdata.secret) .. ' -X POST --json \''  ..
      string.gsub(vim.json.encode(data), "'", "'\\''") .. '\'')
  )
  stopwatch._stop()
  show(t)
end


return M
