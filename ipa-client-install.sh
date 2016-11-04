#!/bin/bash
# ipa-client-install.sh

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
#  (ninguno)
#

# 1) Comprobamos si ipa-client está instalado, en caso contrario lo instalamos:
packages="ipa-client"
# if...
	yum -y install $packages
#fi

# 2) Comprobamos si el sistema ya es miembro del dominio IPA (mirando si existe
#   el fichero /etc/ipa/default.com), y en caso contrario lo añadimos al dominio: 
echo ${PASSWD_ADMIN} | kinit "admin@${DOMINIO_KERBEROS}" 2>/dev/null 1>/dev/null


fichero=$(find /etc/ipa/ -name "default.conf")

if [ -z "$fichero" ]
	then
	echo 'No existe el fichero /etc/ipa/default.conf'
	else
	ipa-server-install -a Virtual2016 -p Virtual2016 
	--hostname=sl1.admon.lab -r ADMON.LAB -n admon.lab 
	--setup-dns --no-forwarders -U
fi
#if... Existe el fichero /etc/ipa/default.conf 
#then
   # INSTALAR el cliente IPA (instalación desatendida)
#fi


