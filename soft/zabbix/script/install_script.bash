#!/bin/bash
set -x
function copy_zabbix_agent_script () {
	\cp -prv ${ZABBIX_SOFTWARE_DIR}/script/* ${ZABBIX_AGENTD_SCRIPT_DIR}/
	chown ${ZABBIX_USER}.${ZABBIX_GROUP} -R ${ZABBIX_AGENTD_SCRIPT_DIR}
	cat > ${ZABBIX_INSTALL_SOFTWARE_DIR}/etc/zabbix_agentd.conf.d/tcp_status.conf <<EOF
UserParameter=tcp.status[*],${ZABBIX_AGENTD_SCRIPT_DIR}/tcp_status.sh \$1
EOF

	cat > ${ZABBIX_INSTALL_SOFTWARE_DIR}/etc/zabbix_agentd.conf.d/top_10_process_use_memory.conf <<EOF
#top_process
UserParameter=process.discovery[*],${ZABBIX_AGENTD_SCRIPT_DIR}/top_10_process_use_memory.py \$1
UserParameter=process.resource[*],${ZABBIX_AGENTD_SCRIPT_DIR}/top_10_process_use_memory.py \$1 \$2
EOF
}