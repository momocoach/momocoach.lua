local completion_store = {
  [""] = { "auth", "stopwatch", "timelog" },
  auth = { "signin", "signout" },
  stopwatch = { "get", "start", "pause", "stop" },
  timelog = { "create", "stopwatch"}
}

vim.api.nvim_create_user_command("Momocoach", function (opts)
  local params = vim.split(opts.args, "%s+", { trimempty = true })

  local mod, action = params[1], params[2]

  -- default module
  if not mod then
    mod = "stopwatch"
  end

  -- load module
  local ok, module = pcall(require, "momocoach." .. mod)

  if not ok then
    print("[Momocoach] Unable to load module: " .. mod .. " " .. module)
    vim.defer_fn(function() vim.cmd('echo ""') end, 5000)
    return
  end

  -- default actions
  if not action then
    if mod == "auth" then
      action = "signin"
    elseif mod == "stopwatch" then
      action = "get"
    elseif mod == "timelog" then
      action = "stopwatch"
    end
  end


  if not module[action] then
    print("[Momocoach] Unknown params: " .. opts.args)
    vim.defer_fn(function() vim.cmd('echo ""') end, 5000)
    return
  end

  module[action](params)

end, {
  bang = true,
  nargs = "*",
  complete = function(_, cmd_line)
    local has_space = string.match(cmd_line, "%s$")
    local params = vim.split(cmd_line, "%s+", { trimempty = true })

    if #params == 1 then
      return completion_store[""]
    elseif #params == 2 and not has_space then
      return vim.tbl_filter(function(cmd)
        return not not string.find(cmd, "^" .. params[2])
      end, completion_store[""])
    end

    if #params >= 2 and completion_store[params[2]] then
      if #params == 2 then
        return completion_store[params[2]]
      elseif #params == 3 and not has_space then
        return vim.tbl_filter(function(cmd)
          return not not string.find(cmd, "^" .. params[3])
        end, completion_store[params[2]])
      end
    end
  end,
})
