# WezTerm 設定

[WezTerm](https://wezfurlong.org/wezterm/) のdotfiles設定。

## ファイル構成

| ファイル | 説明 |
|---|---|
| `wezterm.lua` | メイン設定ファイル。フォント・カラースキーム・タブのスタイル等 |
| `windows.lua` | Windows向け設定（透過・Acrylic背景・起動シェルの選択メニュー） |
| `mac.lua` | macOS向け設定（透過・ウィンドウ背景ブラー） |
| `keybinds.lua` | キーバインド設定 |

## 主な設定

- **フォント**: MyricaM M (15px)
- **カラースキーム**: Solarized Dark
- **リーダーキー**: `Ctrl+Space`
- **IME**: 有効

## プラットフォーム対応

OS別に設定を切り替えている。

- **Windows**: 透過率0.8 + Acrylicブラー、PowerShell 7をデフォルトシェルとして使用
  - 新規タブボタンのクリックでシェル選択メニュー（PowerShell 7 / CMD / Git Bash / WSL）を表示
- **macOS**: 透過率0.8 + ウィンドウ背景ブラー有効

## プラットフォーム毎の設定

新規タブ作成時に現在のペインのパスで開くためOSC7の設定が必要

### PowerShell

以下のコードをプロファイルに追加する

```PowerShell
function prompt {
  $p = $executionContext.SessionState.Path.CurrentLocation
  $osc7 = ""
  if ($p.Provider.Name -eq "FileSystem") {
    $ansi_escape = [char]27
    $provider_path = $p.ProviderPath -Replace "\\", "/"
    $osc7 = "$ansi_escape]7;file://${env:COMPUTERNAME}/${provider_path}${ansi_escape}\"
  }
  "${osc7}PS $p$('>' * ($nestedPromptLevel + 1)) "
}
```

### WSL2 & macOS

WezTermの公式shell integrationスクリプトをDLする。

```bash
curl -fsSL https://raw.githubusercontent.com/wezterm/wezterm/main/assets/shell-integration/wezterm.sh \
 -o ~/.config/wezterm.sh
```

各シェルのプロファイルにDLしたスクリプトを起動に読み込ませる

```bash
if [ -n "$WEZTERM_PANE" ]; then
  source ~/.config/wezterm.sh
fi
```

## キーバインド

詳細は [`keybinds.lua`](keybinds.lua) を参照。

リーダーキーは `Ctrl+Space`（タイムアウト2秒）。

