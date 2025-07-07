#!/bin/bash

DISCOS_LV=(sdc sdd)

#Agregar discos y crear particiones tipo 8e (para lvm)
for disk in "${DISCOS_LV[@]}"; do
  sudo fdisk /dev/$disk << EOF
n
p



t
8e
w
EOF
done

# formateo de particion swap
sudo fdisk /dev/sdf << EOF
n
p



t
82
w
EOF

# Limpiar mugre de los discos
for disk in "${DISCOS_LV[@]}" sde; do
  sudo wipefs -a /dev/"${disk}1" || true
done

# Crear el phisical volume
sudo pvcreate /dev/sdc1
sudo pvcreate /dev/sdd1

# Crear volume group
sudo vgcreate vg_datos /dev/sdc1
sudo vgcreate vg_temp /dev/sdd1

# Crear logical volume 
sudo lvcreate -L +2500M vg_datos -n lv_workareas
sudo lvcreate -L +10M vg_datos -n lv_docker
sudo lvcreate -L +2500M vg_temp -n lv_swap

# Creación de fs 
sudo mkfs.ext4 /dev/mapper/vg_datos-lv_docker
sudo mkfs.ext4 /dev/mapper/vg_datos-lv_workareas

# Creación de swap
sudo mkswap /dev/mapper/vg_temp-lv_swap
sudo swapon /dev/mapper/vg_temp-lv_swap

# Montaje de los lv's
sudo mkdir -p /work # Creación previa de carpeta de montaje de workarea
sudo mount /dev/mapper/vg_datos-lv_docker /var/lib/docker
sudo mount /dev/mapper/vg_datos-lv_workareas /work

# Agregación en /etc/fstab para persistencia constante
echo "/dev/mapper/vg_datos-lv_docker /var/lib/docker ext4 defaults 0 2" | sudo tee -a /etc/fstab
echo "/dev/mapper/vg_datos-lv_workareas /work ext4 defaults 0 2" | sudo tee -a /etc/fstab
echo "/dev/mapper/vg_temp-lv_swap none swap sw 0 0" | sudo tee -a /etc/fstab

# Reinico de docker si ya se encontraba corriendo
sudo systemctl restart docker
sudo systemctl status docker | cat | head -n 12

echo "LVM's y swap configurados correctamente..."


