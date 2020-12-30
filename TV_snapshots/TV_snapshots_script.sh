#! /bin/bash

while :
do


nohup ffmpeg -ss 00:00:01 -i "http://192.168.115.15/hls/tv1_high.m3u8?md5=WUl-H_MNCZX49vkshIVx5A&expires=1574758350421" -y -f image2 -vframes 1  tv1_snapshot.jpg > /dev/null
curl -T "tv1_snapshot.jpg" -u armaghantv:Armaghantv@123 ftp://192.168.115.150:


nohup ffmpeg -ss 00:00:01 -i "http://192.168.115.15/hls/tv2_high.m3u8?md5=WUl-H_MNCZX49vkshIVx5A&expires=1574758350421" -y -f image2 -vframes 1  tv2_snapshot.jpg > /dev/null
curl -T "tv2_snapshot.jpg" -u armaghantv:Armaghantv@123 ftp://192.168.115.150:

nohup ffmpeg -ss 00:00:01 -i "http://192.168.115.15/hls/tv3_high.m3u8?md5=WUl-H_MNCZX49vkshIVx5A&expires=1574758350421" -y -f image2 -vframes 1  tv3_snapshot.jpg > /dev/null
curl -T "tv3_snapshot.jpg" -u armaghantv:Armaghantv@123 ftp://192.168.115.150:

nohup ffmpeg -ss 00:00:01 -i "http://192.168.115.15/hls/tv4_high.m3u8?md5=WUl-H_MNCZX49vkshIVx5A&expires=1574758350421" -y -f image2 -vframes 1  tv4_snapshot.jpg > /dev/null
curl -T "tv4_snapshot.jpg" -u armaghantv:Armaghantv@123 ftp://192.168.115.150:

nohup ffmpeg -ss 00:00:01 -i "http://192.168.115.15/hls/tv5_high.m3u8?md5=WUl-H_MNCZX49vkshIVx5A&expires=1574758350421" -y  -f image2 -vframes 1  tv5_snapshot.jpg > /dev/null
curl -T "tv5_snapshot.jpg" -u armaghantv:Armaghantv@123 ftp://192.168.115.150:

nohup ffmpeg -ss 00:00:01 -i "http://192.168.115.15/hls/irinn_high.m3u8?md5=WUl-H_MNCZX49vkshIVx5A&expires=1574758350421" -y -f image2 -vframes 1  irinn_snapshot.jpg > /dev/null
curl -T "irinn_snapshot.jpg" -u armaghantv:Armaghantv@123 ftp://192.168.115.150:

nohup ffmpeg -ss 00:00:01 -i "http://192.168.115.15/hls/razavi.m3u8?md5=WUl-H_MNCZX49vkshIVx5A&expires=1574758350421" -y -f image2 -vframes 1  razavi_snapshot.jpg  > /dev/null
curl -T "razavi_snapshot.jpg" -u armaghantv:Armaghantv@123 ftp://192.168.115.150:

nohup ffmpeg -ss 00:00:01 -i "http://192.168.115.15/hls/abbas.m3u8?md5=WUl-H_MNCZX49vkshIVx5A&expires=1574758350421" -y -f image2 -vframes 1  abbas_snapshot.jpg > /dev/null
curl -T "abbas_snapshot.jpg" -u armaghantv:Armaghantv@123 ftp://192.168.115.150:

nohup ffmpeg -ss 00:00:01 -i "http://192.168.115.15/hls/varzesh_high.m3u8?md5=WUl-H_MNCZX49vkshIVx5A&expires=1574758350421" -y  -f image2 -vframes 1  varzesh_snapshot.jpg > /dev/null
curl -T "varzesh_snapshot.jpg" -u armaghantv:Armaghantv@123 ftp://192.168.115.150:

nohup ffmpeg -ss 00:00:01 -i "http://192.168.115.15/hls/koodak_high.m3u8?md5=WUl-H_MNCZX49vkshIVx5A&expires=1574758350421" -y -f image2 -vframes 1  koodak_snapshot.jpg > /dev/null
curl -T "koodak_snapshot.jpg" -u armaghantv:Armaghantv@123 ftp://192.168.115.150:

nohup ffmpeg -ss 00:00:01 -i "http://192.168.115.15/hls/tanzil_high.m3u8?md5=WUl-H_MNCZX49vkshIVx5A&expires=1574758350421" -y -f image2 -vframes 1  tanzil_snapshot.jpg > /dev/null
curl -T "tanzil_snapshot.jpg" -u armaghantv:Armaghantv@123 ftp://192.168.115.150:

nohup ffmpeg -ss 00:00:01 -i "http://192.168.115.15/hls/consert.m3u8?md5=WUl-H_MNCZX49vkshIVx5A&expires=1574758350421" -y -f image2 -vframes 1  music_snapshot.jpg > /dev/null
curl -T "music_snapshot.jpg" -u armaghantv:Armaghantv@123 ftp://192.168.115.150:

sleep 10
done
