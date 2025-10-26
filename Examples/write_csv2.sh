#!/bin/bash

# 定义输入文件和输出文件
input_file="ExecMean.txt"
output_file="output.csv"

# 初始化标签数组
labels=()
data=()

# 首次读取文件获取标签
while IFS=':' read -r stage value; do
	    # 提取标签
	        stage=$(echo "$stage" | tr ',' ' ' | sed 's/^[ \t]*//;s/[ \t]*$//')
		    labels+=("$stage")
	    done < <(grep -E "Extraction|Pose Prediction|LM Track|Total Tracking|Total Local Mapping" "$input_file")

	    # 将标签写入CSV的第一行
	    IFS=','; echo "${labels[*]}" > "$output_file"

	    # 多次读取文件并提取数据
	    for i in {1..3}; do # 假设读取三次
		        temp_data=()
			    while IFS=':' read -r stage value; do
				            # 提取数据并移除"$"后的部分
					            value=$(echo "$value" | sed 's/\$.*//;s/^[ \t]*//;s/[ \t]*$//')
						            temp_data+=("$value")
							        done < <(grep -E "Extraction|Pose Prediction|LM Track|Total Tracking|Total Local Mapping" "$input_file")

								    # 将数据按列追加到CSV文件中
								        IFS=','; echo "${temp_data[*]}" >> "$output_file"
								done

								echo "数据提取完成。结果保存在 $output_file 中。"

