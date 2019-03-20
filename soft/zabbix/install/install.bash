#!/bin/bash
set -x
echo "脚本作者:火星小刘 web:www.huoxingxiaoliu.com email:xtlyk@163.com"


#Configure fping info
FPING_VERSION="4.2"
FPING_SOFT_DIR="/root/soft/fping"
FPING_INSTALL_DIR="/usr/local/fping"


#sleep 10
ZABBIX_SOFTWARE_DOWNLOAD_DIR="/root/soft/zabbix"
ZABBIX_SOFTWARE_INSTALL_DIR="/usr/local/zabbix"
ZABBIX_HTML_DIR="/var/www/html/zabbix"
Zabbix_Server_Version="4.0.5"
Zabbix_Agents_For_Windows_Version="4.0.5"
#Zabbix_Agents_For_CentOS_Version="4.0.5"
#zabbix pid 目录
ZABBIX_RUN_DIR="/tmp/zabbix"

#zabbix server的export文件夹
ZABBIX_Server_ExportDir=${ZABBIX_SOFTWARE_INSTALL_DIR}/export
#zabbix server的expoert文件大小
ZABBIX_Server_ExportFileSize=1G
#zabbix用户是用于运行zabbix软件的安装
ZABBIX_USER=zabbix
ZABBIX_USER_UID=801
ZABBIX_GROUP=zabbix
ZABBIX_GROUP_GID=801
ZABBIX_USER_PASSWORD=zabbix

#Zabbix服务器地址
ZABBIX_SERVER_IP="192.168.6.101"


#指定ZABBIX服务端的监听端口，用于监听Proxy或Agent的连接请求。
ZABBIX_Server_ListenPort=10051

#日志达到多少M里就轮转；若此参数值为0时，则不轮转，日志将不断变大，建议设置成轮转
ZABBIX_Server_LogFileSize=32

#zabbix日志级别
#   0 - basic information about starting and stopping of Zabbix processes 无日志
#   1 - critical information  灾难日志，日志量较少
#   2 - error information  错误级别，日志量大于CRITICAL级别
#   3 - warnings    告警级别，日志量大于ERROR级别
#   4 - for debugging (produces lots of information)调试级别，日志量大于WARNING
#   5 - extended debugging (produces even more information)
#说明：日志级别0~4，单位时间内生成日志的量不断增大
ZABBIX_Server_DebugLevel=4

#Zabbix进程数，初始化时，启动子进程数量，数量越多，则服务端吞吐能力越强，对系统资源消耗越大
ZABBIX_Server_StartPollers=16

#检查unreachable host（包括IPMI）的进程数
#默认情况下，ZABBIX会启用指定进程用于探测某些不可达主机的（含IPMI场景）；
#若使用场景中含有代理端，建议保持默认；若直接agent较多，可视具体情况调整
ZABBIX_Server_StartPollersUnreachable=16

#Trappers（zabbix采集器）进程数，Trappers用于接收其它host用zabbix_sender、active_agents发送的数据，
#至少需要一个Trapper进程用来在前端显示Zabbix Server可用性
#用于设置诸如SNMP STRAPPER场景提交来的数据的接收进程数，若客户机SNMP TRAPPER技术较多，建议加大此参数值
ZABBIX_Server_StartTrappers=16

#用于设置启用icmp协议PING主机方式启动线程数量，若单台代理所管理机器超过500台，建议加大此数值
ZABBIX_Server_StartPingers=8

#用于自动发现(Discovery)的discovery的进程数
#用于设置自动发现主机的线程数量，若单台代理所管理机器超过500台，可以考虑加大此数值（仅适用于直接AGENT场景）
ZABBIX_Server_StartDiscoverers=16

#用于HTTP检查的进程数
#用于设置WEB拨测监控线程数，可视具体情况增加或减少此数值。
ZABBIX_Server_StartHTTPPollers=8

#Zabbix各实例计时器数量，主要用于触发器，标有维护标识的主机，但只第一个计时器用于计算维护标识主机。
ZABBIX_Server_StartTimers=4

#用于处理动作中的步骤的进程，zabbix动作较多时建议调大。
ZABBIX_Server_StartAlerters=32

#用于设置监控VMWARE Esxi主机实例时使用，若为0则不启用，若要监控ESXI主机，此值最少为1 ；视监控ESXI数量设置对应数值
ZABBIX_Server_StartVMwareCollectors=0

#设置代理端访问 VMWARE service的频率，单位:秒
ZABBIX_Server_VMwareFrequency=60

#从单个VMware服务检索性能计数器统计信息之间的延迟(秒)。
ZABBIX_Server_VMwarePerfFrequency=60

#划出多少共享内存用于存储VMWARE数据
ZABBIX_Server_VMwareCacheSize=256M

#说明：等待VMWare返回数据的最长时间
ZABBIX_Server_VMwareTimeout=10

#说明：指定SNMP TRAPPER 时的临时文件，用于代理端启用SNMP TRAPPER功能时使用
ZABBIX_Server_SNMPTrapperFile="${ZABBIX_RUN_DIR}/zabbix_traps.tmp"

#说明：是否启用 snmptrapper功能 ，默认不启用=0，启用=1（配合参数SNMPTrapperFile使用）
ZABBIX_Server_StartSNMPTrapper=0

#说明：多少小时清理一次代理端数据库的 history, alert, and alarms，以保持代理端数据库轻便，建议保持默认
ZABBIX_Server_HousekeepingFrequency=1

#每个HouseKeeper任务删除的最大记录数，1.8.2开始支持
ZABBIX_Server_MaxHousekeeperDelete=1000000

#存储Host、Item和Trgger数据的内存空间
ZABBIX_Server_CacheSize=1G

#说明：zabbix更新操作系统CACHE频率，若管理页面操作不频繁，可以考虑加大参数值
ZABBIX_Server_CacheUpdateFrequency=60

#说明:将采集数据从CACHE同步到数据库线程数量，视数据库服务器I/O繁忙情况，和数据库写能力调整。数值越大，写能力越强。对数据库服务器I/O压力越大。
ZABBIX_Server_StartDBSyncers=8

#存储History数据的内存大小
ZABBIX_Server_HistoryCacheSize=2048M

#存储历史索引缓存共享内存的大小
ZABBIX_Server_HistoryIndexCacheSize=2048M

#说明：用于设置划分多少系统共享内存用于存储计算出来的趋势数据，此参数值从一定程度上可影响数据库读压力
ZABBIX_Server_TrendCacheSize=1024M

#说明：划出系统多少共享内存用于已请求的存储监控项信息，若监控项较多，建议加大此数值
ZABBIX_Server_ValueCacheSize=8G

#超时时间
#与AGNET\SNMP设备和其它外部设备通信超时设置，单位为秒；
#若采集数据不完整或网络繁忙，或从管理页面发现客户端状态变化频繁，可以考虑加大此数值。
#注意若此数值加大，应该考虑参数 StartPollers 是否有相应加大的必要。
ZABBIX_Server_Timeout=10

#说明：启用 trapper功能，用于进程等待超时设置。根据需要调整
ZABBIX_Server_TrapperTimeout=50

#说明：当AGNET端处于不可用状态下，间隔多少秒后，尝试重新连接。建议根据具体情况设置。注意，若此数值过小，右agent端业务系统繁忙时，有可能造成报警信息误报
ZABBIX_Server_UnreachablePeriod=45

#说明:当AGENT端处于可用状态下，间隔多少秒后，进行状态检查。若出现可正常采集数据，但管理页面AGENT状态不正常；若在网络，端口等均通畅情况下，AGENT状态仍不正常，可以考虑加大此数值
ZABBIX_Server_UnavailableDelay=60

#说明：当agent端处于不可达状态下，延迟多少秒后，进行重新尝试，建议保持默认，在AGENT接入调试阶段，可考虑减少此数值
ZABBIX_Server_UnreachableDelay=15

#Fping路径
ZABBIX_Server_FpingLocation=${FPING_INSTALL_DIR}/sbin/fping

#多慢的数据库查询将会被记录，单位：毫秒，
#0表示不记录慢查询。只有在DebugLevel=3时，这个配置才有效
#用于服务端数据库慢查询功能，单位是毫秒；1毫秒=0.001秒，若有服务端数据库监控慢查询的需求，可以视具体情况调整此数。
ZABBIX_Server_LogSlowQueries=1000

#说明：zabbix服务端工作的临时目录
ZABBIX_Server_TmpDir=${ZABBIX_SOFTWARE_INSTALL_DIR}/tmp

#说明:启用多少子进程与代理端通信，若代理端较多可考虑加大此数值
ZABBIX_Server_StartProxyPollers=4

#说明：zabbix服务端将配置文件数据同步到代理端的频率，仅适用于代理端为被动模式情况下
ZABBIX_Server_ProxyConfigFrequency=3600

#说明：zabbix服务端请求代理端采集的数据的频率，仅适用代理端为被动模式情况下
ZABBIX_Server_ProxyDataFrequency=1

#值为1就允许root启动，为0则不允许
ZABBIX_Server_AllowRoot=0

#zabbix进程启动用户
ZABBIX_Server_User=${ZABBIX_USER}

#ZABBIX_Server_Include链接文件
ZABBIX_Server_Include="${ZABBIX_SOFTWARE_INSTALL_DIR}/etc/zabbix_server.conf.d/*.conf"

#日志文件类型
ZABBIX_SERVER_LOGTYPE="file"



#zabbix 日志目录
ZABBIX_LOGFILE_DIR="/var/log/zabbix"

#zabbix socket 目录
ZABBIX_SERVER_SocketDir="/tmp/zabbix"

#cpu_number,用于make -j参数的数量
CPU_NUM=$(cat /proc/cpuinfo | grep processor | wc -l)

#数据库ROOT用户密码
SQL_DB_ROOT_PASSWORD="Abcd1234"

#zabbix数据库名
ZABBIX_SQL_DB_NAME="zabbix"

#zabbix数据库用户
ZABBIX_SQL_DB_USER="zabbix"

#zabbix数据库密码
ZABBIX_SQL_DB_PASSWORD="zabbix"

#Zabbix数据库类型
ZABBIX_DB_SERVER_TYPE="MYSQL"

#Zabbix数据库地址
ZABBIX_DB_SERVER_IP="192.168.6.101"

#Zabbix数据库端口
ZABBIX_DB_SERVER_PORT="3306"

#Zabbix agentd pid 目录
ZABBIX_AGENTD_RUN_DIR=${ZABBIX_RUN_DIR}

#Zabbix agentd 日志目录
ZABBIX_AGENTD_LOGFILE_DIR=${ZABBIX_LOGFILE_DIR}

#Zabbix agentd日志文件类型
ZABBIX_AGENTD_LOGTYPE=${ZABBIX_SERVER_LOGTYPE}

#Zabbix agentd日志达到多少M里就轮转；若此参数值为0时，则不轮转，日志将不断变大，建议设置成轮转
ZABBIX_AGENTD_LogFileSize=${ZABBIX_Server_LogFileSize}

#Zabbix agentd日志级别
#   0 - basic information about starting and stopping of Zabbix processes
#   1 - critical information  灾难日志，日志量较少
#   2 - error information  错误级别，日志量大于CRITICAL级别
#   3 - warnings    告警级别，日志量大于ERROR级别
#   4 - for debugging (produces lots of information)调试级别，日志量大于WARNING
#   5 - extended debugging (produces even more information)
#说明：日志级别0~4，单位时间内生成日志的量不断增大
ZABBIX_AGENTD_DebugLevel=${ZABBIX_Server_DebugLevel}

#是否允许zabbix server端的远程指令， 0表示不允许， 1表示允许
ZABBIX_AGENTD_EnableRemoteCommands=0

#是否开启日志记录shell命令作为警告 0表示不允许，1表示允许 
ZABBIX_AGENTD_LogRemoteCommands=0

#zabbix agent监听的端口  
ZABBIX_AGENTD_ListenPort=10050

#zabbix agent监听的ip地址
ZABBIX_AGENTD_ListenIP=`ifconfig eth0 | grep "inet" | awk '{ print $2}'`

#zabbix agent开启进程数  
ZABBIX_AGENTD_StartAgents=3

#zabbix agent开启主动检查ip地址设置成zabbix server的地址
ZABBIX_AGENTD_ServerActive=${ZABBIX_SERVER_IP}

#在zabbix server前端配置时指定的主机名要相同，最重要的配置 
ZABBIX_AGENTD_Hostname=`ip addr |grep inet |egrep -v "inet6|127.0.0.1" |awk '{print $2}' |awk -F "/" '{print $1}'|sed 's/\./_/g'`

#主动检查刷新的时间，单位为秒数  
ZABBIX_AGENTD_RefreshActiveChecks=120

#数据缓冲的时间  
ZABBIX_AGENTD_BufferSend=5

#zabbix agent数据缓冲区的大小，当达到该值便会发送所有的数据到zabbix server  
ZABBIX_AGENTD_BufferSize=100

#zabbix agent发送给zabbix server最大的数据行
ZABBIX_AGENTD_MaxLinesPerSecond=100

#是否允许zabbix agent 以root用户运行 .值为1就允许root启动，为0则不允许
ZABBIX_AGENTD_AllowRoot=0

#ZABBIX_Agent_Include链接文件.包含子配置文件的路径
ZABBIX_AGENTD_Include="${ZABBIX_SOFTWARE_INSTALL_DIR}/etc/zabbix_agentd.conf.d/*.conf"

#设定处理超时的时间  
ZABBIX_AGENTD_Timeout=3

#是否允许所有字符参数的传递  
ZABBIX_AGENTD_UnsafeUserParameters=1

#指定用户自定义参数  
ZABBIX_AGENTD_UserParameter=

#zabbix agentd 脚本文件路径
ZABBIX_AGENTD_SCRIPT_DIR="${ZABBIX_SOFTWARE_INSTALL_DIR}/script"

#设置zabbix proxy模式，0为主动模式，1为被动模式
ZABBIX_PROXY_ProxyMode=0

#指定zabbix server的ip地址或主机名  
ZABBIX_PROXY_Server=192.168.100.100

ZABBIX_PROXY_ServerPort=10051

#定义监控代理的主机名，需和zabbix server前端配置时指定的节点名相同  
ZABBIX_PROXY_Hostname=`ip addr |grep inet |egrep -v "inet6|127.0.0.1" |awk '{print $2}' |awk -F "/" '{print $1}'|sed 's/\./_/g'`

ZABBIX_PROXY_ListenPort=10051

ZABBIX_PROXY_SourceIP=${ZABBIX_SERVER_IP}

#日志文件类型
ZABBIX_PROXY_LOGTYPE="file"

#指定日志文件的位置  
ZABBIX_PROXY_LogFile=${ZABBIX_LOGFILE_DIR}

#日志达到多少M里就轮转；若此参数值为0时，则不轮转，日志将不断变大，建议设置成轮转
ZABBIX_PROXY_LogFileSize=32

#zabbix日志级别
#   0 - basic information about starting and stopping of Zabbix processes 无日志
#   1 - critical information  灾难日志，日志量较少
#   2 - error information  错误级别，日志量大于CRITICAL级别
#   3 - warnings    告警级别，日志量大于ERROR级别
#   4 - for debugging (produces lots of information)调试级别，日志量大于WARNING
#   5 - extended debugging (produces even more information)
#说明：日志级别0~4，单位时间内生成日志的量不断增大
ZABBIX_PROXY_DebugLevel=4

#是否允许zabbix server端的远程指令， 0表示不允许， 1表示允许
ZABBIX_PROXY_EnableRemoteCommands=0

#是否开启日志记录shell命令作为警告 0表示不允许，1表示允许
ZABBIX_PROXY_LogRemoteCommands=0

#pid文件的位置  
ZABBIX_PROXY_RUN_DIR=${ZABBIX_RUN_DIR}

#ZABBIX_PROXY连接数据库的地址
ZABBIX_PROXY_DB_SERVER_IP=${ZABBIX_DB_SERVER_IP}

#ZABBIX_PROXY数据库名  
ZABBIX_PROXY_DBName=zabbix_proxy

#ZABBIX_PROXY连接数据库的用户  
ZABBIX_PROXY_DBUser=zabbix_proxy

#ZABBIX_PROXY连接数据库用户的密码  
ZABBIX_PROXY_DBPassword=zabbix_proxy

#ZABBIX_PROXY数据库端口
ZABBIX_PROXY_DBPort=3306

#设置zabbix proxy暂存在本地mysql的监控数据的时间。默认是0，不暂存。
#即使zabbix proxy已经把数据发送给了zabbix server，还是会暂存数据在本地设置的时间。取值范围是0~720小时
ZABBIX_PROXY_ProxyLocalBuffer=360

#设置当zabbix proxy与zabbix server无法连接时保留监控数据的时间间隔。默认是1小时，取值是1~720小时
#这个参数特别有用，我就是在之前的几次维护中，停掉zabbix server后没有设置zabbix proxy的这个参数，
#所以当维护结束后启动zabbix server，会发现有段时间内的数据没有。这是因zabbix proxy按照默认的保留时间执行housekeeper把过期的数据删除了。
#这个时间根据最好根据要维护的时间来设定，比如要维护10个小时，那么就要设置ProxyOfflineBuffer=10
#这样就不至于这10个小时之间的数据都丢失了。也有一个问题，如果时间间隔太大的话，zabbix proxy重新推送数据到zabbix server会导致双方的服务器压力都会增大
ZABBIX_PROXY_ProxyOfflineBuffer=360

#每隔多少秒探测一下zabbix server服务器的活动状态
ZABBIX_PROXY_HeartbeatFrequency=60

#zabbix proxy从zabbix server取得配置数据的频率
#每隔多少秒到服务器端拉取相关配置
ZABBIX_PROXY_ConfigFrequency=60

#zabbix proxy发送监控到的数据给zabbix server的频率
#每隔多少秒就发送一次数据到服务器端，发送数据后会自动删除的，所以本地保存数据量很少
ZABBIX_PROXY_DataSenderFrequency=60

#Zabbix进程数，初始化时，启动子进程数量，数量越多，则服务端吞吐能力越强，对系统资源消耗越大
ZABBIX_PROXY_StartPollers=${ZABBIX_Server_StartPollers}

#检查unreachable host（包括IPMI）的进程数
#默认情况下，ZABBIX会启用指定进程用于探测某些不可达主机的（含IPMI场景）；
#若使用场景中含有代理端，建议保持默认；若直接agent较多，可视具体情况调整
ZABBIX_PROXY_StartPollersUnreachable=${ZABBIX_Server_StartPollersUnreachable}

#Trappers（zabbix采集器）进程数，Trappers用于接收其它host用zabbix_sender、active_agents发送的数据，
#至少需要一个Trapper进程用来在前端显示Zabbix Server可用性
#用于设置诸如SNMP STRAPPER场景提交来的数据的接收进程数，若客户机SNMP TRAPPER技术较多，建议加大此参数值	
ZABBIX_PROXY_StartTrappers=${ZABBIX_Server_StartTrappers}

#用于设置启用icmp协议PING主机方式启动线程数量，若单台代理所管理机器超过500台，建议加大此数值
ZABBIX_PROXY_StartPingers=${ZABBIX_Server_StartPingers}

#用于自动发现(Discovery)的discovery的进程数
#用于设置自动发现主机的线程数量，若单台代理所管理机器超过500台，可以考虑加大此数值（仅适用于直接AGENT场景）
ZABBIX_PROXY_StartDiscoverers=${ZABBIX_Server_StartDiscoverers}

#用于HTTP检查的进程数
#用于设置WEB拨测监控线程数，可视具体情况增加或减少此数值。
ZABBIX_PROXY_StartHTTPPollers=${ZABBIX_Server_StartHTTPPollers}

#用于设置监控VMWARE Esxi主机实例时使用，若为0则不启用，若要监控ESXI主机，此值最少为1 ；视监控ESXI数量设置对应数值
ZABBIX_PROXY_StartVMwareCollectors=${ZABBIX_Server_StartVMwareCollectors}
	
#设置代理端访问 VMWARE service的频率，单位:秒
ZABBIX_PROXY_VMwareFrequency=${ZABBIX_Server_VMwareFrequency}

#从单个VMware服务检索性能计数器统计信息之间的延迟(秒)。
ZABBIX_PROXY_VMwarePerfFrequency=${ZABBIX_Server_VMwarePerfFrequency}

#划出多少共享内存用于存储VMWARE数据
ZABBIX_PROXY_VMwareCacheSize=${ZABBIX_Server_VMwareCacheSize}

#说明：等待VMWare返回数据的最长时间
ZABBIX_PROXY_VMwareTimeout=${ZABBIX_Server_VMwareTimeout}

#说明：指定SNMP TRAPPER 时的临时文件，用于代理端启用SNMP TRAPPER功能时使用
ZABBIX_PROXY_SNMPTrapperFile=${ZABBIX_Server_SNMPTrapperFile}

#说明：是否启用 snmptrapper功能 ，默认不启用=0，启用=1（配合参数SNMPTrapperFile使用）
ZABBIX_PROXY_StartSNMPTrapper=${ZABBIX_Server_StartSNMPTrapper}

#zabbix proxy监听的ip地址
ZABBIX_PROXY_ListenIP=0.0.0.0

#说明：多少小时清理一次代理端数据库的 history, alert, and alarms，以保持代理端数据库轻便，建议保持默认
ZABBIX_PROXY_HousekeepingFrequency=${ZABBIX_Server_HousekeepingFrequency}

#存储Host、Item和Trgger数据的内存空间
ZABBIX_PROXY_CacheSize=${ZABBIX_Server_CacheSize}
	
#说明:将采集数据从CACHE同步到数据库线程数量，视数据库服务器I/O繁忙情况，和数据库写能力调整。数值越大，写能力越强。对数据库服务器I/O压力越大。
ZABBIX_PROXY_StartDBSyncers=${ZABBIX_Server_StartDBSyncers}

#存储History数据的内存大小	
ZABBIX_PROXY_HistoryCacheSize=${ZABBIX_Server_HistoryCacheSize}

#存储历史索引缓存共享内存的大小	
ZABBIX_PROXY_HistoryIndexCacheSize=${ZABBIX_Server_HistoryIndexCacheSize}

#超时时间
#与AGNET\SNMP设备和其它外部设备通信超时设置，单位为秒；
#若采集数据不完整或网络繁忙，或从管理页面发现客户端状态变化频繁，可以考虑加大此数值。
#注意若此数值加大，应该考虑参数 StartPollers 是否有相应加大的必要。
ZABBIX_PROXY_Timeout=${ZABBIX_Server_Timeout}

#说明：启用 trapper功能，用于进程等待超时设置。根据需要调整
ZABBIX_PROXY_TrapperTimeout=${ZABBIX_Server_TrapperTimeout}

#说明：当AGNET端处于不可用状态下，间隔多少秒后，尝试重新连接。建议根据具体情况设置。注意，若此数值过小，右agent端业务系统繁忙时，有可能造成报警信息误报
ZABBIX_PROXY_UnreachablePeriod=${ZABBIX_Server_UnreachablePeriod}
	
#说明:当AGENT端处于可用状态下，间隔多少秒后，进行状态检查。若出现可正常采集数据，但管理页面AGENT状态不正常；若在网络，端口等均通畅情况下，AGENT状态仍不正常，可以考虑加大此数值
ZABBIX_PROXY_UnavailableDelay=${ZABBIX_Server_UnavailableDelay}
	
#说明：当agent端处于不可达状态下，延迟多少秒后，进行重新尝试，建议保持默认，在AGENT接入调试阶段，可考虑减少此数值
ZABBIX_PROXY_UnreachableDelay=${ZABBIX_Server_UnreachableDelay}
	
#Fping路径
ZABBIX_PROXY_FpingLocation=${ZABBIX_Server_FpingLocation}

#多慢的数据库查询将会被记录，单位：毫秒，
#0表示不记录慢查询。只有在DebugLevel=3时，这个配置才有效
#用于服务端数据库慢查询功能，单位是毫秒；1毫秒=0.001秒，若有服务端数据库监控慢查询的需求，可以视具体情况调整此数。
ZABBIX_PROXY_LogSlowQueries=${ZABBIX_Server_LogSlowQueries}
	
#说明：zabbix服务端工作的临时目录
ZABBIX_PROXY_TmpDir=${ZABBIX_Server_TmpDir}

#值为1就允许root启动，为0则不允许
ZABBIX_PROXY_AllowRoot=${ZABBIX_Server_AllowRoot}

#zabbix进程启动用户
ZABBIX_PROXY_User=${ZABBIX_Server_User}

#ZABBIX_Server_Include链接文件
ZABBIX_PROXY_Include="${ZABBIX_SOFTWARE_INSTALL_DIR}/etc/zabbix_proxy.conf.d/*.conf"

SLEEP_TIME="1"







function download_zabbix_software () {
	mkdir -p ${ZABBIX_SOFTWARE_DOWNLOAD_DIR}
	echo "下载zabbix-server-${Zabbix_Server_Version}"
	sleep ${SLEEP_TIME}
	cd ${ZABBIX_SOFTWARE_DOWNLOAD_DIR}
	if [ ! -f zabbix-${Zabbix_Server_Version}.tar.gz ];then
		wget http://netix.dl.sourceforge.net/project/zabbix/ZABBIX%20Latest%20Stable/${Zabbix_Server_Version}/zabbix-${Zabbix_Server_Version}.tar.gz
	fi

	echo "下载zabbix_agents-${Zabbix_Agents_For_Windows_Version}-win-i386-openssl.zip"
	sleep ${SLEEP_TIME}
	cd ${ZABBIX_SOFTWARE_DOWNLOAD_DIR}
	if [ ! -f zabbix_agents-${Zabbix_Agents_For_Windows_Version}-win-i386-openssl.zip ];then
		wget https://assets.zabbix.com/downloads/${Zabbix_Agents_For_Windows_Version}/zabbix_agents-${Zabbix_Agents_For_Windows_Version}-win-i386-openssl.zip
	fi

	echo "下载zabbix_agents-${Zabbix_Agents_For_Windows_Version}-win-amd64-openssl.zip"
	sleep ${SLEEP_TIME}
	cd ${ZABBIX_SOFTWARE_DOWNLOAD_DIR}
	if [ ! -f zabbix_agents-${Zabbix_Agents_For_Windows_Version}-win-amd64-openssl.zip ];then
		wget https://assets.zabbix.com/downloads/${Zabbix_Agents_For_Windows_Version}/zabbix_agents-${Zabbix_Agents_For_Windows_Version}-win-amd64-openssl.zip
	fi

	echo "下载zabbix_agents-${Zabbix_Agents_For_Windows_Version}-win-i386.zip"
	sleep ${SLEEP_TIME}
	cd ${ZABBIX_SOFTWARE_DOWNLOAD_DIR}
	if [ ! -f zabbix_agents-${Zabbix_Agents_For_Windows_Version}-win-i386.zip ];then
		wget https://assets.zabbix.com/downloads/${Zabbix_Agents_For_Windows_Version}/zabbix_agents-${Zabbix_Agents_For_Windows_Version}-win-i386.zip
	fi

	echo "下载zabbix_agents-${Zabbix_Agents_For_Windows_Version}-win-amd64.zip"
	sleep ${SLEEP_TIME}
	cd ${ZABBIX_SOFTWARE_DOWNLOAD_DIR}
	if [ ! -f zabbix_agents-${Zabbix_Agents_For_Windows_Version}-win-amd64.zip ];then
		wget https://assets.zabbix.com/downloads/${Zabbix_Agents_For_Windows_Version}/zabbix_agents-${Zabbix_Agents_For_Windows_Version}-win-amd64.zip
	fi

#	echo "下载zabbix_agent-${Zabbix_Agents_For_CentOS_Version}-centos7-amd64.tar.gz"
#	sleep ${SLEEP_TIME}
#	cd ${ZABBIX_SOFTWARE_DOWNLOAD_DIR}
#	if [ ! -f zabbix_agent-${Zabbix_Agents_For_CentOS_Version}-centos7-amd64.tar.gz ];then
#		wget http://www.zabbix.com/downloads/${Zabbix_Agents_For_CentOS_Version}/zabbix_agent-${Zabbix_Agents_For_CentOS_Version}-centos7-amd64.tar.gz
#	fi

#	echo "下载zabbix_agent-${Zabbix_Agents_For_CentOS_Version}-centos7-amd64-gnutls.tar.gz"
#	sleep ${SLEEP_TIME}
#	cd ${ZABBIX_SOFTWARE_DOWNLOAD_DIR}
#	if [ ! -f zabbix_agent-${Zabbix_Agents_For_CentOS_Version}-centos7-amd64-gnutls.tar.gz ];then
#		wget http://www.zabbix.com/downloads/${Zabbix_Agents_For_CentOS_Version}/zabbix_agent-${Zabbix_Agents_For_CentOS_Version}-centos7-amd64-gnutls.tar.gz
#	fi

#	echo "下载zabbix_agent-${Zabbix_Agents_For_CentOS_Version}-centos7-amd64-openssl.tar.gz"
#	sleep ${SLEEP_TIME}
#	cd ${ZABBIX_SOFTWARE_DOWNLOAD_DIR}
#	if [ ! -f zabbix_agent-${Zabbix_Agents_For_CentOS_Version}-centos7-amd64-openssl.tar.gz ];then
#		wget http://www.zabbix.com/downloads/${Zabbix_Agents_For_CentOS_Version}/zabbix_agent-${Zabbix_Agents_For_CentOS_Version}-centos7-amd64-openssl.tar.gz
#	fi

#	echo "下载zabbix_agent-${Zabbix_Agents_For_CentOS_Version}-centos7-i386.tar.gz"
#	sleep ${SLEEP_TIME}
#	cd ${ZABBIX_SOFTWARE_DOWNLOAD_DIR}
#	if [ ! -f zabbix_agent-${Zabbix_Agents_For_CentOS_Version}-centos7-i386.tar.gz ];then
#		wget http://www.zabbix.com/downloads/${Zabbix_Agents_For_CentOS_Version}/zabbix_agent-${Zabbix_Agents_For_CentOS_Version}-centos7-i386.tar.gz
#	fi

#	echo "下载zabbix_agent-${Zabbix_Agents_For_CentOS_Version}-centos7-i386-gnutls.tar.gz"
#	sleep ${SLEEP_TIME}
#	cd ${ZABBIX_SOFTWARE_DOWNLOAD_DIR}
#	if [ ! -f zabbix_agent-${Zabbix_Agents_For_CentOS_Version}-centos7-i386-gnutls.tar.gz ];then
#		wget http://www.zabbix.com/downloads/${Zabbix_Agents_For_CentOS_Version}/zabbix_agent-${Zabbix_Agents_For_CentOS_Version}-centos7-i386-gnutls.tar.gz
#	fi

#	echo "下载zabbix_agent-${Zabbix_Agents_For_CentOS_Version}-centos7-i386-openssl.tar.gzz"
#	sleep ${SLEEP_TIME}
#	cd ${ZABBIX_SOFTWARE_DOWNLOAD_DIR}
#	if [ ! -f zabbix_agent-${Zabbix_Agents_For_CentOS_Version}-centos7-i386-openssl.tar.gz ];then
#		wget http://www.zabbix.com/downloads/${Zabbix_Agents_For_CentOS_Version}/zabbix_agent-${Zabbix_Agents_For_CentOS_Version}-centos7-i386-openssl.tar.gz
#	fi
}

function _create_groups () {
	getent group $1
	if [ "$?" -ne "0" ]; then
		/usr/sbin/groupadd -g $2 $1 2> /dev/null || :
		echo "The group $1 create success !!"
	fi
}

function _create_user () {
	getent passwd $1
	if [ "$?" -ne "0" ]; then
		/usr/sbin/useradd -u $2  -g $3 -c "Zabbix Monitoring System" -m -d /home/$1 -s /sbin/nologin $1
	fi
	echo $4 | passwd --stdin $1
#	echo 'export LANG="zh_CN.gb18030"' >> /home/$1/.bash_profile
	echo "The user $1 create success !!"
}

function create_user_and_group () {
	echo "创建${ZABBIX_USER}用户及所属组"
	_create_groups ${ZABBIX_GROUP} ${ZABBIX_GROUP_GID}
	_create_user ${ZABBIX_USER} ${ZABBIX_USER_UID} ${ZABBIX_GROUP_GID} ${ZABBIX_USER_PASSWORD} /sbin/nologin
	id -n -G ${ZABBIX_GROUP}
	sleep ${SLEEP_TIME}
}

function download_fping_software () {
mkdir -p ${FPING_SOFT_DIR}
cd ${FPING_SOFT_DIR}
	echo "fping-${FPING_VERSION}.tar.gz"
	sleep ${SLEEP_TIME}
	if [ ! -f fping-${FPING_VERSION}.tar.gz ];then
		wget https://github.com/schweikert/fping/releases/download/v${FPING_VERSION}/fping-${FPING_VERSION}.tar.gz
	fi
}

function install_fping_software () {
	cd ${FPING_SOFT_DIR}
	tar zxvf fping-${FPING_VERSION}.tar.gz
	cd fping-${FPING_VERSION}
	./configure --prefix=${FPING_INSTALL_DIR}
	make -j
	make install
	chmod u+s ${FPING_INSTALL_DIR}/sbin/fping
	cat > /etc/profile.d/fping.sh <<EOF
#!/bin/bash
#set -x
export FPING_HOME=/usr/local/fping
export PATH=\${FPING_HOME}/sbin:\${PATH}
export FPING_HOME PATH
EOF
	source /etc/profile
	ldconfig -v
	sleep ${SLEEP_TIME}
}

function install_JDK_software (){
	rpm -ivh /root/soft/JDK/8/jdk-8u202-linux-x64.rpm
	cat > /etc/profile.d/jdk.sh <<EOF
#!/bin/bash
#set -x
export JAVA_HOME=/usr/java/default
export JRE_HOME=\${JAVA_HOME}/jre
export CLASSPATH=.:\${JAVA_HOME}/lib:\${JRE_HOME}/lib:$CLASSPATH
export JAVA_PATH=\${JAVA_HOME}/bin:\${JRE_HOME}/bin
export PATH=\${JAVA_PATH}:\$PATH
export JAVA_HOME JRE_HOME CLASSPATH JAVA_PATH PATH
EOF

	source /etc/profile
	ldconfig -v
	sleep ${SLEEP_TIME}
}

function install_zabbix_server_software () {
	cd ${ZABBIX_SOFTWARE_DOWNLOAD_DIR}
	tar zxvf zabbix-${Zabbix_Server_Version}.tar.gz
	cd zabbix-${Zabbix_Server_Version}
	echo `pwd`
	sleep ${SLEEP_TIME}
	./configure --prefix=${ZABBIX_SOFTWARE_INSTALL_DIR} \
				--enable-server \
				--enable-agent \
				--enable-proxy \
				--enable-java \
				--enable-ipv6 \
				--with-mysql \
				--with-libxml2 \
				--with-unixodbc \
				--with-net-snmp \
				--with-ssh2 \
				--with-openipmi \
				--with-zlib \
				--with-libevent \
				--with-gnutls \
				--with-libcurl \
				--with-libpcre \
				--with-iconv
#				--with-jabber \
#				--with-postgresql \				
#				--with-sqlite3
#				--with-openssl
	sleep ${SLEEP_TIME}
	make -j$CPU_NUM
	make install
	ldconfig -v
}

function install_zabbix_agentd_software () {
	cd ${ZABBIX_SOFTWARE_DOWNLOAD_DIR}
	tar zxvf zabbix-${Zabbix_Server_Version}.tar.gz
	cd zabbix-${Zabbix_Server_Version}
	echo `pwd`
	sleep ${SLEEP_TIME}
	./configure --prefix=${ZABBIX_SOFTWARE_INSTALL_DIR} \
				--enable-agent \
				--enable-proxy \
				--enable-java \
				--enable-ipv6 \
				--with-mysql \
				--with-libxml2 \
				--with-unixodbc \
				--with-net-snmp \
				--with-ssh2 \
				--with-openipmi \
				--with-zlib \
				--with-libevent \
				--with-gnutls \
				--with-libcurl \
				--with-libpcre \
				--with-iconv
#				--enable-server \
#				--with-jabber \
#				--with-postgresql \				
#				--with-sqlite3
#				--with-openssl
	sleep ${SLEEP_TIME}
	make -j$CPU_NUM
	make install
	ldconfig -v
}

function create_zabbix_server_and_agentd_dir () {
	mkdir -p ${ZABBIX_RUN_DIR}
	chown ${ZABBIX_USER}.${ZABBIX_GROUP} -R ${ZABBIX_RUN_DIR}
	mkdir -p ${ZABBIX_LOGFILE_DIR}
	chown ${ZABBIX_USER}.${ZABBIX_GROUP} -R ${ZABBIX_LOGFILE_DIR}
	mkdir -p ${ZABBIX_SOFTWARE_INSTALL_DIR}/tmp
	chown ${ZABBIX_USER}.${ZABBIX_GROUP} -R ${ZABBIX_SOFTWARE_INSTALL_DIR}/tmp
	mkdir -p ${ZABBIX_Server_TmpDir}
	chown ${ZABBIX_USER}.${ZABBIX_GROUP} -R ${ZABBIX_Server_TmpDir}
	mkdir -p ${ZABBIX_Server_ExportDir}
	chown ${ZABBIX_USER}.${ZABBIX_GROUP} -R ${ZABBIX_Server_ExportDir}
	mkdir -p ${ZABBIX_AGENTD_SCRIPT_DIR}
	chown ${ZABBIX_USER}.${ZABBIX_GROUP} -R ${ZABBIX_AGENTD_SCRIPT_DIR}
	\cp -prv ${ZABBIX_SOFTWARE_DOWNLOAD_DIR}/script/* ${ZABBIX_AGENTD_SCRIPT_DIR}/
}
function copy_zabbix_agent_script () {
	\cp -prv ${ZABBIX_SOFTWARE_DOWNLOAD_DIR}/script/* ${ZABBIX_AGENTD_SCRIPT_DIR}/
	chown ${ZABBIX_USER}.${ZABBIX_GROUP} -R ${ZABBIX_AGENTD_SCRIPT_DIR}
	chmod 4775 ${ZABBIX_AGENTD_SCRIPT_DIR}/* -R
#tcp状态
	cat > ${ZABBIX_SOFTWARE_INSTALL_DIR}/etc/zabbix_agentd.conf.d/tcp_status.conf <<EOF
UserParameter=tcp.status[*],${ZABBIX_AGENTD_SCRIPT_DIR}/tcp_status.sh \$1
EOF
#10大进程消耗内存和cpu监控脚本
	cat > ${ZABBIX_SOFTWARE_INSTALL_DIR}/etc/zabbix_agentd.conf.d/top_10_process_use_memory.conf <<EOF
#top_process
UserParameter=process.discovery[*],${ZABBIX_AGENTD_SCRIPT_DIR}/top_10_process_use_memory.py \$1
UserParameter=process.resource[*],${ZABBIX_AGENTD_SCRIPT_DIR}/top_10_process_use_memory.py \$1 \$2
EOF
#10大进程消耗内存和cpu监控脚本
	echo "*/1 * * * * root /usr/bin/top -b -n 1 >/tmp/zabbix_top_10_process_use_memory.txt" >> /etc/crontab

#磁盘io性能监控
	cat > ${ZABBIX_SOFTWARE_INSTALL_DIR}/etc/zabbix_agentd.conf.d/disk_io_stats.conf <<EOF
UserParameter=disk.discovery[*],${ZABBIX_AGENTD_SCRIPT_DIR}/Disk_Scan_Discovery.sh
UserParameter=disk.io[*],${ZABBIX_AGENTD_SCRIPT_DIR}/Disk_IO_Stat.sh \$1 \$2
EOF


#开机时间天数监控
	cat > ${ZABBIX_SOFTWARE_INSTALL_DIR}/etc/zabbix_agentd.conf.d/boot_date_time.conf <<EOF
UserParameter=checkuptime,cat /proc/uptime| awk -F. '{run_days=\$1 / 86400;print(run_days)}'
EOF
#开机时间天数监控
	cat > ${ZABBIX_SOFTWARE_INSTALL_DIR}/etc/zabbix_agentd.conf.d/redis.conf <<EOF
UserParameter=redis_discovery[*],/bin/bash /usr/local/zabbix/script/redis_low_discovery.sh \$1
UserParameter=redis_items[*],/bin/bash /usr/local/zabbix/script/redis_get_values.sh -p \$1 -k \$2
UserParameter=sentinel_items[*],/bin/bash /usr/local/zabbix/script/redis_get_values.sh -p \$1 -k \$2
EOF

}
function config_etc_sudoers_file () {
sed -i "s/#includedir/includedir/g" /etc/sudoers
cat > /etc/sudoers.d/redis <<EOF
zabbix ALL=(root) NOPASSWD:/bin/netstat
EOF
chown root.root /etc/sudoers.d/redis
chmod 644 /etc/sudoers.d/redis
}


function config_zabbix_server_and_agentd_profile_file (){
	cat > /etc/profile.d/zabbix.sh <<EOF
#!/bin/bash
#set -x
export ZABBIX_HOME=/usr/local/zabbix
export PATH=\${ZABBIX_HOME}/bin:\${ZABBIX_HOME}/sbin:\${PATH}
export ZABBIX_HOME PATH
EOF
	source /etc/profile
}
function install_zabbix_server_initd_file(){
#copy service file to /etc/init.d/
	\cp -prv ${ZABBIX_SOFTWARE_DOWNLOAD_DIR}/zabbix-${Zabbix_Server_Version}/misc/init.d/fedora/core/zabbix_server /etc/init.d/
	sed -i "s@BASEDIR=/usr/local@BASEDIR=${ZABBIX_SOFTWARE_INSTALL_DIR}@" /etc/init.d/zabbix_server
	sed -i "s@PIDFILE=/tmp@PIDFILE=${ZABBIX_RUN_DIR}@" /etc/init.d/zabbix_server
}

function config_zabbix_server (){

#添加脚本执行权限
	chmod +x /etc/rc.d/init.d/zabbix_server
#添加开机启动
	chkconfig zabbix_server on


#备份zabbix_server.conf文件
	\cp ${ZABBIX_SOFTWARE_INSTALL_DIR}/etc/zabbix_server.conf{,_`date +%Y-%m-%d_%H-%M-%S_%N`}

#指定ZABBIX服务端的监听端口，用于监听Proxy或Agent的连接请求。
	sed -i "s/# ListenPort=10051/ListenPort=${ZABBIX_Server_ListenPort}/" ${ZABBIX_SOFTWARE_INSTALL_DIR}/etc/zabbix_server.conf

#指定ZABBIX服务端的IP地址。
	sed -i "s/# SourceIP=/SourceIP=${ZABBIX_SERVER_IP}/" ${ZABBIX_SOFTWARE_INSTALL_DIR}/etc/zabbix_server.conf

#日志达到多少M里就轮转；若此参数值为0时，则不轮转，日志将不断变大，建议设置成轮转	
	sed -i "s/# LogFileSize=1/LogFileSize=${ZABBIX_Server_LogFileSize}/" ${ZABBIX_SOFTWARE_INSTALL_DIR}/etc/zabbix_server.conf

#zabbix日志级别
#   0 - basic information about starting and stopping of Zabbix processes
#   1 - critical information  灾难日志，日志量较少
#   2 - error information  错误级别，日志量大于CRITICAL级别
#   3 - warnings    告警级别，日志量大于ERROR级别
#   4 - for debugging (produces lots of information)调试级别，日志量大于WARNING
#   5 - extended debugging (produces even more information)
#说明：日志级别0~4，单位时间内生成日志的量不断增大
	sed -i "s/# DebugLevel=3/DebugLevel=${ZABBIX_Server_DebugLevel}/" ${ZABBIX_SOFTWARE_INSTALL_DIR}/etc/zabbix_server.conf
	
#连接数据库的地址
	sed -i "s/# DBHost=localhost/DBHost=${ZABBIX_DB_SERVER_IP}/g" ${ZABBIX_SOFTWARE_INSTALL_DIR}/etc/zabbix_server.conf

#连接的数据库
	sed -i "s/DBName=zabbix/DBName=${ZABBIX_SQL_DB_NAME}/g" ${ZABBIX_SOFTWARE_INSTALL_DIR}/etc/zabbix_server.conf

#连接数据库的用户
	sed -i "s/DBUser=zabbix/DBUser=${ZABBIX_SQL_DB_USER}/g" ${ZABBIX_SOFTWARE_INSTALL_DIR}/etc/zabbix_server.conf

#连接数据库的密码
	sed -i "s/# DBPassword=/DBPassword=${ZABBIX_SQL_DB_PASSWORD}/g" ${ZABBIX_SOFTWARE_INSTALL_DIR}/etc/zabbix_server.conf

#Zabbix数据库端口
	sed -i "s@# DBPort=@DBPort=${ZABBIX_DB_SERVER_PORT}@" ${ZABBIX_SOFTWARE_INSTALL_DIR}/etc/zabbix_server.conf
	
#zabbix server的export文件夹
	sed -i "s@# ExportDir=@ExportDir=${ZABBIX_Server_ExportDir}@" ${ZABBIX_SOFTWARE_INSTALL_DIR}/etc/zabbix_server.conf	
	
#zabbix server的expoert文件大小
	sed -i "s@# ExportFileSize=1G=@ExportFileSize=${ZABBIX_Server_ExportFileSize}@" ${ZABBIX_SOFTWARE_INSTALL_DIR}/etc/zabbix_server.conf		
	
	
	
#Zabbix进程数，初始化时，启动子进程数量，数量越多，则服务端吞吐能力越强，对系统资源消耗越大
	sed -i "s/# StartPollers=5/StartPollers=${ZABBIX_Server_StartPollers}/g" ${ZABBIX_SOFTWARE_INSTALL_DIR}/etc/zabbix_server.conf

#检查unreachable host（包括IPMI）的进程数
#默认情况下，ZABBIX会启用指定进程用于探测某些不可达主机的（含IPMI场景）；
#若使用场景中含有代理端，建议保持默认；若直接agent较多，可视具体情况调整
	sed -i "s/# StartPollersUnreachable=1/StartPollersUnreachable=${ZABBIX_Server_StartPollersUnreachable}/g" ${ZABBIX_SOFTWARE_INSTALL_DIR}/etc/zabbix_server.conf

#Trappers（zabbix采集器）进程数，Trappers用于接收其它host用zabbix_sender、active_agents发送的数据，
#至少需要一个Trapper进程用来在前端显示Zabbix Server可用性
#用于设置诸如SNMP STRAPPER场景提交来的数据的接收进程数，若客户机SNMP TRAPPER技术较多，建议加大此参数值	
	sed -i "s/# StartTrappers=5/StartTrappers=${ZABBIX_Server_StartTrappers}/g" ${ZABBIX_SOFTWARE_INSTALL_DIR}/etc/zabbix_server.conf

#用于设置启用icmp协议PING主机方式启动线程数量，若单台代理所管理机器超过500台，建议加大此数值
	sed -i "s/# StartPingers=1/StartPingers=${ZABBIX_Server_StartPingers}/g" ${ZABBIX_SOFTWARE_INSTALL_DIR}/etc/zabbix_server.conf

#用于自动发现(Discovery)的discovery的进程数
#用于设置自动发现主机的线程数量，若单台代理所管理机器超过500台，可以考虑加大此数值（仅适用于直接AGENT场景）
	sed -i "s/# StartDiscoverers=1/StartDiscoverers=${ZABBIX_Server_StartDiscoverers}/g" ${ZABBIX_SOFTWARE_INSTALL_DIR}/etc/zabbix_server.conf

#用于HTTP检查的进程数
#用于设置WEB拨测监控线程数，可视具体情况增加或减少此数值。
	sed -i "s/# StartHTTPPollers=1/StartHTTPPollers=${ZABBIX_Server_StartHTTPPollers}/g" ${ZABBIX_SOFTWARE_INSTALL_DIR}/etc/zabbix_server.conf

#Zabbix各实例计时器数量，主要用于触发器，标有维护标识的主机，但只第一个计时器用于计算维护标识主机。
	sed -i "s/# StartTimers=1/StartTimers=${ZABBIX_Server_StartTimers}/g" ${ZABBIX_SOFTWARE_INSTALL_DIR}/etc/zabbix_server.conf
#用于处理动作中的步骤的进程，zabbix动作较多时建议调大。
	sed -i "s/# StartAlerters=3/StartAlerters=${ZABBIX_Server_StartAlerters}/g" ${ZABBIX_SOFTWARE_INSTALL_DIR}/etc/zabbix_server.conf

#用于设置监控VMWARE Esxi主机实例时使用，若为0则不启用，若要监控ESXI主机，此值最少为1 ；视监控ESXI数量设置对应数值
	sed -i "s/# StartVMwareCollectors=0/StartVMwareCollectors=${ZABBIX_Server_StartVMwareCollectors}/g" ${ZABBIX_SOFTWARE_INSTALL_DIR}/etc/zabbix_server.conf
#设置代理端访问 VMWARE service的频率，单位:秒
	sed -i "s/# VMwareFrequency=60/VMwareFrequency=${ZABBIX_Server_VMwareFrequency}/g" ${ZABBIX_SOFTWARE_INSTALL_DIR}/etc/zabbix_server.conf

#从单个VMware服务检索性能计数器统计信息之间的延迟(秒)。
	sed -i "s/# VMwarePerfFrequency=60/VMwarePerfFrequency=${ZABBIX_Server_VMwarePerfFrequency}/g" ${ZABBIX_SOFTWARE_INSTALL_DIR}/etc/zabbix_server.conf

#划出多少共享内存用于存储VMWARE数据
	sed -i "s/# VMwareCacheSize=8M/VMwareCacheSize=${ZABBIX_Server_VMwareCacheSize}/g" ${ZABBIX_SOFTWARE_INSTALL_DIR}/etc/zabbix_server.conf

#说明：等待VMWare返回数据的最长时间
	sed -i "s/# VMwareTimeout=10/VMwareTimeout=${ZABBIX_Server_VMwareTimeout}/g" ${ZABBIX_SOFTWARE_INSTALL_DIR}/etc/zabbix_server.conf

#说明：指定SNMP TRAPPER 时的临时文件，用于代理端启用SNMP TRAPPER功能时使用
	sed -i "s@# SNMPTrapperFile=/tmp/zabbix_traps.tmp@SNMPTrapperFile=${ZABBIX_Server_SNMPTrapperFile}@" ${ZABBIX_SOFTWARE_INSTALL_DIR}/etc/zabbix_server.conf

#说明：是否启用 snmptrapper功能 ，默认不启用=0，启用=1（配合参数SNMPTrapperFile使用）
	sed -i "s@# StartSNMPTrapper=0@StartSNMPTrapper=${ZABBIX_Server_StartSNMPTrapper}@" ${ZABBIX_SOFTWARE_INSTALL_DIR}/etc/zabbix_server.conf

#说明：多少小时清理一次代理端数据库的 history, alert, and alarms，以保持代理端数据库轻便，建议保持默认
	sed -i "s/# HousekeepingFrequency=1/HousekeepingFrequency=${ZABBIX_Server_HousekeepingFrequency}/g" ${ZABBIX_SOFTWARE_INSTALL_DIR}/etc/zabbix_server.conf

#每个HouseKeeper任务删除的最大记录数，1.8.2开始支持
	sed -i "s/# MaxHousekeeperDelete=5000/MaxHousekeeperDelete=${ZABBIX_Server_MaxHousekeeperDelete}/g" ${ZABBIX_SOFTWARE_INSTALL_DIR}/etc/zabbix_server.conf

#存储Host、Item和Trgger数据的内存空间	
	sed -i "s/# CacheSize=8M/CacheSize=${ZABBIX_Server_CacheSize}/g" ${ZABBIX_SOFTWARE_INSTALL_DIR}/etc/zabbix_server.conf

#说明：zabbix更新操作系统CACHE频率，若管理页面操作不频繁，可以考虑加大参数值
	sed -i "s/# CacheUpdateFrequency=60/CacheUpdateFrequency=${ZABBIX_Server_CacheUpdateFrequency}/g" ${ZABBIX_SOFTWARE_INSTALL_DIR}/etc/zabbix_server.conf

#说明:将采集数据从CACHE同步到数据库线程数量，视数据库服务器I/O繁忙情况，和数据库写能力调整。数值越大，写能力越强。对数据库服务器I/O压力越大。
	sed -i "s/# StartDBSyncers=4/StartDBSyncers=${ZABBIX_Server_StartDBSyncers}/g" ${ZABBIX_SOFTWARE_INSTALL_DIR}/etc/zabbix_server.conf

#存储History数据的内存大小	
	sed -i "s/# HistoryCacheSize=16M/HistoryCacheSize=${ZABBIX_Server_HistoryCacheSize}/g" ${ZABBIX_SOFTWARE_INSTALL_DIR}/etc/zabbix_server.conf

#存储历史索引缓存共享内存的大小	
	sed -i "s/# HistoryIndexCacheSize=4M/HistoryIndexCacheSize=${ZABBIX_Server_HistoryIndexCacheSize}/g" ${ZABBIX_SOFTWARE_INSTALL_DIR}/etc/zabbix_server.conf

#说明：用于设置划分多少系统共享内存用于存储计算出来的趋势数据，此参数值从一定程度上可影响数据库读压力
	sed -i "s/# TrendCacheSize=4M/TrendCacheSize=${ZABBIX_Server_TrendCacheSize}/g" ${ZABBIX_SOFTWARE_INSTALL_DIR}/etc/zabbix_server.conf

#说明：划出系统多少共享内存用于已请求的存储监控项信息，若监控项较多，建议加大此数值
	sed -i "s/# ValueCacheSize=8M/ValueCacheSize=${ZABBIX_Server_ValueCacheSize}/g" ${ZABBIX_SOFTWARE_INSTALL_DIR}/etc/zabbix_server.conf

#超时时间
#与AGNET\SNMP设备和其它外部设备通信超时设置，单位为秒；
#若采集数据不完整或网络繁忙，或从管理页面发现客户端状态变化频繁，可以考虑加大此数值。
#注意若此数值加大，应该考虑参数 StartPollers 是否有相应加大的必要。	
	sed -i "s/Timeout=4/Timeout=${ZABBIX_Server_Timeout}/g" ${ZABBIX_SOFTWARE_INSTALL_DIR}/etc/zabbix_server.conf

#说明：启用 trapper功能，用于进程等待超时设置。根据需要调整
	sed -i "s/# TrapperTimeout=300/TrapperTimeout=${ZABBIX_Server_TrapperTimeout}/g" ${ZABBIX_SOFTWARE_INSTALL_DIR}/etc/zabbix_server.conf
#说明：当AGNET端处于不可用状态下，间隔多少秒后，尝试重新连接。建议根据具体情况设置。注意，若此数值过小，右agent端业务系统繁忙时，有可能造成报警信息误报
	sed -i "s/# UnreachablePeriod=45/UnreachablePeriod=${ZABBIX_Server_UnreachablePeriod}/g" ${ZABBIX_SOFTWARE_INSTALL_DIR}/etc/zabbix_server.conf
	
#说明:当AGENT端处于可用状态下，间隔多少秒后，进行状态检查。若出现可正常采集数据，但管理页面AGENT状态不正常；若在网络，端口等均通畅情况下，AGENT状态仍不正常，可以考虑加大此数值
	sed -i "s/# UnavailableDelay=60/UnavailableDelay=${ZABBIX_Server_UnavailableDelay}/g" ${ZABBIX_SOFTWARE_INSTALL_DIR}/etc/zabbix_server.conf
	
#说明：当agent端处于不可达状态下，延迟多少秒后，进行重新尝试，建议保持默认，在AGENT接入调试阶段，可考虑减少此数值
	sed -i "s/# UnreachableDelay=15/UnreachableDelay=${ZABBIX_Server_UnreachableDelay}/g" ${ZABBIX_SOFTWARE_INSTALL_DIR}/etc/zabbix_server.conf
	
#脚本目录，例如：短信告警脚本SMS，邮件告警脚本mail,微信告警脚步Wechat

#sed -i "s///g" ${ZABBIX_SOFTWARE_INSTALL_DIR}/etc/zabbix_server.conf




#Fping路径
	sed -i "s@# FpingLocation=\/usr\/sbin\/fping@FpingLocation=${ZABBIX_Server_FpingLocation}@g" ${ZABBIX_SOFTWARE_INSTALL_DIR}/etc/zabbix_server.conf

#多慢的数据库查询将会被记录，单位：毫秒，
#0表示不记录慢查询。只有在DebugLevel=3时，这个配置才有效
#用于服务端数据库慢查询功能，单位是毫秒；1毫秒=0.001秒，若有服务端数据库监控慢查询的需求，可以视具体情况调整此数。
	sed -i "s/LogSlowQueries=3000/LogSlowQueries=${ZABBIX_Server_LogSlowQueries}/g" ${ZABBIX_SOFTWARE_INSTALL_DIR}/etc/zabbix_server.conf
	
#说明：zabbix服务端工作的临时目录
	sed -i "s@# TmpDir=/tmp@TmpDir=${ZABBIX_Server_TmpDir}@g" ${ZABBIX_SOFTWARE_INSTALL_DIR}/etc/zabbix_server.conf

#说明:启用多少子进程与代理端通信，若代理端较多可考虑加大此数值
	sed -i "s/# StartProxyPollers=1/StartProxyPollers=${ZABBIX_Server_StartProxyPollers}/g" ${ZABBIX_SOFTWARE_INSTALL_DIR}/etc/zabbix_server.conf

#说明：zabbix服务端将配置文件数据同步到代理端的频率，仅适用于代理端为被动模式情况下
	sed -i "s/# ProxyConfigFrequency=3600/ProxyConfigFrequency=${ZABBIX_Server_ProxyConfigFrequency}/g" ${ZABBIX_SOFTWARE_INSTALL_DIR}/etc/zabbix_server.conf

#说明：zabbix服务端请求代理端采集的数据的频率，仅适用代理端为被动模式情况下
	sed -i "s/# ProxyDataFrequency=1/ProxyDataFrequency=${ZABBIX_Server_ProxyDataFrequency}/g" ${ZABBIX_SOFTWARE_INSTALL_DIR}/etc/zabbix_server.conf
	
#值为1就允许root启动，为0则不允许
	sed -i "s/# AllowRoot=0/AllowRoot=${ZABBIX_Server_AllowRoot}/g" ${ZABBIX_SOFTWARE_INSTALL_DIR}/etc/zabbix_server.conf

#zabbix进程启动用户
	sed -i "s/# User=zabbix/User=${ZABBIX_Server_User}/g" ${ZABBIX_SOFTWARE_INSTALL_DIR}/etc/zabbix_server.conf

#ZABBIX_Server_Include链接文件
	sed -i "s@# Include=\/usr\/local\/etc\/zabbix_server.conf.d\/\*.conf@Include=${ZABBIX_Server_Include}@g" ${ZABBIX_SOFTWARE_INSTALL_DIR}/etc/zabbix_server.conf

#zabbix pid 目录
	sed -i "s@# PidFile=/tmp@PidFile=${ZABBIX_RUN_DIR}@" ${ZABBIX_SOFTWARE_INSTALL_DIR}/etc/zabbix_server.conf

#zabbix 日志目录
	sed -i "s@LogFile=/tmp@LogFile=${ZABBIX_LOGFILE_DIR}@" ${ZABBIX_SOFTWARE_INSTALL_DIR}/etc/zabbix_server.conf

#日志文件类型
	sed -i "s@# LogType=file@LogType=${ZABBIX_SERVER_LOGTYPE}@" ${ZABBIX_SOFTWARE_INSTALL_DIR}/etc/zabbix_server.conf

#zabbix socket 目录
	sed -i "s@# SocketDir=/tmp@SocketDir=${ZABBIX_SERVER_SocketDir}@" ${ZABBIX_SOFTWARE_INSTALL_DIR}/etc/zabbix_server.conf
	


}


function install_zabbix_agentd_initd_file(){
#copy service file to /etc/init.d/
	\cp -prv ${ZABBIX_SOFTWARE_DOWNLOAD_DIR}/zabbix-${Zabbix_Server_Version}/misc/init.d/fedora/core/zabbix_agentd /etc/init.d/
	sed -i "s@BASEDIR=/usr/local@BASEDIR=${ZABBIX_SOFTWARE_INSTALL_DIR}@" /etc/init.d/zabbix_agentd
	sed -i "s@PIDFILE=/tmp@PIDFILE=${ZABBIX_RUN_DIR}@" /etc/init.d/zabbix_agentd
}




function config_zabbix_agentd (){
#添加脚本执行权限
	chmod +x /etc/rc.d/init.d/zabbix_agentd
#添加开机启动
	chkconfig zabbix_agentd on

#zabbix_agentd.conf文件
	\cp ${ZABBIX_SOFTWARE_INSTALL_DIR}/etc/zabbix_agentd.conf{,_`date +%Y-%m-%d_%H-%M-%S_%N`}

#Zabbix agentd pid 目录
	sed -i "s@# PidFile=/tmp@PidFile=${ZABBIX_AGENTD_RUN_DIR}@" ${ZABBIX_SOFTWARE_INSTALL_DIR}/etc/zabbix_agentd.conf

#Zabbix agentd 日志目录
	sed -i "s@LogFile=/tmp@LogFile=${ZABBIX_AGENTD_LOGFILE_DIR}@" ${ZABBIX_SOFTWARE_INSTALL_DIR}/etc/zabbix_agentd.conf

#Zabbix agentd日志文件类型
	sed -i "s@# LogType=file@LogType=${ZABBIX_AGENTD_LOGTYPE}@" ${ZABBIX_SOFTWARE_INSTALL_DIR}/etc/zabbix_agentd.conf

#Zabbix agentd日志达到多少M里就轮转；若此参数值为0时，则不轮转，日志将不断变大，建议设置成轮转	
	sed -i "s/# LogFileSize=1/LogFileSize=${ZABBIX_AGENTD_LogFileSize}/" ${ZABBIX_SOFTWARE_INSTALL_DIR}/etc/zabbix_agentd.conf

#Zabbix agentd日志级别
#   0 - basic information about starting and stopping of Zabbix processes
#   1 - critical information  灾难日志，日志量较少
#   2 - error information  错误级别，日志量大于CRITICAL级别
#   3 - warnings    告警级别，日志量大于ERROR级别
#   4 - for debugging (produces lots of information)调试级别，日志量大于WARNING
#   5 - extended debugging (produces even more information)
#说明：日志级别0~4，单位时间内生成日志的量不断增大
	sed -i "s/# DebugLevel=3/DebugLevel=${ZABBIX_AGENTD_DebugLevel}/" ${ZABBIX_SOFTWARE_INSTALL_DIR}/etc/zabbix_agentd.conf

#是否允许zabbix server端的远程指令， 0表示不允许， 1表示允许
	sed -i "s/# EnableRemoteCommands=0/EnableRemoteCommands=${ZABBIX_AGENTD_EnableRemoteCommands}/" ${ZABBIX_SOFTWARE_INSTALL_DIR}/etc/zabbix_agentd.conf

#是否开启日志记录shell命令作为警告 0表示不允许，1表示允许
	sed -i "s/# LogRemoteCommands=0/LogRemoteCommands=${ZABBIX_AGENTD_LogRemoteCommands}/" ${ZABBIX_SOFTWARE_INSTALL_DIR}/etc/zabbix_agentd.conf

#zabbix server的ip地址或主机名，可同时列出多个，需要用逗号隔开
	sed -i "s/Server=127.0.0.1/Server=${ZABBIX_SERVER_IP}/g" ${ZABBIX_SOFTWARE_INSTALL_DIR}/etc/zabbix_agentd.conf

#zabbix agent监听的端口  
	sed -i "s/# ListenPort=10050/ListenPort=${ZABBIX_AGENTD_ListenPort}/g" ${ZABBIX_SOFTWARE_INSTALL_DIR}/etc/zabbix_agentd.conf

#zabbix agent监听的ip地址
	sed -i "s/# ListenIP=0.0.0.0/ListenIP=${ZABBIX_AGENTD_ListenIP}/g" ${ZABBIX_SOFTWARE_INSTALL_DIR}/etc/zabbix_agentd.conf

#zabbix agent开启进程数  
	sed -i "s/# StartAgents=3/StartAgents=${ZABBIX_AGENTD_StartAgents}/g" ${ZABBIX_SOFTWARE_INSTALL_DIR}/etc/zabbix_agentd.conf

#zabbix agent开启主动检查 
	sed -i "s/ServerActive=127.0.0.1/ServerActive=${ZABBIX_AGENTD_ServerActive}/g" ${ZABBIX_SOFTWARE_INSTALL_DIR}/etc/zabbix_agentd.conf

#在zabbix server前端配置时指定的主机名要相同，最重要的配置 
	sed -i "s/Hostname=Zabbix server/Hostname=${ZABBIX_AGENTD_Hostname}/g" ${ZABBIX_SOFTWARE_INSTALL_DIR}/etc/zabbix_agentd.conf
#	sed -i "s/# HostMetadataItem=/HostMetadataItem=system.uname/g" ${ZABBIX_SOFTWARE_INSTALL_DIR}/etc/zabbix_agentd.conf

#主动检查刷新的时间，单位为秒数  
	sed -i "s/# RefreshActiveChecks=120/RefreshActiveChecks=${ZABBIX_AGENTD_RefreshActiveChecks}/g" ${ZABBIX_SOFTWARE_INSTALL_DIR}/etc/zabbix_agentd.conf

#数据缓冲的时间  
	sed -i "s/# BufferSend=5/BufferSend=${ZABBIX_AGENTD_BufferSend}/g" ${ZABBIX_SOFTWARE_INSTALL_DIR}/etc/zabbix_agentd.conf

#zabbix agent数据缓冲区的大小，当达到该值便会发送所有的数据到zabbix server  
	sed -i "s/# BufferSize=100/BufferSize=${ZABBIX_AGENTD_BufferSize}/g" ${ZABBIX_SOFTWARE_INSTALL_DIR}/etc/zabbix_agentd.conf

#zabbix agent发送给zabbix server最大的数据行
	sed -i "s/# MaxLinesPerSecond=20/MaxLinesPerSecond=${ZABBIX_AGENTD_MaxLinesPerSecond}/g" ${ZABBIX_SOFTWARE_INSTALL_DIR}/etc/zabbix_agentd.conf

#是否允许zabbix agentd 以root用户运行  
	sed -i "s/# AllowRoot=0/AllowRoot=${ZABBIX_AGENTD_AllowRoot}/g" ${ZABBIX_SOFTWARE_INSTALL_DIR}/etc/zabbix_agentd.conf

#设定处理超时的时间  
	sed -i "s/# Timeout=3/Timeout=${ZABBIX_AGENTD_Timeout}/g" ${ZABBIX_SOFTWARE_INSTALL_DIR}/etc/zabbix_agentd.conf

#ZABBIX_Agent_Include链接文件.包含子配置文件的路径
	sed -i "s@# Include=\/usr\/local\/etc\/zabbix_agentd.conf.d\/\*.conf@Include=${ZABBIX_AGENTD_Include}@g" ${ZABBIX_SOFTWARE_INSTALL_DIR}/etc/zabbix_agentd.conf

#是否允许所有字符参数的传递  
	sed -i "s/# UnsafeUserParameters=0/UnsafeUserParameters=${ZABBIX_AGENTD_UnsafeUserParameters}/g" ${ZABBIX_SOFTWARE_INSTALL_DIR}/etc/zabbix_agentd.conf

#指定用户自定义参数  
	sed -i "s/# UserParameter=/# UserParameter=${ZABBIX_AGENTD_UserParameter}/g" ${ZABBIX_SOFTWARE_INSTALL_DIR}/etc/zabbix_agentd.conf
}

function config_zabbix_proxy(){
#备份zabbix_proxy.conf文件
	\cp ${ZABBIX_SOFTWARE_INSTALL_DIR}/etc/zabbix_proxy.conf{,_`date +%Y-%m-%d_%H-%M-%S_%N`}

#设置zabbix proxy模式，0为主动模式，1为被动模式
	sed -i "s/# ProxyMode=0/ProxyMode=${ZABBIX_PROXY_ProxyMode}/g" ${ZABBIX_SOFTWARE_INSTALL_DIR}/etc/zabbix_proxy.conf

#指定zabbix server的ip地址或主机名  

	sed -i "s/Server=127.0.0.1/Server=${ZABBIX_PROXY_Server}/g" ${ZABBIX_SOFTWARE_INSTALL_DIR}/etc/zabbix_proxy.conf

#zabbix server监听端口
	sed -i "s/# ServerPort=10051/ServerPort=${ZABBIX_PROXY_ServerPort}/g" ${ZABBIX_SOFTWARE_INSTALL_DIR}/etc/zabbix_proxy.conf

#定义监控代理的主机名，需和zabbix server前端配置时指定的节点名相同  
	sed -i "s/Hostname=Zabbix proxy/Hostname=${ZABBIX_PROXY_Hostname}/g" ${ZABBIX_SOFTWARE_INSTALL_DIR}/etc/zabbix_proxy.conf

#proxy 监听端口
	sed -i "s/# ListenPort=10051/ListenPort=${ZABBIX_PROXY_ListenPort}/g" ${ZABBIX_SOFTWARE_INSTALL_DIR}/etc/zabbix_proxy.conf

#指定ZABBIX服务端的IP地址
	sed -i "s/# SourceIP=/SourceIP=${ZABBIX_PROXY_SourceIP}/g" ${ZABBIX_SOFTWARE_INSTALL_DIR}/etc/zabbix_proxy.conf

#日志文件类型
	sed -i "s@# LogType=file@LogType=${ZABBIX_PROXY_LOGTYPE}@" ${ZABBIX_SOFTWARE_INSTALL_DIR}/etc/zabbix_proxy.conf

#指定日志文件的位置  
	sed -i "s@LogFile=/tmp@LogFile=${ZABBIX_PROXY_LogFile}@" ${ZABBIX_SOFTWARE_INSTALL_DIR}/etc/zabbix_proxy.conf

#日志达到多少M里就轮转；若此参数值为0时，则不轮转，日志将不断变大，建议设置成轮转
	sed -i "s/# LogFileSize=1/LogFileSize=${ZABBIX_Server_LogFileSize}/" ${ZABBIX_SOFTWARE_INSTALL_DIR}/etc/zabbix_proxy.conf

#zabbix日志级别
#   0 - basic information about starting and stopping of Zabbix processes 无日志
#   1 - critical information  灾难日志，日志量较少
#   2 - error information  错误级别，日志量大于CRITICAL级别
#   3 - warnings    告警级别，日志量大于ERROR级别
#   4 - for debugging (produces lots of information)调试级别，日志量大于WARNING
#   5 - extended debugging (produces even more information)
#说明：日志级别0~4，单位时间内生成日志的量不断增大
	sed -i "s/# DebugLevel=3/DebugLevel=${ZABBIX_Server_DebugLevel}/" ${ZABBIX_SOFTWARE_INSTALL_DIR}/etc/zabbix_proxy.conf

#是否允许zabbix server端的远程指令， 0表示不允许， 1表示允许
	sed -i "s/# EnableRemoteCommands=0/EnableRemoteCommands=${ZABBIX_AGENTD_EnableRemoteCommands}/" ${ZABBIX_SOFTWARE_INSTALL_DIR}/etc/zabbix_proxy.conf

#是否开启日志记录shell命令作为警告 0表示不允许，1表示允许
	sed -i "s/# LogRemoteCommands=0/LogRemoteCommands=${ZABBIX_AGENTD_LogRemoteCommands}/" ${ZABBIX_SOFTWARE_INSTALL_DIR}/etc/zabbix_proxy.conf

#pid文件的位置  
	sed -i "s@# PidFile=/tmp@PidFile=${ZABBIX_PROXY_RUN_DIR}@" ${ZABBIX_SOFTWARE_INSTALL_DIR}/etc/zabbix_proxy.conf

#ZABBIX_PROXY连接数据库的地址
	sed -i "s/# DBHost=localhost/DBHost=${ZABBIX_PROXY_DB_SERVER_IP}/g" ${ZABBIX_SOFTWARE_INSTALL_DIR}/etc/zabbix_proxy.conf

#ZABBIX_PROXY数据库名  
	sed -i "s/DBName=zabbix_proxy/DBName=${ZABBIX_PROXY_DBName}/g" ${ZABBIX_SOFTWARE_INSTALL_DIR}/etc/zabbix_proxy.conf

#ZABBIX_PROXY连接数据库的用户  
	sed -i "s/DBUser=zabbix/DBUser=${ZABBIX_PROXY_DBUser}/g" ${ZABBIX_SOFTWARE_INSTALL_DIR}/etc/zabbix_proxy.conf

#ZABBIX_PROXY连接数据库用户的密码  
	sed -i "s/# DBPassword=/DBPassword=${ZABBIX_PROXY_DBPassword}/g" ${ZABBIX_SOFTWARE_INSTALL_DIR}/etc/zabbix_proxy.conf

#ZABBIX_PROXY数据库端口
	sed -i "s@# DBPort=@DBPort=${ZABBIX_PROXY_DBPort}@" ${ZABBIX_SOFTWARE_INSTALL_DIR}/etc/zabbix_proxy.conf

#设置zabbix proxy暂存在本地mysql的监控数据的时间。默认是0，不暂存。
#即使zabbix proxy已经把数据发送给了zabbix server，还是会暂存数据在本地设置的时间。取值范围是0~720小时
	sed -i "s@# ProxyLocalBuffer=0@ProxyLocalBuffer=${ZABBIX_PROXY_ProxyLocalBuffer}@" ${ZABBIX_SOFTWARE_INSTALL_DIR}/etc/zabbix_proxy.conf

#设置当zabbix proxy与zabbix server无法连接时保留监控数据的时间间隔。默认是1小时，取值是1~720小时
#这个参数特别有用，我就是在之前的几次维护中，停掉zabbix server后没有设置zabbix proxy的这个参数，
#所以当维护结束后启动zabbix server，会发现有段时间内的数据没有。这是因zabbix proxy按照默认的保留时间执行housekeeper把过期的数据删除了。
#这个时间根据最好根据要维护的时间来设定，比如要维护10个小时，那么就要设置ProxyOfflineBuffer=10
#这样就不至于这10个小时之间的数据都丢失了。也有一个问题，如果时间间隔太大的话，zabbix proxy重新推送数据到zabbix server会导致双方的服务器压力都会增大
	sed -i "s@# ProxyOfflineBuffer=1@ProxyOfflineBuffer=${ZABBIX_PROXY_ProxyOfflineBuffer}@" ${ZABBIX_SOFTWARE_INSTALL_DIR}/etc/zabbix_proxy.conf

#每隔多少秒探测一下zabbix server服务器的活动状态
	sed -i "s@# HeartbeatFrequency=60@HeartbeatFrequency=${ZABBIX_PROXY_HeartbeatFrequency}@" ${ZABBIX_SOFTWARE_INSTALL_DIR}/etc/zabbix_proxy.conf

#zabbix proxy从zabbix server取得配置数据的频率
#每隔多少秒到服务器端拉取相关配置
	sed -i "s@# ConfigFrequency=3600@ConfigFrequency=${ZABBIX_PROXY_ConfigFrequency}@" ${ZABBIX_SOFTWARE_INSTALL_DIR}/etc/zabbix_proxy.conf

#zabbix proxy发送监控到的数据给zabbix server的频率
#每隔多少秒就发送一次数据到服务器端，发送数据后会自动删除的，所以本地保存数据量很少
	sed -i "s@# DataSenderFrequency=1@DataSenderFrequency=${ZABBIX_PROXY_DataSenderFrequency}@" ${ZABBIX_SOFTWARE_INSTALL_DIR}/etc/zabbix_proxy.conf

#Zabbix进程数，初始化时，启动子进程数量，数量越多，则服务端吞吐能力越强，对系统资源消耗越大
	sed -i "s/# StartPollers=5/StartPollers=${ZABBIX_PROXY_StartPollers}/g" ${ZABBIX_SOFTWARE_INSTALL_DIR}/etc/zabbix_proxy.conf

#检查unreachable host（包括IPMI）的进程数
#默认情况下，ZABBIX会启用指定进程用于探测某些不可达主机的（含IPMI场景）；
#若使用场景中含有代理端，建议保持默认；若直接agent较多，可视具体情况调整
	sed -i "s/# StartPollersUnreachable=1/StartPollersUnreachable=${ZABBIX_PROXY_StartPollersUnreachable}/g" ${ZABBIX_SOFTWARE_INSTALL_DIR}/etc/zabbix_proxy.conf

#Trappers（zabbix采集器）进程数，Trappers用于接收其它host用zabbix_sender、active_agents发送的数据，
#至少需要一个Trapper进程用来在前端显示Zabbix Server可用性
#用于设置诸如SNMP STRAPPER场景提交来的数据的接收进程数，若客户机SNMP TRAPPER技术较多，建议加大此参数值	
	sed -i "s/# StartTrappers=5/StartTrappers=${ZABBIX_PROXY_StartTrappers}/g" ${ZABBIX_SOFTWARE_INSTALL_DIR}/etc/zabbix_proxy.conf

#用于设置启用icmp协议PING主机方式启动线程数量，若单台代理所管理机器超过500台，建议加大此数值
	sed -i "s/# StartPingers=1/StartPingers=${ZABBIX_PROXY_StartPingers}/g" ${ZABBIX_SOFTWARE_INSTALL_DIR}/etc/zabbix_proxy.conf

#用于自动发现(Discovery)的discovery的进程数
#用于设置自动发现主机的线程数量，若单台代理所管理机器超过500台，可以考虑加大此数值（仅适用于直接AGENT场景）
	sed -i "s/# StartDiscoverers=1/StartDiscoverers=${ZABBIX_Server_StartDiscoverers}/g" ${ZABBIX_SOFTWARE_INSTALL_DIR}/etc/zabbix_proxy.conf

#用于HTTP检查的进程数
#用于设置WEB拨测监控线程数，可视具体情况增加或减少此数值。
	sed -i "s/# StartHTTPPollers=1/StartHTTPPollers=${ZABBIX_Server_StartHTTPPollers}/g" ${ZABBIX_SOFTWARE_INSTALL_DIR}/etc/zabbix_proxy.conf

#用于设置监控VMWARE Esxi主机实例时使用，若为0则不启用，若要监控ESXI主机，此值最少为1 ；视监控ESXI数量设置对应数值
	sed -i "s/# StartVMwareCollectors=0/StartVMwareCollectors=${ZABBIX_PROXY_StartVMwareCollectors}/g" ${ZABBIX_SOFTWARE_INSTALL_DIR}/etc/zabbix_proxy.conf
	
#设置代理端访问 VMWARE service的频率，单位:秒
	sed -i "s/# VMwareFrequency=60/VMwareFrequency=${ZABBIX_PROXY_VMwareFrequency}/g" ${ZABBIX_SOFTWARE_INSTALL_DIR}/etc/zabbix_proxy.conf

#从单个VMware服务检索性能计数器统计信息之间的延迟(秒)。
	sed -i "s/# VMwarePerfFrequency=60/VMwarePerfFrequency=${ZABBIX_PROXY_VMwarePerfFrequency}/g" ${ZABBIX_SOFTWARE_INSTALL_DIR}/etc/zabbix_proxy.conf

#划出多少共享内存用于存储VMWARE数据
	sed -i "s/# VMwareCacheSize=8M/VMwareCacheSize=${ZABBIX_PROXY_VMwareCacheSize}/g" ${ZABBIX_SOFTWARE_INSTALL_DIR}/etc/zabbix_proxy.conf

#说明：等待VMWare返回数据的最长时间
	sed -i "s/# VMwareTimeout=10/VMwareTimeout=${ZABBIX_PROXY_VMwareTimeout}/g" ${ZABBIX_SOFTWARE_INSTALL_DIR}/etc/zabbix_proxy.conf

#说明：指定SNMP TRAPPER 时的临时文件，用于代理端启用SNMP TRAPPER功能时使用
	sed -i "s@# SNMPTrapperFile=/tmp/zabbix_traps.tmp@SNMPTrapperFile=${ZABBIX_PROXY_SNMPTrapperFile}@" ${ZABBIX_SOFTWARE_INSTALL_DIR}/etc/zabbix_proxy.conf

#说明：是否启用 snmptrapper功能 ，默认不启用=0，启用=1（配合参数SNMPTrapperFile使用）
	sed -i "s@# StartSNMPTrapper=0@StartSNMPTrapper=${ZABBIX_PROXY_StartSNMPTrapper}@" ${ZABBIX_SOFTWARE_INSTALL_DIR}/etc/zabbix_proxy.conf

#zabbix proxy监听的ip地址
	sed -i "s/# ListenIP=0.0.0.0/ListenIP=${ZABBIX_PROXY_ListenIP}/g" ${ZABBIX_SOFTWARE_INSTALL_DIR}/etc/zabbix_proxy.conf

#说明：多少小时清理一次代理端数据库的 history, alert, and alarms，以保持代理端数据库轻便，建议保持默认
	sed -i "s/# HousekeepingFrequency=1/HousekeepingFrequency=${ZABBIX_PROXY_HousekeepingFrequency}/g" ${ZABBIX_SOFTWARE_INSTALL_DIR}/etc/zabbix_proxy.conf

#存储Host、Item和Trgger数据的内存空间	
	sed -i "s/# CacheSize=8M/CacheSize=${ZABBIX_PROXY_CacheSize}/g" ${ZABBIX_SOFTWARE_INSTALL_DIR}/etc/zabbix_proxy.conf

#说明:将采集数据从CACHE同步到数据库线程数量，视数据库服务器I/O繁忙情况，和数据库写能力调整。数值越大，写能力越强。对数据库服务器I/O压力越大。
	sed -i "s/# StartDBSyncers=4/StartDBSyncers=${ZABBIX_PROXY_StartDBSyncers}/g" ${ZABBIX_SOFTWARE_INSTALL_DIR}/etc/zabbix_proxy.conf

#存储History数据的内存大小	
	sed -i "s/# HistoryCacheSize=16M/HistoryCacheSize=${ZABBIX_PROXY_HistoryCacheSize}/g" ${ZABBIX_SOFTWARE_INSTALL_DIR}/etc/zabbix_proxy.conf

#存储历史索引缓存共享内存的大小	
	sed -i "s/# HistoryIndexCacheSize=4M/HistoryIndexCacheSize=${ZABBIX_PROXY_HistoryIndexCacheSize}/g" ${ZABBIX_SOFTWARE_INSTALL_DIR}/etc/zabbix_proxy.conf

#超时时间
#与AGNET\SNMP设备和其它外部设备通信超时设置，单位为秒；
#若采集数据不完整或网络繁忙，或从管理页面发现客户端状态变化频繁，可以考虑加大此数值。
#注意若此数值加大，应该考虑参数 StartPollers 是否有相应加大的必要。
	sed -i "s/Timeout=4/Timeout=${ZABBIX_PROXY_Timeout}/g" ${ZABBIX_SOFTWARE_INSTALL_DIR}/etc/zabbix_proxy.conf

#说明：启用 trapper功能，用于进程等待超时设置。根据需要调整
	sed -i "s/# TrapperTimeout=300/TrapperTimeout=${ZABBIX_PROXY_TrapperTimeout}/g" ${ZABBIX_SOFTWARE_INSTALL_DIR}/etc/zabbix_proxy.conf

#说明：当AGNET端处于不可用状态下，间隔多少秒后，尝试重新连接。建议根据具体情况设置。注意，若此数值过小，右agent端业务系统繁忙时，有可能造成报警信息误报
	sed -i "s/# UnreachablePeriod=45/UnreachablePeriod=${ZABBIX_PROXY_UnreachablePeriod}/g" ${ZABBIX_SOFTWARE_INSTALL_DIR}/etc/zabbix_proxy.conf
	
#说明:当AGENT端处于可用状态下，间隔多少秒后，进行状态检查。若出现可正常采集数据，但管理页面AGENT状态不正常；若在网络，端口等均通畅情况下，AGENT状态仍不正常，可以考虑加大此数值
	sed -i "s/# UnavailableDelay=60/UnavailableDelay=${ZABBIX_PROXY_UnavailableDelay}/g" ${ZABBIX_SOFTWARE_INSTALL_DIR}/etc/zabbix_proxy.conf
	
#说明：当agent端处于不可达状态下，延迟多少秒后，进行重新尝试，建议保持默认，在AGENT接入调试阶段，可考虑减少此数值
	sed -i "s/# UnreachableDelay=15/UnreachableDelay=${ZABBIX_PROXY_UnreachableDelay}/g" ${ZABBIX_SOFTWARE_INSTALL_DIR}/etc/zabbix_proxy.conf
	
#Fping路径
	sed -i "s@# FpingLocation=\/usr\/sbin\/fping@FpingLocation=${ZABBIX_PROXY_FpingLocation}@g" ${ZABBIX_SOFTWARE_INSTALL_DIR}/etc/zabbix_proxy.conf

#多慢的数据库查询将会被记录，单位：毫秒，
#0表示不记录慢查询。只有在DebugLevel=3时，这个配置才有效
#用于服务端数据库慢查询功能，单位是毫秒；1毫秒=0.001秒，若有服务端数据库监控慢查询的需求，可以视具体情况调整此数。
	sed -i "s/LogSlowQueries=3000/LogSlowQueries=${ZABBIX_PROXY_LogSlowQueries}/g" ${ZABBIX_SOFTWARE_INSTALL_DIR}/etc/zabbix_proxy.conf
	
#说明：zabbix服务端工作的临时目录
	sed -i "s@# TmpDir=/tmp@TmpDir=${ZABBIX_PROXY_TmpDir}@g" ${ZABBIX_SOFTWARE_INSTALL_DIR}/etc/zabbix_proxy.conf

#值为1就允许root启动，为0则不允许
	sed -i "s/# AllowRoot=0/AllowRoot=${ZABBIX_PROXY_AllowRoot}/g" ${ZABBIX_SOFTWARE_INSTALL_DIR}/etc/zabbix_proxy.conf

#zabbix进程启动用户
	sed -i "s/# User=zabbix/User=${ZABBIX_PROXY_User}/g" ${ZABBIX_SOFTWARE_INSTALL_DIR}/etc/zabbix_proxy.conf

#ZABBIX_Server_Include链接文件
	sed -i "s@# Include=\/usr\/local\/etc\/zabbix_proxy.conf.d\/\*.conf@Include=${ZABBIX_PROXY_Include}@g" ${ZABBIX_SOFTWARE_INSTALL_DIR}/etc/zabbix_proxy.conf


}


function config_etc_services_file(){
cat >> /etc/services <<EOF
####### for zabbix service #######
zabbix-agent    10050/tcp               # Zabbix Agent
zabbix-agent    10050/udp               # Zabbix Agent
zabbix-trapper  10051/tcp               # Zabbix Trapper
zabbix-trapper  10051/udp               # Zabbix Trapper
EOF
}

function config_zabbix_html_file(){

	mkdir -p ${ZABBIX_HTML_DIR}
#copy html to ${ZABBIX_HTML_DIR}
	echo "#copy html to ${ZABBIX_HTML_DIR}"
	\cp -prv ${ZABBIX_SOFTWARE_DOWNLOAD_DIR}/zabbix-${Zabbix_Server_Version}/frontends/php/* ${ZABBIX_HTML_DIR}
#copy font to ${ZABBIX_HTML_DIR}/font
	\cp -prv ${ZABBIX_SOFTWARE_DOWNLOAD_DIR}/simkai.ttf ${ZABBIX_HTML_DIR}/fonts
	sed -i "s/DejaVuSans/simkai/g" ${ZABBIX_HTML_DIR}/include/defines.inc.php	

	\cp -prv ${ZABBIX_HTML_DIR}/conf/zabbix.conf.php.example ${ZABBIX_HTML_DIR}/conf/zabbix.conf.php

#修改数据库类型
	sed -i "/TYPE/s@'MYSQL'@\'${ZABBIX_DB_SERVER_TYPE}\'@" ${ZABBIX_HTML_DIR}/conf/zabbix.conf.php
#修改数据库地址
	sed -i "/'SERVER'/s@'localhost'@\'${ZABBIX_DB_SERVER_IP}\'@" ${ZABBIX_HTML_DIR}/conf/zabbix.conf.php
#修改数据库端口
	sed -i "/PORT/s@'0'@\'${ZABBIX_DB_SERVER_PORT}\'@" ${ZABBIX_HTML_DIR}/conf/zabbix.conf.php
#修改数据库名
	sed -i "/DATABASE/s@'zabbix'@\'${ZABBIX_SQL_DB_NAME}\'@" ${ZABBIX_HTML_DIR}/conf/zabbix.conf.php
#修改数据库用户名
	sed -i "/USER/s@'zabbix'@\'${ZABBIX_SQL_DB_USER}\'@" ${ZABBIX_HTML_DIR}/conf/zabbix.conf.php
#修改数据库用户密码
	sed -i "/PASSWORD/s@''@\'${ZABBIX_SQL_DB_PASSWORD}\'@" ${ZABBIX_HTML_DIR}/conf/zabbix.conf.php
#修改Zabbix服务器地址
	sed -i "/ZBX_SERVER/s@'localhost'@\'${ZABBIX_SERVER_IP}\'@" ${ZABBIX_HTML_DIR}/conf/zabbix.conf.php
}

function install_zabbix_sql(){
	systemctl restart mariadb.service
	systemctl enable mariadb.service
	systemctl status mariadb.service
	mysqladmin -v -uroot password ${SQL_DB_ROOT_PASSWORD}
	echo "创建zabbix数据库，和用户名密码"
	echo "drop database IF EXISTS ${ZABBIX_SQL_DB_NAME};" | mysql -v -uroot -p${SQL_DB_ROOT_PASSWORD}
	echo "create database IF NOT EXISTS ${ZABBIX_SQL_DB_NAME} default charset utf8 COLLATE utf8_general_ci;" | mysql -v -uroot -p${SQL_DB_ROOT_PASSWORD}
	echo "grant all privileges on ${ZABBIX_SQL_DB_NAME}.* to ${ZABBIX_SQL_DB_USER}@'localhost' identified by \"${ZABBIX_SQL_DB_PASSWORD}\";" | mysql -v -uroot -p${SQL_DB_ROOT_PASSWORD}
	echo "grant all privileges on ${ZABBIX_SQL_DB_NAME}.* to ${ZABBIX_SQL_DB_USER}@'%' identified by \"${ZABBIX_SQL_DB_PASSWORD}\";" | mysql -v -uroot -p${SQL_DB_ROOT_PASSWORD}
	echo "flush privileges;" | mysql -v -uroot -p${SQL_DB_ROOT_PASSWORD}
#	zcat /usr/share/doc/zabbix-server-mysql-4.0.0/create.sql.gz | mysql -uzabbix -p  zabbix
	mysql -v -u${ZABBIX_SQL_DB_USER} -p${ZABBIX_SQL_DB_PASSWORD} ${ZABBIX_SQL_DB_NAME} < ${ZABBIX_SOFTWARE_DOWNLOAD_DIR}/zabbix-${Zabbix_Server_Version}/database/mysql/schema.sql
	mysql -v -u${ZABBIX_SQL_DB_USER} -p${ZABBIX_SQL_DB_PASSWORD} ${ZABBIX_SQL_DB_NAME} < ${ZABBIX_SOFTWARE_DOWNLOAD_DIR}/zabbix-${Zabbix_Server_Version}/database/mysql/images.sql
	mysql -v -u${ZABBIX_SQL_DB_USER} -p${ZABBIX_SQL_DB_PASSWORD} ${ZABBIX_SQL_DB_NAME} < ${ZABBIX_SOFTWARE_DOWNLOAD_DIR}/zabbix-${Zabbix_Server_Version}/database/mysql/data.sql
}
function config_mariadb_limits_conf_file(){
	cat > /etc/security/limits.d/mariadb.conf <<EOF
mysql       hard    nofile        655350
mysql       soft    nofile        655350
EOF
	sed -i '/socket=/amax_user_connections = 8192' /etc/my.cnf
	sed -i '/socket=/amax_connections = 40960' /etc/my.cnf
	sed -i '/socket=/aconnect_timeout = 60' /etc/my.cnf
	sed -i '/socket=/await_timeout = 5000' /etc/my.cnf
	sed -i '/socket=/amax_allowed_packet = 512M' /etc/my.cnf
	sed -i '/socket=/amax_connect_errors = 400' /etc/my.cnf
	sed -i '/socket=/atmp_table_size = 1024M' /etc/my.cnf
	sed -i '/socket=/amax_heap_table_size = 1024M' /etc/my.cnf
	sed -i '/socket=/atable_cache = 256' /etc/my.cnf
}
function config_mariadb_service_file(){
	sed -i '/Group=mysql/aLimitNOFILE=65535' /lib/systemd/system/mariadb.service
	systemctl daemon-reload
}
function start_mariadb_service(){
	systemctl restart mariadb.service
	systemctl enable mariadb.service
	systemctl status mariadb.service
}
function start_httpd_service(){
	systemctl restart httpd.service
	systemctl enable httpd.service
	systemctl status httpd.service
}
function start_zabbix_service_service(){
	chkconfig zabbix_server on
	systemctl restart zabbix_server.service
	systemctl enable zabbix_server.service
	systemctl status zabbix_server.service
}
function start_zabbix_agentd_service(){
	chkconfig zabbix_agentd on
	systemctl restart zabbix_agentd.service
	systemctl enable zabbix_agentd.service
	systemctl status zabbix_agentd.service
}
function download_all_software(){
	download_fping_software
	download_zabbix_software
}
function install_zabbix_server(){
	download_all_software
	install_fping_software
	install_JDK_software
	create_user_and_group
	install_zabbix_server_software
	create_zabbix_server_and_agentd_dir
	copy_zabbix_agent_script
	config_etc_sudoers_file
	config_zabbix_server_and_agentd_profile_file
	install_zabbix_server_initd_file
	config_zabbix_server
	install_zabbix_agentd_initd_file
	config_zabbix_agentd
#	config_zabbix_proxy
	config_etc_services_file
	config_zabbix_html_file
	config_mariadb_limits_conf_file
	config_mariadb_service_file
	start_mariadb_service
	install_zabbix_sql
	start_httpd_service
	start_zabbix_service_service
	start_zabbix_agentd_service
}
function install_zabbix_agentd(){
	download_all_software
	install_fping_software
	install_JDK_software
	create_user_and_group
	install_zabbix_agentd_software
#	install_zabbix_server_software
	create_zabbix_server_and_agentd_dir
	copy_zabbix_agent_script
	config_etc_sudoers_file
	config_zabbix_server_and_agentd_profile_file
#	install_zabbix_server_initd_file
#	config_zabbix_server
	install_zabbix_agentd_initd_file
	config_zabbix_agentd
#	config_zabbix_proxy
	config_etc_services_file
#	config_zabbix_html_file
#	config_mariadb_limits_conf_file
#	config_mariadb_service_file
#	start_mariadb_service
#	install_zabbix_sql
#	start_httpd_service
#	start_zabbix_service_service
	start_zabbix_agentd_service
}
#install_zabbix_server
install_zabbix_agentd









