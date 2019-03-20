#!/bin/bash  
#this script is used to get tcp and udp connetion  
#tcp
#可以使用man netstat查看TCP的各种状态信息描述  
#ESTABLISHED       socket已经建立连接  
#CLOSED            socket没有被使用，无连接  
#CLOSING           服务器端和客户端都同时关闭连接  
#CLOSE_WAIT        等待关闭连接  
#TIME_WAIT         表示收到了对方的FIN报文，并发送出了ACK报文，等待2MSL后就可回到CLOSED状态  
#LAST_ACK          远端关闭，当前socket被动关闭后发送FIN报文，等待对方ACK报文  
#LISTEN            监听状态  
#SYN_RECV          接收到SYN报文  
#SYN_SENT          已经发送SYN报文  
#FIN_WAIT1         The socket is closed, and the connection is shutting down  
#FIN_WAIT2         Connection is closed, and the socket is waiting for a shutdown from the remote end.  
metric=$1  
tmp_file=/tmp/tcp_status.txt  
status() {
	/bin/netstat -ant|awk '/^tcp/{++S[$NF]}END{for(a in S) print a,S[a]}'
}
 
   
case $metric in  
   closed)
          output=$(status|awk '/CLOSED/{print $2}')
          if [ "$output" == "" ];then  
             echo 0  
          else  
             echo $output  
          fi  
        ;;  
   listen)
          output=$(status|awk '/LISTEN/{print $2}' )
          if [ "$output" == "" ];then  
             echo 0  
          else  
             echo $output  
          fi  
        ;;  
   synrecv)
          output=$(status|awk '/SYN_RECV/{print $2}')
          if [ "$output" == "" ];then  
             echo 0  
          else  
             echo $output  
          fi  
        ;;  
   synsent)
          output=$(status|awk '/SYN_SENT/{print $2}')
          if [ "$output" == "" ];then  
             echo 0  
          else  
             echo $output  
          fi  
        ;;  
   established)
          output=$(status|awk '/ESTABLISHED/{print $2}')
          if [ "$output" == "" ];then  
             echo 0  
          else  
             echo $output  
          fi  
        ;;  
   timewait)
          output=$(status|awk '/TIME_WAIT/{print $2}')
          if [ "$output" == "" ];then  
             echo 0  
          else  
             echo $output  
          fi  
        ;;  
   closing)
          output=$(status|awk '/CLOSING/{print $2}')
          if [ "$output" == "" ];then  
             echo 0  
          else  
             echo $output  
          fi  
        ;;  
   closewait)
          output=$(status|awk '/CLOSE_WAIT/{print $2}')
          if [ "$output" == "" ];then  
             echo 0  
          else  
             echo $output  
          fi  
        ;;  
   lastack)
          output=$(status|awk '/LAST_ACK/{print $2}')
          if [ "$output" == "" ];then  
             echo 0  
          else  
             echo $output  
          fi  
         ;;  
   finwait1)
          output=$(status|awk '/FIN_WAIT1/{print $2}')
          if [ "$output" == "" ];then  
             echo 0  
          else  
             echo $output  
          fi  
         ;;  
   finwait2)
          output=$(status|awk '/FIN_WAIT2/{print $2}')
          if [ "$output" == "" ];then  
             echo 0  
          else  
             echo $output  
          fi  
         ;;  
         *)
          echo -e "\e[033mUsage: sh  $0 [closed|closing|closewait|synrecv|synsent|finwait1|finwait2|listen|established|lastack|timewait]\e[0m"  
     
esac  