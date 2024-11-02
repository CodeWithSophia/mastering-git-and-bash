#!/bin/bash
result_file="reports/baseline_model_results.csv"
report_file=baseline_model_report.md

#extract the best model by F1 score

best_model=$(sort -t, -k5 -rg "$result_file" | head -n 1)

#extract model details

data_version=$(echo "$best_model" | awk -F, '{print $1}')
model_name=$(echo "$best_model" | awk -F, '{print $2}')
precision=$(echo "$best_model" | awk -F, '{print $3}')
recall=$(echo "$best_model" | awk -F, '{print $4}')
f1_score=$(echo "$best_model" | awk -F, '{print $5}')
roc_auc=$(echo "$best_model" | awk -F, '{print $6}')

directory="reports"
confusion_matrix_image=$(echo "$best_model" | awk -F, '{print $1 "_" $2}' | sed 's/,/_/g')

#write report
cat <<EOF > "$report_file"
# Baseline Model Report

* **Data Version**: $data_version
* **Model Name**: $model_name

* **F1 Score**: $f1_score
* **Recall**: $recall
* **ROC_AUC**: $roc_auc

### Confusion Matrix
![Model Image](reports/data${confusion_matrix_image}_confusion_matrix.png)

EOF

