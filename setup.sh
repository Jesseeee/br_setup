#!/bin/bash

SCRIPT_DIR="$(dirname -- "$( readlink -f -- "${BASH_SOURCE[0]}"; )")"

DEFAULT_BR_VERSION=2024.05
BR_VERSION="${DEFAULT_BR_VERSION}"
BACKUP_URL="https://buildroot.org/downloads"

case "$1" in
	*_defconfig)
		# Here you can "lock" any defconfigs as needed
		DIR_NAME="buildroot-${BR_VERSION}"
		TAR_NAME="${DIR_NAME}.tar.xz"
		BR_BACKUP_URL="${BACKUP_URL}/${TAR_NAME}"
		if [ ! -e "${SCRIPT_DIR}"/${DIR_NAME} ]; then
			if [[ `wget -S --spider ${BR_BACKUP_URL} 2>&1 | grep 'HTTP/1.1 200 OK'` ]]; then
				echo "Source archive exists on buildroot.org, downloading from there"
				wget -q ${BR_BACKUP_URL} -O ${SCRIPT_DIR}/${TAR_NAME}
			else
				echo "Buildroot version ${BR_VERSION} does not exist"
				exit 1
			fi
			mkdir ${SCRIPT_DIR}/${DIR_NAME}
			tar -xf ${SCRIPT_DIR}/${TAR_NAME} -C ${SCRIPT_DIR}/${DIR_NAME} --strip-components=1
			rm ${SCRIPT_DIR}/${TAR_NAME}
		fi
		cd ${SCRIPT_DIR}/${DIR_NAME}
		make BR2_EXTERNAL=../external-tree $@
		;;
	*)
		echo "Usage: $0 *_defconfig [other BR options...]"
		exit 1
esac
