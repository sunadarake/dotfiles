#!/bin/bash

# エラー時にスクリプトを終了
set -e

# dotfilesディレクトリの場所（スクリプト自身のディレクトリ内のdotfiles）
DOTFILES_DIR="$(dirname "$0")"

echo "🚀 Start Dotfiles setup!"

# dotfilesディレクトリ内のドットファイルおよびサブディレクトリ内のファイルを再帰的に取得
find "$DOTFILES_DIR" -type f -name ".*" -o -path "*/.*/*" | while read -r file; do
    # ホームディレクトリでのリンク先パスを構築
    relative_path="${file#$DOTFILES_DIR/}"
    target="$HOME/$relative_path"

    # リンク先の親ディレクトリを作成
    target_dir=$(dirname "$target")
    mkdir -p "$target_dir"

    # ファイルが既に存在する場合の処理
    if [ -e "$target" ] || [ -L "$target" ]; then
        # シンボリックリンクで、リンク先が正しい場合はスキップ
        if [ -L "$target" ] && [ "$(readlink "$target")" = "$file" ]; then
            echo "⏭️ Skipping $relative_path: already linked correctly"
            continue
        fi
        echo "⏭️ Skipping $relative_path: file or link already exists"
        continue
    fi

    # シンボリックリンクを作成
    echo "🔗 Creating symlink for $relative_path"
    ln -s "$file" "$target"
done

echo "✅ Dotfiles setup completed!"