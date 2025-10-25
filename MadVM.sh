### Por Adolfo David Mauro mail: davidmauroweb@gmail.com


clear

echo "***********************************************"
echo " Post Instal de Void"
echo " Escritorio  Mate o LXQTWayland junto a SDDM"
echo " NOTA: la clave puede ser solicitada en varias"
echo " oportunidades por cuestiones de TimeOut"
echo "***********************************************"
echo ""
echo ""
rt=$(pwd)
sleep 2s
echo "Introduzca contraseña para continuar"
sudo -k
if sudo true; then
	clear
	echo "Iniciando Instalación..."
	sleep 2s
else
	clear
	echo "Debe introduccir contraseña para continuar"
	exit 1
fi


#base grafica
sudo xbps-install -y at-spi2-core base-devel p7zip xdg-user-dirs NetworkManager network-manager-applet xorg xinit gvfs elogind sddm  htop neofetch xarchiver octoxbps papirus-icon-theme gtk-theme-united-gnome xtools
echo "ESCRITORIO"
echo "--------------------"
echo "1. Mate Xorg"
echo "2. Lxqt Wayland"
echo "*. Lxqt Xorg"
read desk
case $desk in
	1)
	lista="mate brisk-menu nano mate-extra pluma"
	;;
	*)
	lista="lxqt lxqt-wayland-session wayfire wayland wayland-utils featherpad "
	;;
esac

sudo xbps-install -y $lista

#Ofimatica
clear
echo "Paquetes de Oficina"
echo "-------------------"
echo "1. Abiword + Gnumeric"
echo "2. Libreoffice"
echo "3. Sin Paquetes de Oficina"
read o
spell= "aspell hunspell-es_ES"
case $o in
	1)
		o="abiword gnumeric "$spell
		;;
	2)
		o="libreoffice libreoffice-i18n-es "$spell
		;;
	*)
		echo "Se ha omitido la instalación de paquetes de Oficina"
		o=""
		;;
esac

clear
echo "Navegadores"
echo "-------------------"
echo "1. Firefox"
echo "2. Chromium"
echo "3. Midori"
echo "4. Dillo (navegador gráfico minimalista)"
read w
case $w in
	1)
	w=" firefox"
	;;
	2)
	w=" chromium"
	;;
	3)
	w=" midori"
	;;
	4)
	w=" dillo"
	;;
	*)
	echo "Se ha omitido la instalación del navegador"
	w=""
	;;
esac

clear
echo "Multimedia"
echo "-------------------"
echo "1. VLC"
echo "2. mpv + audacious"
read m
case $m in
        1)
        m=" vlc "
        ;;
        2)
        m=" mpv audacious"
        ;;
        *)
        echo "Se ha omitido la instalación reproductores multimedia"
        m=""
        ;;
esac


# Instalo las selecciones
echo "instalaciondo los paquetes seleccionados - Ingrese la clave si es requerida"
sudo xbps-install -y $o $w $m

clear
echo "Aplicando configuraciones..."
sleep 2s

#config
xdg-user-dirs-update

echo "copiando archivos de configuracion personal"


#cp -r config/* $HOME/.config/
case $desk in 
	1)
	mkdir $HOME/.config/mate/
	cp $rt/backgrounds.xml $HOME/.config/mate/
	mkdir $HOME/.config/autostart
	cp $rt/*.desktop $HOME/.config/autostart/
	sudo cp $rt/dconf.sh /usr/share/MADdconf.sh
	sudo chmod a+x /usr/share/MADdconf.sh
	;;
	*)
	cp $rt/lxqt/* $HOME/.config/lxqt/ -R
	;;
esac
clear
echo "XBPS-Src - para instalar software extra "
echo "Visitar https://github.com/void-linux/void-packages para mas info"
echo "-----------------------------------------------------------------"
echo "1. Si"
echo "2. No"
read m
case $m in
        1)
	cd
        git clone https://github.com/void-linux/void-packages.git
	cd void-packages
	./xbps-src binary-bootstrap
	cd ..
        ;;
        *)
        echo "Se ha omitido la instalación de XBPS-Src"
        ;;
esac

clear
echo "Impresoras "
echo "Instalar soporte de impresion CUPS?"
echo "-----------------------------------------------------------------"
echo "1. Si"
echo "2. No"
read m
case $m in
        1)
	sudo xbps-install -S cups cups-filters gutenprint foomatic-db foomatic-db-nonfree avahi hplip brother-brlaser nss-mdns system-config-printer cups-pk-helper
	sudo ln -s /etc/sv/cupsd /etc/runit/runsvdir/default/
	sudo ln -s /etc/sv/avahi-daemon /var/service
        ;;
        *)
        echo "Se ha omitido la instalación de CUPS"
        ;;
esac

#iniciar servicios
echo "Activando Servicios"

sudo cp $rt/bg* /usr/share/backgrounds/

sudo ln -s /etc/sv/dbus /var/service/
sudo ln -s /etc/sv/NetworkManager /var/service/
sudo ln -s /etc/sv/elogind /var/service/
sudo ln -s /etc/sv/sddm /var/service/


###

echo "Instalacion de MAD-Void-Mate Completada"
echo "Pulse cualquiera tecla para continuar..."
read tecla
clear
