#!/bin/bash
# ipa-server-install.sh

source /vagrant/scripts/common.sh

#
# NOTA PREVIA GENERAL:
# 
#       En este script se han omitido expresamente algunas comprobaciones
#       previas a cada acción, y en general todas las comprobaciones de error.
#       Se deja al alumno que las implemente como desee, así como algunas acciones
#       que se comentan pero no se resuelven.
#

# DATOS DE ENTRADA (desde Vagrantfile):
#
# - nombre_host (string): nombre del servidor (sin sufijo DNS).
#                         Parámetro obligatorio.
#

# 0) Comprobación previa de parámetros de entrada obligatorios
# if...
	echo "Error: falta..."
	exit 1
# fi

fqdn="${nombre_host}.${DOMINIO}"

# 1) Comprobamos si los paquetes necesarios están instalados, y en caso contrario los instalamos:
packages="ipa-server bind bind-dyndb-ldap ipa-server-dns"
#if ...
	sudo yum -y install $packages
#fi

# 2) Comprobamos si el dominio IPA está creado (solicitando un tique kerberos para
#    el administrador), y en caso contrario lo creamos:
echo ${PASSWD_ADMIN} | kinit "admin@${DOMINIO_KERBEROS}" 2>/dev/null 1>/dev/null
if [[ "$?" != "0" ]]
then
   	# INSTALAR el servidor IPA (instalación desatendida)
	ipa-server-install -a Virtual2016 -p Virtual2016 
--hostname=sl1.admon.lab -r ADMON.LAB -n admon.lab 
--setup-dns --no-forwarders -U
fi


