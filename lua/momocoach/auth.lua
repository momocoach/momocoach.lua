local M = {}

local function find_config_path()
  local config = vim.fn.expand("$XDG_CONFIG_HOME")
  if config and vim.fn.isdirectory(config) > 0 then
    return config
  elseif vim.fn.has("win32") > 0 then
    config = vim.fn.expand("~/AppData/Local")
    if vim.fn.isdirectory(config) > 0 then
      return config
    end
  else
    config = vim.fn.expand("~/.config")
    if vim.fn.isdirectory(config) > 0 then
      return config
    else
      print("Error: could not find config path")
    end
  end
end

local function echo(message)
  vim.cmd('echom "[Momocoach] ' .. tostring(message):gsub('"', '\\"') .. '"')
end

function M.signin(params)
  if #params ~= 4 then
    echo("2 arguments needed: secret and clientid")
    return
  end

  local userdata = { clientid= params[4], secret= params[3]}
  local j = vim.json.encode(userdata)
  vim.fn.mkdir(find_config_path() .. "/momo.coach", 'p')

  vim.api.nvim_eval( "writefile(['" ..  j  .. "'], '" .. find_config_path() .. "/momo.coach/config.json')")
  echo("credentials saved")
end

function M.signout()
  vim.api.nvim_eval(
    "delete('" .. find_config_path() .. "/momo.coach/config.json')"
  )
  echo("credentials removed")
end

M.get_cred = function()
  local userdata = vim.json.decode(
    vim.api.nvim_eval("readfile('" .. find_config_path() .. "/momo.coach/config.json')")[1]
  )
  return { clientid = userdata.clientid, secret = userdata.secret }
end

return M
