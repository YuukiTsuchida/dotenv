# dotenv
env file list


## 設定

### Windows場合

環境変数に

- HOME
- XDG_CONFIG_HOME

の定義が必要になる。

### WezTerm

新規タブ作成時に現在のペインのパスで開くためOSC7の設定が必要

#### PowerShell

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

#### linux(WSL2) & mac

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