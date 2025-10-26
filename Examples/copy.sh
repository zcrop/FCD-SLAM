#!/bin/bash

# 定义文件和目标文件夹
SCRIPT_FILE="averge.sh"
KP_FOLDER="./kp"
CSV_FOLDER="./csv"

# 检查脚本文件是否存在
if [ ! -f "$SCRIPT_FILE" ]; then
    echo "Error: $SCRIPT_FILE not found in the current directory."
    exit 1
fi

# 创建目标文件夹（如果不存在）
if [ ! -d "$KP_FOLDER" ]; then
    mkdir -p "$KP_FOLDER"
    echo "Created directory: $KP_FOLDER"
fi

if [ ! -d "$CSV_FOLDER" ]; then
    mkdir -p "$CSV_FOLDER"
    echo "Created directory: $CSV_FOLDER"
fi

# 复制脚本到目标文件夹
cp "$SCRIPT_FILE" "$KP_FOLDER/"
echo "Copied $SCRIPT_FILE to $KP_FOLDER"

cp "$SCRIPT_FILE" "$CSV_FOLDER/"
echo "Copied $SCRIPT_FILE to $CSV_FOLDER"

echo "All operations completed successfully."

