#!/bin/bash

# このスクリプトは？
# nvencを使用してエンコードするスクリプト。
# エンコードの出力先やログの出力先は出力先は/media/tv_recordと決め打ちにしている。
# 変更する場合はスクリプトそのものを変更すること。

log=/media/tv_record/encode.log
dir_output="/media/tv_record"
outfile=${1%.*}hevc_nvenc.mp4
mp4file=${outfile##*/}

echo -----start encoding @$(date +%Y/%m/%d/%H:%M:%S)----- >> $log
start=$(date +%s)
echo $1 >> $log

ffmpeg -i "$1" -vcodec hevc_nvenc -preset 6 "${dir_output}/${mp4file}" 2>&1 | grep "^[^f]" >> $log

end=$(date +%s)
diff=$(expr $end - $start)
echo about $(expr $diff / 60) min. >> $log
echo ---finish encoding @$(date +%Y/%m/%d/%H:%M:%S)--- >> $log
echo >> $log


exit 0
