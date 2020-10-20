#!/bin/bash

#Repository https://github.com/Many-ip/PROJECTE-01

# 1-Make sure the script is being executed with superuser privileges.
if [ $EUID -ne 0 ]
then
	echo "Se neceista permisos de administrador."
       	echo "Use sudo ./script.sh"
else
	# 2-Get the username (login)
	read -p "Introduce nombre de usuario: " username

	# 3-Get the real name (contents for the description field)
	read -p "Introduce nombre completo del usuario: " descripcion	

	# 4-Get the password
	read -p "Introduce Contraseña: " password

	# 5-Create the user.
	useradd -c $descripcion -m $username

	# 6-Check to see if the useradd command succeeded.
	if [[ "${?}" -ne 0 ]]
	then
		echo "No se ha podido crear el usuario"
		exit 1
	fi

	# 7-Set the password.
	echo -e "$password\n$password" |passwd $username
	passwd -e $username

	# 8-Check to see if the passwd command succeeded.
	if [[ $? -ne 0 ]]
	then
		echo "La contraseña no se ha podido añadir"
		exit 1
	fi


	# 9-Force password change on first login.
	passwd -e ${username}
	
	# 10-Display the username, password, and the host where the user was create
	echo
	echo "username: $username"
	echo "password: $password"
	echo "host: $HOSTNAME"
	exit 0

fi
