#!/bin/bash

# 定义路径
VOCAB_PATH="../Vocabulary/ORBvoc.txt"
CONFIG_PATH="./Monocular-Inertial/EuRoC.yaml"
DATASET_BASE_PATH="/home/zhrp/Dataset/Dataset"
TIMESTAMP_BASE_PATH="./Monocular-Inertial/EuRoC_TimeStamps"
EXECUTABLE="./Monocular-Inertial/mono_inertial_euroc"
CSV_FOLDER="./kp"
KF_FOLDER="./kf"

# 创建文件夹（如果不存在）
if [ ! -d "$CSV_FOLDER" ]; then
    mkdir -p "$CSV_FOLDER"
    echo "Created directory: $CSV_FOLDER"
fi

if [ ! -d "$KF_FOLDER" ]; then
    mkdir -p "$KF_FOLDER"
    echo "Created directory: $KF_FOLDER"
fi

# 数据集列表
DATASETS=("MH01" "MH02" "MH03" "MH04" "MH05" "V101" "V102" "V103" "V201" "V202")

# 遍历运行每个数据集
for DATASET in "${DATASETS[@]}"; do
    DATASET_PATH="$DATASET_BASE_PATH/$DATASET"
    TIMESTAMP_PATH="$TIMESTAMP_BASE_PATH/$DATASET.txt"
    OUTPUT_FILE="dataset-${DATASET}-monoi"
    
    echo "Running dataset: $DATASET"
    $EXECUTABLE $VOCAB_PATH $CONFIG_PATH $DATASET_PATH $TIMESTAMP_PATH $OUTPUT_FILE
    
    if [ $? -eq 0 ]; then
        echo "Dataset $DATASET completed successfully."
        
        # 检查并重命名12.csv为数据集名.csv，并移动到csv文件夹
        if [ -f "12.csv" ]; then
            NEW_CSV_PATH="$CSV_FOLDER/${DATASET}.csv"
            mv 12.csv "$NEW_CSV_PATH"
            echo "Renamed 12.csv to $NEW_CSV_PATH"
        else
            echo "Warning: 12.csv not found for dataset $DATASET"
        fi

        # 检查并移动 f_dataset 和 kf_dataset 文件到kf文件夹
        F_FILE="f_dataset-${DATASET}-monoi.txt"
        KF_FILE="kf_dataset-${DATASET}-monoi.txt"
        
        if [ -f "$F_FILE" ]; then
            mv "$F_FILE" "$KF_FOLDER/"
            echo "Moved $F_FILE to $KF_FOLDER"
        else
            echo "Warning: $F_FILE not found for dataset $DATASET"
        fi

        if [ -f "$KF_FILE" ]; then
            mv "$KF_FILE" "$KF_FOLDER/"
            echo "Moved $KF_FILE to $KF_FOLDER"
        else
            echo "Warning: $KF_FILE not found for dataset $DATASET"
        fi

    else
        echo "Error occurred while processing dataset $DATASET."
        exit 1
    fi
done

echo "All datasets processed."

