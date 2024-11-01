#!/bin/bash
result_file="./reports/baseline_model_results.csv"
report_file="./reports/baseline_model_report.md"

#To check if the result file exist
if [[ ! -f $result_file ]]; then 
	echo "Result file not found ar $result_file"
	exit 1
fi

#extract the best model by F1 score

best)model=$(awk -F',' 'NR > 1 {if($3 > max) {max=$3; line=$0}} END {print line}' "result_file")

# generate the baseline model report
#extract model details

data_version=$(echo "$best_model" | awk -F',' '{print $1}')
model_name=$(echo "$best_model" | awk -F',' '{print $2}')
f1_score=$(echo "$best_model" | awk -F',' '{print $3}')
accuracy=$(echo "$best_model" | awk -F',' '{print $4}')
confusion_matrix_image="images/${data_version}_${model_name}_confusion_matrix.png"

#write report
cat << EOF > "$report_file"
# Baseline Model Report

**Data Version**: $data_version
**Model Name**: $model_name
**F1 Score**: $f1_score
**Accuracy**: $accuracy

### Confusion Matrix
![Confusion Matrix]($confusion_matrix_image)
EOF

