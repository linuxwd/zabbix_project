#!/bin/bash
#set -x
Device=$1
DISK=$2

case $DISK in 
###rrqm/s： 每秒进行 merge 的读操作数目.即 delta(rmerge)/s
    rrqm)
        iostat -dxk 1 2|grep "\b$Device\b" |tail -1| awk '{print $2}'
        ;;
###wrqm/s： 每秒进行 merge 的写操作数目.即 delta(wmerge)/s
    wrqm)
        iostat -dxk 1 2|grep "\b$Device\b" |tail -1| awk '{print $3}'
        ;;
###r/s： 每秒完成的读 I/O 设备次数.即 delta(rio)/s
    rps)
        iostat -dxk 1 2|grep "\b$Device\b" |tail -1|awk '{print $4}'
        ;;
###w/s： 每秒完成的写 I/O 设备次数.即 delta(wio)/s
    wps)
        iostat -dxk 1 2|grep "\b$Device\b" |tail -1|awk '{print $5}'
        ;;
###rkB/s： 每秒读K字节数.是 rsect/s 的一半,因为每扇区大小为512字节.(需要计算)
    rKBps)
        iostat -dxk 1 2|grep "\b$Device\b" |tail -1|awk '{print $6}'
        ;;
###wkB/s： 每秒写K字节数.是 wsect/s 的一半.(需要计算)
    wKBps)
        iostat -dxk 1 2|grep "\b$Device\b" |tail -1|awk '{print $7}'
        ;;
###avgrq-sz：平均每次设备I/O操作的数据大小 (扇区).delta(rsect+wsect)/delta(rio+wio)
    avgrq-sz)
        iostat -dxk 1 2|grep "\b$Device\b" |tail -1|awk '{print $8}'
        ;;
###avgqu-sz：平均I/O队列长度.即 delta(aveq)/s/1000 (因为aveq的单位为毫秒).
    avgqu-sz)
        iostat -dxk 1 2|grep "\b$Device\b" |tail -1|awk '{print $9}'
        ;;
###await： 平均每次设备I/O操作的等待时间 (毫秒).即 delta(ruse+wuse)/delta(rio+wio)
    await)
        iostat -dxk 1 2|grep "\b$Device\b" |tail -1|awk '{print $10}'
        ;;
#每秒读扇区数。即 delta(rsect)/s
    rawait)
        iostat -dxk 1 2|grep "\b$Device\b" |tail -1|awk '{print $11}'
        ;;
#wsec/s： 每秒写扇区数.即 delta(wsect)/s		
    wawait)
        iostat -dxk 1 2|grep "\b$Device\b" |tail -1|awk '{print $12}'
        ;;		
##svctm： 平均每次设备I/O操作的服务时间 (毫秒).即 delta(use)/delta(rio+wio)
    svctm)
        iostat -dxk 1 2|grep "\b$Device\b" |tail -1|awk '{print $13}'
        ;;
##%util： 一秒中有百分之多少的时间用于 I/O 操作,或者说一秒中有多少时间 I/O,也就是磁盘IO带宽使用率
    util)
        iostat -dxk 1 2|grep "\b$Device\b" |tail -1|awk '{print $14}'
        ;;

    DiskAvaliable)
        df -k | head -2 | grep "\b$Device\b" | awk '{print $4}'
        ;;
    *)
        echo -e "\e[033mUsage: sh $0 [rrqm|wrqm|rps|wps|rKBps|wKBps|avgqu-sz|avgrq-sz|await|svctm|util]\e[0m"
esac