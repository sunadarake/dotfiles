# dotfiles

色々な設定ファイルを置いておくためのリポジトリ。

## .vimrc の設定方法

`$HOME\Documents\dotfiles\.vimrc` にファイルがあると仮定する。
Windowsの場合はPowerShellを管理者ユーザーで開いた後に
以下を実行する。

```ps1
ni -ItemType SymbolicLink -Path "$HOME\.vimrc" -Target "$HOME\Documents\dotfiles\.vimrc"
```


