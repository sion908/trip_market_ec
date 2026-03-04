#!/bin/bash

# Web表示用に画像サイズを最低限のサイズまで下げるスクリプト
# 実行ディレクトリ配下の images ディレクトリを対象とします。
# cwebpを使用してWebP形式に変換し、さらなる軽量化を図ります。

TARGET_DIR="./images"
ORIG_DIR="$TARGET_DIR/orig"

# オリジナル保存用ディレクトリの作成
mkdir -p "$ORIG_DIR"

# リサイズする最大サイズ（長辺ピクセル）
MAX_SIZE=800
# WebPのクオリティ (0-100)
WEBP_QUALITY=75

echo "画像の最適化を開始します (WebP変換)..."

# ./images/orig 内のオリジナル画像を元にWebP変換を行う
for img in "$ORIG_DIR"/*.png "$ORIG_DIR"/*.jpg "$ORIG_DIR"/*.jpeg; do
    if [ ! -f "$img" ]; then
        continue
    fi

    filename=$(basename "$img")
    basename_no_ext="${filename%.*}"
    
    # 変換出力先
    out_file="$TARGET_DIR/${basename_no_ext}.webp"
    
    # cwebpを使用してリサイズとWebP変換を実行
    # -resize <width> <height> (片方が0ならアスペクト比維持)
    cwebp -q $WEBP_QUALITY -resize $MAX_SIZE 0 "$img" -o "$out_file" > /dev/null 2>&1
    
    echo "WebP変換完了: ${basename_no_ext}.webp"
done

echo "完了しました。オリジナル画像は $ORIG_DIR に保存されています。"
