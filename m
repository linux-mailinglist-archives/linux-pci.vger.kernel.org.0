Return-Path: <linux-pci+bounces-245-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02B7B7FDB6B
	for <lists+linux-pci@lfdr.de>; Wed, 29 Nov 2023 16:30:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1D75281FC5
	for <lists+linux-pci@lfdr.de>; Wed, 29 Nov 2023 15:30:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D1CD34CF7;
	Wed, 29 Nov 2023 15:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-pci@vger.kernel.org
X-Greylist: delayed 437 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 29 Nov 2023 07:30:01 PST
Received: from proxmox-new.maurer-it.com (proxmox-new.maurer-it.com [94.136.29.106])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45B88D43;
	Wed, 29 Nov 2023 07:30:01 -0800 (PST)
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
	by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 1C7AD40F03;
	Wed, 29 Nov 2023 16:22:43 +0100 (CET)
Message-ID: <9eb669c0-d8f2-431d-a700-6da13053ae54@proxmox.com>
Date: Wed, 29 Nov 2023 16:22:41 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Fiona Ebner <f.ebner@proxmox.com>
Subject: SCSI hotplug issues with UEFI VM with guest kernel >= 6.5
To: linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
 Igor Mammedov <imammedo@redhat.com>
Cc: linux-kernel@vger.kernel.org, bhelgaas@google.com, lenb@kernel.org,
 rafael@kernel.org, Thomas Lamprecht <t.lamprecht@proxmox.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,
it seems that hot-plugging SCSI disks for QEMU virtual machines booting
with UEFI and with guest kernels >= 6.5 might be broken. It's not
consistently broken, hinting there might be a race somewhere.

Reverting the following two commits seems to make it work reliably again:

cc22522fd55e2 ("PCI: acpiphp: Use
pci_assign_unassigned_bridge_resources() only for non-root bus")
40613da52b13f ("PCI: acpiphp: Reassign resources on bridge if necessary"

Of course, they might only expose some pre-existing issue, but this is
my best lead. See below for some logs and details about an affected
virtual machine. Happy to provide more information and to debug/test
further.

Best Regards,
Fiona

Host kernel: 6.5.11-4-pve which is based on the one from Ubuntu
Guest kernel: 6.7.0-rc3 and 6.7.0-rc3 with above commits reverted
QEMU version: v8.1.0 built from source
EDK2 version: submodule in the QEMU v8.1 repository: edk2-stable202302

QEMU command line:

> ./qemu-system-x86_64 \
>   -accel 'kvm' \
>   -chardev 'socket,id=qmp,path=/var/run/qemu-server/104.qmp,server=on,wait=off' \
>   -mon 'chardev=qmp,mode=control' \
>   -chardev 'socket,id=qmp-event,path=/var/run/qmeventd.sock,reconnect=5' \
>   -mon 'chardev=qmp-event,mode=control' \
>   -pidfile /var/run/qemu-server/104.pid \
>   -drive 'if=pflash,unit=0,format=raw,readonly=on,file=./pc-bios/edk2-x86_64-code.fd' \
>   -drive 'if=pflash,unit=1,id=drive-efidisk0,format=raw,file=/dev/u2nvme/vm-104-disk-0,size=540672' \
>   -smp '4,sockets=1,cores=4,maxcpus=4' \
>   -nodefaults \
>   -vnc 'unix:/var/run/qemu-server/104.vnc,password=on' \
>   -m 4096 \
>   -device 'pci-bridge,id=pci.1,chassis_nr=1,bus=pci.0,addr=0x1e' \
>   -device 'pci-bridge,id=pci.2,chassis_nr=2,bus=pci.0,addr=0x1f' \
>   -device 'pci-bridge,id=pci.3,chassis_nr=3,bus=pci.0,addr=0x5' \
>   -device 'VGA,id=vga,bus=pci.0,addr=0x2' \
>   -device 'virtio-scsi-pci,id=virtioscsi0,bus=pci.3,addr=0x1' \
>   -drive 'file=/dev/u2nvme/vm-104-disk-1,if=none,id=drive-scsi0,format=raw' \
>   -blockdev 'raw,file.driver=file,file.filename=/home/febner/plug.raw,node-name=drive-scsi1' \
>   -device 'scsi-hd,bus=virtioscsi0.0,channel=0,scsi-id=0,lun=0,drive=drive-scsi0,id=scsi0,bootindex=100' \
>   -netdev 'type=tap,id=net0,ifname=tap104i0,script=/var/lib/qemu-server/pve-bridge,downscript=/var/lib/qemu-server/pve-bridgedown,vhost=on' \
>   -device 'virtio-net-pci,mac=BC:24:11:89:6A:E6,netdev=net0,bus=pci.0,addr=0x12,id=net0,rx_queue_size=1024,tx_queue_size=256,bootindex=102' \
>   -bios './pc-bios/edk2-x86_64-code.fd'

Script to issue hotplug command via QEMU monitor protocol (QMP):

> #!/bin/sh
> 
> ID=$1
> CMD=$2
> 
> if [ -z "$ID" ]; then
>     echo "need to specify ID";
>     exit 1;
> fi
> 
> if [ -z "$CMD" ]; then
>     echo "need to specify command (plug or unplug)";
>     exit 1;
> fi
> 
> 
> if [ "$CMD" = "plug" ]; then
>     socat - /var/run/qemu-server/"$ID".qmp << END
>     {"execute": "qmp_capabilities"}
>     {"arguments":{"driver":"virtio-scsi-pci","bus":"pci.3","addr":"0x2","id":"virtioscsi1"},"execute":"device_add"}
>     {"arguments":{"bus":"virtioscsi1.0","channel":"0","driver":"scsi-hd","id":"scsi1","drive":"drive-scsi1","scsi-id":"0","lun":"1"},"execute":"device_add"}
> END
> elif [ "$CMD" = "unplug" ]; then
>     socat - /var/run/qemu-server/"$ID".qmp << END
>     {"execute": "qmp_capabilities"}
>     {"arguments":{"id":"scsi1"},"execute":"device_del"}
>     {"arguments":{"id":"virtioscsi1"},"execute":"device_del"}
> END
> fi

I've also tired and added 10 second sleep between the two device_add
commands just to be sure, but that didn't make a difference. (Our
management stack does query via QMP and wait for the device to show up
and is also affected, I was just too lazy to do that for the reproducer
here).

I've attached some logs for guest using kernel 6.7.0-rc3 where hotplug
works rarely and guest using kernel 6.7.0-rc3 with the previously
mentioned commits reverted where hotplug works reliably:

6.7.0-rc3:

> Nov 29 15:12:02 hotplug kernel: pci 0000:01:02.0: [1af4:1004] type 00 class 0x010000
> Nov 29 15:12:02 hotplug kernel: pci 0000:01:02.0: reg 0x10: [io  0x0000-0x003f]
> Nov 29 15:12:02 hotplug kernel: pci 0000:01:02.0: reg 0x14: [mem 0x00000000-0x00000fff]
> Nov 29 15:12:02 hotplug kernel: pci 0000:01:02.0: reg 0x20: [mem 0x00000000-0x00003fff 64bit pref]
> Nov 29 15:12:02 hotplug kernel: pci 0000:01:02.0: BAR 4: assigned [mem 0xc000004000-0xc000007fff 64bit pref]
> Nov 29 15:12:02 hotplug kernel: pci 0000:01:02.0: BAR 1: assigned [mem 0xc1401000-0xc1401fff]
> Nov 29 15:12:02 hotplug kernel: pci 0000:01:02.0: BAR 0: assigned [io  0xe040-0xe07f]
> Nov 29 15:12:02 hotplug kernel: pci 0000:00:05.0: PCI bridge to [bus 01]
> Nov 29 15:12:02 hotplug kernel: pci 0000:00:05.0:   bridge window [io  0xe000-0xefff]
> Nov 29 15:12:02 hotplug kernel: pci 0000:00:05.0:   bridge window [mem 0xc1400000-0xc15fffff]
> Nov 29 15:12:02 hotplug kernel: pci 0000:00:05.0:   bridge window [mem 0xc000000000-0xc01fffffff 64bit pref]
> Nov 29 15:12:02 hotplug kernel: virtio-pci 0000:01:02.0: enabling device (0000 -> 0003)
> Nov 29 15:12:02 hotplug kernel: ACPI: \_SB_.LNKC: Enabled at IRQ 11
> Nov 29 15:12:02 hotplug kernel: scsi host3: Virtio SCSI HBA
> Nov 29 15:12:02 hotplug kernel: pci 0000:00:05.0: PCI bridge to [bus 01]
> Nov 29 15:12:02 hotplug kernel: pci 0000:00:05.0:   bridge window [io  0xe000-0xefff]
> Nov 29 15:12:02 hotplug kernel: scsi 3:0:0:1: Direct-Access     QEMU     QEMU HARDDISK    2.5+ PQ: 0 ANSI: 5
> Nov 29 15:12:02 hotplug kernel: pci 0000:00:05.0:   bridge window [mem 0xc1400000-0xc15fffff]
> Nov 29 15:12:02 hotplug kernel: pci 0000:00:05.0:   bridge window [mem 0xc000000000-0xc01fffffff 64bit pref] 

Reboot

> Nov 29 15:12:52 hotplug kernel: pci 0000:01:02.0: [1af4:1004] type 00 class 0x010000
> Nov 29 15:12:52 hotplug kernel: pci 0000:01:02.0: reg 0x10: [io  0x0000-0x003f]
> Nov 29 15:12:52 hotplug kernel: pci 0000:01:02.0: reg 0x14: [mem 0x00000000-0x00000fff]
> Nov 29 15:12:52 hotplug kernel: pci 0000:01:02.0: reg 0x20: [mem 0x00000000-0x00003fff 64bit pref]
> Nov 29 15:12:52 hotplug kernel: pci 0000:01:02.0: BAR 4: assigned [mem 0xc000004000-0xc000007fff 64bit pref]
> Nov 29 15:12:52 hotplug kernel: pci 0000:01:02.0: BAR 1: assigned [mem 0xc1401000-0xc1401fff]
> Nov 29 15:12:52 hotplug kernel: pci 0000:01:02.0: BAR 0: assigned [io  0xe040-0xe07f]
> Nov 29 15:12:52 hotplug kernel: pci 0000:00:05.0: PCI bridge to [bus 01]
> Nov 29 15:12:52 hotplug kernel: pci 0000:00:05.0:   bridge window [io  0xe000-0xefff]
> Nov 29 15:12:52 hotplug kernel: pci 0000:00:05.0:   bridge window [mem 0xc1400000-0xc15fffff]
> Nov 29 15:12:52 hotplug kernel: pci 0000:00:05.0:   bridge window [mem 0xc000000000-0xc01fffffff 64bit pref]
> Nov 29 15:12:52 hotplug kernel: virtio-pci 0000:01:02.0: enabling device (0000 -> 0003)
> Nov 29 15:12:52 hotplug kernel: ACPI: \_SB_.LNKC: Enabled at IRQ 11
> Nov 29 15:12:52 hotplug kernel: scsi host3: Virtio SCSI HBA
> Nov 29 15:12:52 hotplug kernel: pci 0000:00:05.0: PCI bridge to [bus 01]
> Nov 29 15:12:52 hotplug kernel: pci 0000:00:05.0:   bridge window [io  0xe000-0xefff]
> Nov 29 15:12:52 hotplug kernel: pci 0000:00:05.0:   bridge window [mem 0xc1400000-0xc15fffff]
> Nov 29 15:12:52 hotplug kernel: scsi 3:0:0:1: Direct-Access     QEMU     QEMU HARDDISK    2.5+ PQ: 0 ANSI: 5
> Nov 29 15:12:52 hotplug kernel: pci 0000:00:05.0:   bridge window [mem 0xc000000000-0xc01fffffff 64bit pref]

RebootThe one time it did work. Note that the line with "QEMU HARDDISK"
comes after all lines with "bridge window":

> Nov 29 15:13:51 hotplug kernel: pci 0000:01:02.0: [1af4:1004] type 00 class 0x010000
> Nov 29 15:13:51 hotplug kernel: pci 0000:01:02.0: reg 0x10: [io  0x0000-0x003f]
> Nov 29 15:13:51 hotplug kernel: pci 0000:01:02.0: reg 0x14: [mem 0x00000000-0x00000fff]
> Nov 29 15:13:51 hotplug kernel: pci 0000:01:02.0: reg 0x20: [mem 0x00000000-0x00003fff 64bit pref]
> Nov 29 15:13:51 hotplug kernel: pci 0000:01:02.0: BAR 4: assigned [mem 0xc000004000-0xc000007fff 64bit pref]
> Nov 29 15:13:51 hotplug kernel: pci 0000:01:02.0: BAR 1: assigned [mem 0xc1401000-0xc1401fff]
> Nov 29 15:13:51 hotplug kernel: pci 0000:01:02.0: BAR 0: assigned [io  0xe040-0xe07f]
> Nov 29 15:13:51 hotplug kernel: pci 0000:00:05.0: PCI bridge to [bus 01]
> Nov 29 15:13:51 hotplug kernel: pci 0000:00:05.0:   bridge window [io  0xe000-0xefff]
> Nov 29 15:13:51 hotplug kernel: pci 0000:00:05.0:   bridge window [mem 0xc1400000-0xc15fffff]
> Nov 29 15:13:51 hotplug kernel: pci 0000:00:05.0:   bridge window [mem 0xc000000000-0xc01fffffff 64bit pref]
> Nov 29 15:13:51 hotplug kernel: virtio-pci 0000:01:02.0: enabling device (0000 -> 0003)
> Nov 29 15:13:51 hotplug kernel: ACPI: \_SB_.LNKC: Enabled at IRQ 11
> Nov 29 15:13:51 hotplug kernel: scsi host3: Virtio SCSI HBA
> Nov 29 15:13:51 hotplug kernel: pci 0000:00:05.0: PCI bridge to [bus 01]
> Nov 29 15:13:51 hotplug kernel: pci 0000:00:05.0:   bridge window [io  0xe000-0xefff]
> Nov 29 15:13:51 hotplug kernel: pci 0000:00:05.0:   bridge window [mem 0xc1400000-0xc15fffff]
> Nov 29 15:13:51 hotplug kernel: pci 0000:00:05.0:   bridge window [mem 0xc000000000-0xc01fffffff 64bit pref]
> Nov 29 15:13:51 hotplug kernel: scsi 3:0:0:1: Direct-Access     QEMU     QEMU HARDDISK    2.5+ PQ: 0 ANSI: 5
> Nov 29 15:13:51 hotplug kernel: sd 3:0:0:1: Attached scsi generic sg1 type 0
> Nov 29 15:13:51 hotplug kernel: sd 3:0:0:1: Power-on or device reset occurred
> Nov 29 15:13:51 hotplug kernel: sd 3:0:0:1: [sdb] 2048 512-byte logical blocks: (1.05 MB/1.00 MiB)
> Nov 29 15:13:51 hotplug kernel: sd 3:0:0:1: [sdb] Write Protect is off
> Nov 29 15:13:51 hotplug kernel: sd 3:0:0:1: [sdb] Mode Sense: 63 00 00 08
> Nov 29 15:13:51 hotplug kernel: sd 3:0:0:1: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
> Nov 29 15:13:51 hotplug kernel: sd 3:0:0:1: [sdb] Attached SCSI disk
> Nov 29 15:14:08 hotplug systemd[1]: systemd-fsckd.service: Deactivated successfully.

6.7.0-rc3 with the following reverted:
cc22522fd55e2 ("PCI: acpiphp: Use
pci_assign_unassigned_bridge_resources() only for non-root bus")
40613da52b13f ("PCI: acpiphp: Reassign resources on bridge if necessary")

> Nov 29 15:15:37 hotplug kernel: pci 0000:01:02.0: [1af4:1004] type 00 class 0x010000
> Nov 29 15:15:37 hotplug kernel: pci 0000:01:02.0: reg 0x10: [io  0x0000-0x003f]
> Nov 29 15:15:37 hotplug kernel: pci 0000:01:02.0: reg 0x14: [mem 0x00000000-0x00000fff]
> Nov 29 15:15:37 hotplug kernel: pci 0000:01:02.0: reg 0x20: [mem 0x00000000-0x00003fff 64bit pref]
> Nov 29 15:15:37 hotplug kernel: pci 0000:01:02.0: BAR 4: assigned [mem 0xc000004000-0xc000007fff 64bit pref]
> Nov 29 15:15:37 hotplug kernel: pci 0000:01:02.0: BAR 1: assigned [mem 0xc1401000-0xc1401fff]
> Nov 29 15:15:37 hotplug kernel: pci 0000:01:02.0: BAR 0: assigned [io  0xe040-0xe07f]
> Nov 29 15:15:37 hotplug kernel: virtio-pci 0000:01:02.0: enabling device (0000 -> 0003)
> Nov 29 15:15:37 hotplug kernel: ACPI: \_SB_.LNKC: Enabled at IRQ 11
> Nov 29 15:15:37 hotplug kernel: scsi host3: Virtio SCSI HBA
> Nov 29 15:15:37 hotplug kernel: scsi 3:0:0:1: Direct-Access     QEMU     QEMU HARDDISK    2.5+ PQ: 0 ANSI: 5
> Nov 29 15:15:37 hotplug kernel: sd 3:0:0:1: Attached scsi generic sg1 type 0
> Nov 29 15:15:37 hotplug kernel: sd 3:0:0:1: Power-on or device reset occurred
> Nov 29 15:15:37 hotplug kernel: sd 3:0:0:1: [sdb] 2048 512-byte logical blocks: (1.05 MB/1.00 MiB)
> Nov 29 15:15:37 hotplug kernel: sd 3:0:0:1: [sdb] Write Protect is off
> Nov 29 15:15:37 hotplug kernel: sd 3:0:0:1: [sdb] Mode Sense: 63 00 00 08
> Nov 29 15:15:37 hotplug kernel: sd 3:0:0:1: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
> Nov 29 15:15:37 hotplug kernel: sd 3:0:0:1: [sdb] Attached SCSI disk
> Nov 29 15:15:38 hotplug systemd[1]: systemd-fsckd.service: Deactivated successfully.


