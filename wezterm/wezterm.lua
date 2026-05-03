local wezterm = require "wezterm"

local config = wezterm.config_builder()
config.automatically_reload_config = true

config.font = wezterm.font("MyricaM M")
config.font_size = 15.0
config.use_ime = true

config.hide_tab_bar_if_only_one_tab = false
config.show_tabs_in_tab_bar = true
config.color_scheme = 'Solarized (dark) (terminal.sexy)'
config.enable_scroll_bar = true

-- アクティブなタブのスタイルを変更
wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
local background = "#5c6d74"
local foreground = "#FFFFFF"

if tab.is_active then
    background = "#ae8b2d"
    foreground = "#FFFFFF"
end

local title = "   " .. wezterm.truncate_right(tab.active_pane.title, max_width - 1) .. "   "

return {
    { Background = { Color = background } },
    { Foreground = { Color = foreground } },
    { Text = title },
}
end)

-- Show which key table is active in the status area
wezterm.on('update-right-status', function(window, pane)
  local status = ''

  if window:leader_is_active() then
    status = 'LEADER'
  end

  local name = window:active_key_table()
  if name then
    status = status .. ' TABLE: ' .. name
  end

  window:set_right_status(status)
end)


if wezterm.target_triple == 'x86_64-pc-windows-msvc' then
    local windows = require("windows")
    windows.apply_config(config)
elseif wezterm.target_triple == 'aarch64-apple-darwin' then
    local mac = require("mac")
    mac.apply_config(config)
else
    -- linuxの設定
end

local keybinds = require("keybinds")
keybinds.apply_config(config)

return config