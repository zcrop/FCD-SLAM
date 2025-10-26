#!/bin/bash

# 定义文件夹列表
FOLDERS=("orb-slam" "he-slam" "clahe-slam" "sad-vslam" "sad-vslam(clahe)")

# 数据集名称列表
DATASETS=("MH01" "MH02" "MH03" "MH04" "MH05" "V101" "V102" "V103" "V201" "V202")

# 定义输出文件
OUTPUT_FILE="output.csv"

# 写入输出文件标题（第二列为不同的文件夹名）
echo ",orb-slam,he-slam,clahe-slam,sad-vslam,sad-vslam(clahe)" > "$OUTPUT_FILE"

# 遍历每个数据集
for DATASET in "${DATASETS[@]}"; do
    # 初始化当前数据集行（第一列为数据集名）
    ROW="$DATASET"
    echo "Processing dataset: $DATASET"

    # 遍历每个文件夹
    for FOLDER in "${FOLDERS[@]}"; do
        # 构建文件路径（文件夹/数据集/csv/数据集.csv）
        FILE_PATH="$FOLDER/csv/$DATASET.csv"
        
        # 输出当前正在处理的文件路径
        echo "Checking file: $FILE_PATH"

        # 检查文件是否存在
        if [ -f "$FILE_PATH" ]; then
            # 使用 awk 统计第一列大于等于 75 的数据个数
            COUNT=$(awk -F, '{gsub(/^[ \t]+|[ \t]+$/, "", $1); if ($1+0 >= 75) count++} END {print count+0}' "$FILE_PATH")
            
            # 输出调试信息，检查 COUNT 的值
            echo "Count of values >= 75 in $FILE_PATH: $COUNT"
        else
            COUNT=0
            echo "Warning: $FILE_PATH not found."
        fi
        
        # 添加结果到当前行
        ROW="$ROW,$COUNT"
    done

    # 输出调试信息，检查 ROW 内容
    echo "Row for $DATASET: $ROW"
    
    # 写入到输出文件
    echo "$ROW" >> "$OUTPUT_FILE"
done

echo "Results written to $OUTPUT_FILE"

