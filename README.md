# TP_AySO_Integral_Maruchan

## Trabajo práctico 2: TP integral

### _Integrantes:_

-   Lucas Viamont - Legajo: 115722
-   Facundo Berges - Legajo: 111064

### _Enunciados y template:_

[upszot:UTN-FRA_SO_TP-Integral](https://github.com/upszot/UTN-FRA_SO_TP-Integral.git)

### _Consignas:_

1. **Creación del repositorio (R1):** La persona asignada con el Rol de Líder deberá crear el repositorio:
   - Nombre: TP_AySO_Integral\___\<nombre_grupo\>__ (Reemplazar nombre_grupo según corresponda).
   - Crear la rama "dev". 
   - Agregar a los distintos miembros del grupo, con permisos de push contra la rama dev.

---

2. **(TODOS)** Cada integrante deberá clonar el repositorio. Agregar en una sola línea:
   - Nombre y Apellido: \*\*\*\*\*\* - Legajo: \*\*\*\*\*\*
   - Realizar un push contra la rama dev_Rn 
   - Realizar un pull request para que el Líder suba los cambios a la rama master.

---

3. **VM (R2):**

    - Crear: 
        - 2 máquinas virtuales (VM's): Vagrantfile 
        - Sistemas operativos (SO): Ubuntu (testing) y Fedora (producción). 
        - Discos: 4 discos (5G, 3G, 2G). 
        - Disco extra: 1G (**_NO USAR_**, se usará en clase).
    - Subir al repositorio el archivo _Vagrantfile_ que se utilizará, y el conjunto de scripts si es necesario.
    - Cargar en **/etc/host** las VM para la resolución del nombre, de tal forma que se pueda hacer referencia por nombre a las VM's levantadas.
      **IP | Nombre-VM**

    - Cruzar las claves de ssh para su logueo sin clave.
    - Configurar los usuarios para que no requieran de clave al realizar sudo.
    - Scriptear la instalación de todos los programas que usarán en la resolución del TP.
    - El aprovisionamiento y la configuración de los servidores los podrán realizar:

        - **(R3)** Bash-scripting, o
        - **(R4)** Ansible (Rol: **Server_init**)

        En cualquiera de los casos, se deberá ejecutar desde vagrant en el provisión:

        - [Provisioning con ansible](https://developer.hashicorp.com/vagrant/docs/provisioning/ansible)
        - [Provisioning con shell](https://developer.hashicorp.com/vagrant/docs/provisioning/shell)

---

4. **LVM (R2):** Se trabajará con los discos (5G, 3G, 2G). Generar las particiones, PV's, VG's, LV's según los siguientes cuadros:

A.

| VG       | LV           | Tamaño | Punto de montaje |
| -------- | ------------ | ------ | ---------------- |
| vg_datos | lv_docker    | 10M    | /var/lib/docker/ |
| vg_datos | lv_workareas | 2.5GB  | /work/           |
| vg_temp  | lv_swap      | 2.5G   | Memoria Swap     |

B.
| Tamaño | Tipo | Punto de montaje |
|--------|-----------|------------------|
| 1G | swap (82) | Memoria Swap |

**Nota:** Si ya contaba con docker corriendo en su equipo, recuerde que después de montar el volumen, debe restartear el servicio de docker para que se genere automáticamente la estructura de directorio.

```shell
$ sudo systemctl restart docker
$ sudo systemctl status docker
```

---

5. **Bash scripting (R3):**

Se deberán desarrollar 2 scripts:

-   Alta de usuarios
-   Chequeo de URL

Dentro del repositorio del TP, podrán observar el directorio _Bash_script_ con el esquema de los dos scripts a desarrollar. Usted deberá modificar los mismos para que realicen las tareas pedidas.

```shell
Bash_script/
├── alta_usuarios
│   ├── Lista_Usuarios.txt
│   └── alta_usuarios.sh
└── check_url
    ├── Lista_URL.txt
    ├── README.md
    └── check_URL.sh
```

Ver **_README.md_** para más detalles.

---

6. **Docker (R5):**

Dentro del repositorio del TP, se encontrarán con una carpeta _docker_. La misma cuenta con una estructura de archivos.

```html
<div>
	<h1>TP-INTEGRAL</h1>
	<h2>Detalles del Grupo</h2>
	<ul>
		<li>Nombre Grupo: **********</li>
		<li>División: Tu-Division</li>
		<li id="examen">Fecha: <span id="fecha"></span></li>
		<li>IP Pública: <span id="ip-publica"></span></li>
		<li></li>
		<li>Role: (R1) - Nombre: ****** Apellido: ****** Legajo: ******</li>
		<li>Role: (R2) - Nombre: ****** Apellido: ****** Legajo: ******</li>
		<li>Role: (R3) - Nombre: ****** Apellido: ****** Legajo: ******</li>
		<li>Role: (R4) - Nombre: ****** Apellido: ****** Legajo: ******</li>
		<li>Role: (R5) - Nombre: ****** Apellido: ****** Legajo: ******</li>
		<li>Role: (R6) - Nombre: ****** Apellido: ****** Legajo: ******</li>
	</ul>
</div>
```

-   Modificar el archivo index indicando nombre del grupo e integrantes, con sus respectivas funciones.
-   Generar una imagen de docker basada en _"nginx"_:

*   Nombre: **TP-Div_XXX_Grupo_XXXXXX**
*   Reemplazar XXX por el número de división.
*   Reemplazar XXXXXX por el nombre del grupo.

La imagen contará con la carpeta **web** incluida en la misma.

Pushearla en [docker hub](https://hub.docker.com/). Cada integrante deberá tener la misma imagen en su docker-hub.

Editar el archivo _"docker-compose.yml"_:

-   La imagen que se correrá es la del docker-hub del **Líder**.
-   Deberán de estar comentadas cada una de las imágenes de los demás integrantes de tal forma que se pueda cambiar de imagen fácilmente y probar la de otro integrante.
-   Montar como volumen **web/file/** en el siguiente path del contenedor: **/usr/share/nginx/html/file/**
-   Con el contenedor en ejecución, se podrá modificar dicho archivo, y tras refrescar la web se deberá ver el cambio.
-   Publicar dicha web en el puerto 8081 del host.
-   Correr la imagen desde docker compose.

_Nota:_

-   Para visualizar bien el archivo deberá tener habilitado en el navegador web javascript.
-   Usted debería poder desde su máquina host (Windows) abrir un navegador, poner en la barra de direcciones la ip del servidor:puerto y visualizar la web:
    -   192.168.56.10:8081
    -   192.168.56.11:8081 _(asumiendo que las IP's sean esas...)_

---

7. **Ansible (R4):**

Desarrollar un Playbook que ejecute los roles pedidos.
Se deberá de poder ejecutar el playbook sin pasar claves, de sudo ni de ssh, para lo cual se deberá asegurar que el usuario cuente con permisos en sudoers para la ejecución de cualquier comando sin password.
Por otro lado, deberá estar cruzadas las claves contra ambos equipos: Ubuntu (testing) y Fedora (producción).

Generar/modificar los siguientes roles:

| Nombre                              | Descripción de las Tareas que debe realizar                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| ----------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| TP_INI                              | Dejar un archivo **/tmp/Grupo/datos.txt** <br/> Owner: vagrant <br/> Con el siguiente contenido: <br/> <br/>Nombre Grupo: **\<Nombre-Grupo\>** <br/> División: **\<Tu-División\>** <br/>Fecha: **\<fecha del dia\>** <br/> ------------------------- <br/> Distribución: **\<Tu-Distro\>** <br/> Cantidad de Cores: **\<XX\>** <br/> ------------------------- <br/> R1: Nombre: **\<Tu-Nombre\>** Apellido: **\<Tu-Apellido\>** <br/> R2: Nombre: **\<Tu-Nombre\>** Apellido: **\<Tu-Apellido\>** <br/> R3: Nombre: **\<Tu-Nombre\>** Apellido: **\<Tu-Apellido\>** <br/> R4: Nombre: **\<Tu-Nombre\>** Apellido: **\<Tu-Apellido\>** <br/> R5: Nombre: **\<Tu-Nombre\>** Apellido: **\<Tu-Apellido\>** <br/> R6: Nombre: **\<Tu-Nombre\>** Apellido: **\<Tu-Apellido\>** <br/> |
| Alta_Usuarios\_**\<Nombre-Grupo\>** | Crear usuarios para cada miembro del grupo. <br/> **R\<x_Nombre\>** <br/> <br/> con Grupos Principales según el rol, que corresponda: <br/> **G_R1** <br/> **G_R2** <br/> **G_R3** <br/> **G_R4** <br/> **G_R5** <br/> **G_R6** <br/> <br/> El Grupo Secundario: **\<Nombre-Grupo\>** <br/> Con la misma clave del usuario vagrant.                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| Sudoers\_**\<Nombre-Grupo\>**       | Agregar al grupo **\<Nombre-Grupo\>** para que pueda ejecutar sudo sin clave.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| Instala-tools**\_\<Nombre-Grupo\>** | instalar los siguientes programas: <br/> <br/> htop <br/> tmux <br/> speedtest-cli                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               |

_NOTA:_

-   Para el 1er Role usar el módulo template.
-   Siempre que se requiera un Listado, cargar los mismos dentro de las vars.

---

### Entrega:

**_SOLO EL LÍDER:_**

Para entregar el TP, completar el siguiente [Formulario](https://docs.google.com/forms/d/e/1FAIpQLSdHivbiHgIlEbFQGpPG-5-vxRjZWPSnioYZpBHgFjTXleR-GQ/viewform)

En caso de que no funcione el hipervínculo, se deja debajo la URL del formulario:
https://docs.google.com/forms/d/e/1FAIpQLSdHivbiHgIlEbFQGpPG-5-vxRjZWPSnioYZpBHgFjTXleR-GQ/viewform



