-- windowsの設定

local wezterm = require "wezterm"
local module = {}
local act = wezterm.action

local powershell_path = "C:\\Program Files\\PowerShell\\7\\pwsh.exe"
-- shell items
local shell_items = {
    {
        label = "PowerShell7",
        args = { powershell_path },
        domain = { DomainName = 'local' },
    },
    {
        label = "Command Prompt",
        args = { "cmd.exe" },
        domain = { DomainName = 'local' },
    },
    {
        label = "Git Bash",
        args = { "C:\\Program Files\\Git\\bin\\bash.exe", "-i", "-l" },
        domain = { DomainName = 'local' },
    },
    {
        label = "WSL",
        domain = { DomainName = 'WSL:Ubuntu-18.04' },
    },
}

wezterm.on('new-tab-button-click', function(window, pane, button, default_action)
  if button == 'Left' then
    window:perform_action(
      act.ShowLauncherArgs { flags = 'FUZZY|LAUNCH_MENU_ITEMS' },
      pane
    )
    return false  -- デフォルト動作（新規タブ）をキャンセル
  end
  -- 右クリックはデフォルト動作のまま
end)

function module.apply_config(config)
    -- 透過率
    config.window_background_opacity = 0.8

    -- config.macos_window_background_blur = 20
    config.win32_system_backdrop = "Acrylic"

    config.default_prog = { powershell_path }

    config.default_domain = 'local'
    config.wsl_domains = {
        {
            name = 'WSL:Ubuntu-18.04',
            distribution = 'Ubuntu-18.04',
        },
    }

    -- 起動シェルの選択メニュー
    config.launch_menu = shell_items
end

return module