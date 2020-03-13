#!/bin/bash

echo $1:$2 > /root/.passwd-s3fs

chmod 600 /root/.passwd-s3fs

s3fs -f $3 /mnt/ \
-o uid=$4 -o gid=$5 -o umask=0022 \
-o url=$6 -o passwd_file=/root/.passwd-s3fs \
-o curldbg,use_path_request_style,allow_other \
-o retries=1 \
-o multipart_size="8" \
-o multireq_max="8" \
-o parallel_count="32" \