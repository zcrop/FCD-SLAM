#!/bin/bash

# 定义路径
CSV_FOLDER="./"
RESULT_FILE="./result.csv"

# 检查 CSV 文件夹是否存在
if [ ! -d "$CSV_FOLDER" ]; then
    echo "Error: CSV folder '$CSV_FOLDER' does not exist."
    exit 1
fi

# 初始化结果文件
echo "Filename,Average" > "$RESULT_FILE"

# 遍历 CSV 文件夹中的所有 .csv 文件
for FILE in "$CSV_FOLDER"/*.csv; do
    if [ -f "$FILE" ]; then
        # 获取文件名（不含路径）
        FILENAME=$(basename "$FILE")
        
        # 计算第一列中大于等于 10 的数据的平均值
        AVERAGE=$(awk -F, '$1 >= 10 { sum += $1; count++ } END { if (count > 0) print sum / count; else print "N/A" }' "$FILE")
        
        # 将文件名和平均值写入结果文件
        echo "$FILENAME,$AVERAGE" >> "$RESULT_FILE"
        
        echo "Processed $FILENAME: Average = $AVERAGE"
    fi
done

echo "Results saved to $RESULT_FILE"

