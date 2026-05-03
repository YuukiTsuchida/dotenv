-- macの設定

local module = {}

function module.apply_config(config)
    config.window_background_opacity = 0.8
    config.macos_window_background_blur = 20
end

return module
