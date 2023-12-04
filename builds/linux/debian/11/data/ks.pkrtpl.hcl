# Copyright 2023 VMware, Inc. All rights reserved
# SPDX-License-Identifier: BSD-2

# Debian 11
# https://www.debian.org/releases/bullseye/amd64/

# Locale and Keyboard
d-i debian-installer/locale string ${vm_guest_os_language}
d-i keyboard-configuration/xkb-keymap select ${vm_guest_os_keyboard}

# Clock and Timezone
d-i clock-setup/utc boolean true
d-i clock-setup/ntp boolean true
d-i time/zone string ${vm_guest_os_timezone}

# Grub and Reboot Message
d-i finish-install/reboot_in_progress note
d-i grub-installer/only_debian boolean true
d-i grub-installer/with_other_os boolean true

# Partitioning
d-i partman-auto/disk string /dev/sda
d-i partman-auto/method string regular
d-i partman-partitioning/choose_label select gpt
d-i partman-partitioning/default_label string gpt
d-i partman-efi/non_efi_system boolean true
d-i partman-auto/expert_recipe string                           \
        boot-root ::                                            \
                100 150 200 free                                \
                        $iflabel{ gpt }                         \
                        $reusemethod{ }                         \
                        method{ efi }                           \
                        format{ } .                             \
                8000 30 -1 ext4                                 \
                        $primary{ }                             \
                        $bootable{ }                            \
                        method{ format } format{ }              \
                        use_filesystem{ } filesystem{ ext4 }    \
                        mountpoint{ / }                         \
                .
d-i partman-auto/choose_recipe select boot-root
d-i partman-md/confirm boolean true
d-i partman-partitioning/confirm_write_new_label boolean true
d-i partman/choose_partition select finish
d-i partman/confirm boolean true
d-i partman/confirm_nooverwrite boolean true
d-i partman-basicfilesystems/no_swap boolean false

# Network configuration
d-i netcfg/choose_interface select auto
d-i netcfg/get_hostname string unassigned-hostname
d-i netcfg/get_domain string unassigned-domain

# Mirror settings
d-i mirror/country string manual
d-i mirror/http/hostname string cdn-fastly.deb.debian.org
d-i mirror/http/directory string /debian
d-i mirror/http/proxy string

# User Configuration
d-i passwd/root-login boolean true
d-i passwd/root-password-crypted password $6$mkdXiHcbV8O$7gzDS0ymtxDLZHExOPn/5VEnmwhAc7ILja5DLLo1B7oTkB1LVwi2PF0bIjxZo2/nUvE/pS0FvNpaO74KiKjQ.0
d-i passwd/user-fullname string ${build_username}
d-i passwd/username string ${build_username}
d-i passwd/user-password-crypted password ${build_password_encrypted}

# Package Configuration
d-i pkgsel/run_tasksel boolean false
d-i pkgsel/include string openssh-server open-vm-tools python3-apt bzip2 wget curl net-tools dirmngr aptitude parted at unzip sudo

# Add User to Sudoers
d-i preseed/late_command string \
    echo '${build_username} ALL=(ALL) NOPASSWD: ALL' > /target/etc/sudoers.d/${build_username} ; \
    in-target chmod 440 /etc/sudoers.d/${build_username} ; \
    in-target sed -i 's/^#\?PermitRootLogin .*/PermitRootLogin yes/g' /etc/ssh/sshd_config

%{ if common_data_source == "disk" ~}
# Umount preseed media early
d-i preseed/early_command string \
    umount /media && echo 1 > /sys/block/sr1/device/delete ;
%{ endif ~}
