# Startship設定

## インストール

```shell
cargo install starship --locked
```

## プラットフォーム毎の設定

新規タブ作成時に現在のペインのパスで開くためOSC7の設定が必要

### PowerShell

以下のコードをプロファイルに追加する

```PowerShell
Invoke-Expression (&starship init powershell)
```

### WSL2 & macOS

```bash
eval "$(starship init bash)"
```
