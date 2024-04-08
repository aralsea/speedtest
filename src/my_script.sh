#!/bin/bash

output_file="test.json"

# JSONファイルが存在しない場合は、空の配列を作成
if [ ! -f $output_file ]; then
    echo "[]" > $output_file
fi

while true; do
    # speedtestを実行し、結果をJSONで取得
    result=$(speedtest --json)
    
    # speedtestの結果をチェック
    if [ $? -eq 0 ]; then
        # 新しい結果をJSONファイルに追加
        jq --argjson result "$result" '. += [$result]' $output_file > tmp.json
        mv tmp.json $output_file
    else
        echo "Speedtest failed. Skipping this iteration."
    fi
    
    sleep 300 # 1分ごとに計測（秒数は適宜変更）
done