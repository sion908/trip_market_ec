#!/bin/bash

# Web表示用に画像サイズを最低限のサイズまで下げるスクリプト
# 実行ディレクトリ配下の images ディレクトリを対象とします。

TARGET_DIR="./images"
ORIG_DIR="$TARGET_DIR/orig"

# オリジナル保存用ディレクトリの作成
mkdir -p "$ORIG_DIR"

# リサイズする最大サイズ（長辺ピクセル）
# 一般的なスマホ〜PC表示で必要十分な800pxとしています (必要に応じて変更してください)
MAX_SIZE=800

echo "画像の最適化を開始します..."

# png, jpg, jpeg ファイルを対象に処理
for img in "$TARGET_DIR"/*.png "$TARGET_DIR"/*.jpg "$TARGET_DIR"/*.jpeg; do
    # 対象ファイルが存在しない場合はスキップ
    if [ ! -f "$img" ]; then
        continue
    fi

    filename=$(basename "$img")
    
    # オリジナル画像を orig ディレクトリに移動
    mv "$img" "$ORIG_DIR/$filename"
    
    # sipsコマンド (macOS標準) でアスペクト比を維持したまま長辺をリサイズし、元の名前で保存
    sips -Z $MAX_SIZE "$ORIG_DIR/$filename" --out "$TARGET_DIR/$filename" > /dev/null
    
    echo "リサイズ完了: $filename"
done

echo "完了しました。オリジナル画像は $ORIG_DIR に保存されています。"
