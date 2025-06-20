#!/bin/bash

# エラー時にスクリプトを終了
set -e

# スクリプト開始
echo ""
echo "🚀 Start Dotfiles setup"
echo ""

# dotfilesディレクトリの場所（スクリプト自身のディレクトリ）
DOTFILES_DIR="$(dirname "$0")"

# ディレクトリ内のファイルを取得
# 1. 直下のドットファイル
# 2. .で始まるディレクトリ配下の全ファイル（.gitを除外）
# 3. その他のサブディレクトリ内のドットファイル
find "$DOTFILES_DIR" -type f \( \
    -name ".*" -o \
    -path "$DOTFILES_DIR/.*/*" -not -path "$DOTFILES_DIR/.git/*" \
\) | while read -r file; do
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

echo ""
echo "✅ Dotfiles setup completed!"
echo ""
