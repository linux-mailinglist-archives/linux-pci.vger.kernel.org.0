Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 199F14DC21
	for <lists+linux-pci@lfdr.de>; Thu, 20 Jun 2019 22:55:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726166AbfFTUzh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 20 Jun 2019 16:55:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:58884 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726045AbfFTUzh (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 20 Jun 2019 16:55:37 -0400
Received: from localhost (odyssey.drury.edu [64.22.249.253])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6D3FD20652;
        Thu, 20 Jun 2019 20:55:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561064135;
        bh=5Ro000cnDkp0uLZfWQS3yY2PiZRDbVeS3euigXh9Nv0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KgSwesBzWzIbK5HqYQNnuqhvePSVR4MqQzVNoFqdSdKlbh5kqVTnCS3RGpkDvoxIR
         qsPEghOrj70JNh2L+dh03imzN1SxLqFBYaExpVtHD/cmOHBikdzZfVZgbCBrUgJHu2
         7pmOnMLwelVPV3S9cxlDmsOjGW1gW5H0dcqdgEyc=
Date:   Thu, 20 Jun 2019 15:55:34 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     marek.vasut@gmail.com
Cc:     linux-pci@vger.kernel.org,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Simon Horman <horms+renesas@verge.net.au>,
        Tejun Heo <tj@kernel.org>, Wolfram Sang <wsa@the-dreams.de>,
        linux-renesas-soc@vger.kernel.org,
        Alan Stern <stern@rowland.harvard.edu>,
        Eric Biederman <ebiederm@xmission.com>,
        Alexander Sverdlin <alexander.sverdlin@nsn.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [RFC] PCI: sysfs: Ignore lockdep for remove attribute
Message-ID: <20190620205534.GC110859@google.com>
References: <20190526225151.3865-1-marek.vasut@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190526225151.3865-1-marek.vasut@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Alan, Eric, Alexander (from previous similar discussions, LKML]

On Mon, May 27, 2019 at 12:51:51AM +0200, marek.vasut@gmail.com wrote:
> From: Marek Vasut <marek.vasut+renesas@gmail.com>
> 
> On ARM64 R-Car Gen3 R8A7795 system with Intel NVMe SSD inserted into the
> PCIe slot, with CONFIG_PROVE_LOCKING=y enabled in the kernel config, the
> following lockdep warning can be triggered:

As you say, this has nothing to do with the specific platform or NVMe.

It took me longer than I want to admit to figure out the qemu
parameters, but I did reproduce this in qemu by making a bridge with a
device below it and then removing the bridge:

  $ /usr/bin/qemu-system-x86_64 -M q35 -nographic \
      -drive file=ubuntu.img,if=none,id=disk \
      -device ide-drive,drive=disk,bus=ide.0 \
      -device ioh3420,id=root_port1 \
      -device nec-usb-xhci,bus=root_port1 \
      -kernel ~/linux/arch/x86/boot/bzImage \
      -append "console=ttyS0,115200n8 root=/dev/sda1"

  root@ubuntu:~# lspci -t
  -[0000:00]-+-00.0
             +-01.0
             +-02.0
             +-03.0-[01]----00.0
             +-1f.0
             +-1f.2
             \-1f.3
  root@ubuntu:~# lspci -vs03.0
  00:03.0 PCI bridge: Intel Corporation 7500/5520/5500/X58 I/O Hub PCI Express Root Port 0 (rev 02) (prog-if 00 [Normal decode])
  root@ubuntu:~# lspci -vs01:00.0
  01:00.0 USB controller: NEC Corporation uPD720200 USB 3.0 Host Controller (rev 03) (prog-if 30 [XHCI])
  root@ubuntu:~# echo 1 > /sys/devices/pci0000:00/0000:00:03.0/remove
  <lockdep splat>

>   $ lspci
>   01:00.0 Class 0108: 8086:f1a5	# This is the NVMe SSD
>   00:00.0 Class 0604: 1912:0025	# This is the PCIe root port
> 
>   $ echo 1 > /sys/class/pci_bus/0000\:00/device/0000\:00\:00.0/remove
>   nvme nvme0: failed to set APST feature (-19)
> 
>   ============================================
>   WARNING: possible recursive locking detected
>   5.2.0-rc1-next-20190524-00018-gd76fa47ee507 #57 Not tainted
>   --------------------------------------------
>   sh/1616 is trying to acquire lock:
>   (____ptrval____) (kn->count#21){++++}, at: kernfs_remove_by_name_ns+0x4c/0x98
> 
>   but task is already holding lock:
>   (____ptrval____) (kn->count#21){++++}, at: kernfs_remove_self+0xec/0x150
> 
>   other info that might help us debug this:
>    Possible unsafe locking scenario:
> 
>          CPU0
>          ----
>     lock(kn->count#21);
>     lock(kn->count#21);
> 
>    *** DEADLOCK ***
> 
>    May be due to missing lock nesting notation
> 
>   4 locks held by sh/1616:
>    #0: (____ptrval____) (sb_writers#4){.+.+}, at: vfs_write+0x190/0x1b0
>    #1: (____ptrval____) (&of->mutex){+.+.}, at: kernfs_fop_write+0xb4/0x1f0
>    #2: (____ptrval____) (kn->count#21){++++}, at: kernfs_remove_self+0xec/0x150
>    #3: (____ptrval____) (pci_rescan_remove_lock){+.+.}, at: pci_lock_rescan_remove+0x1c/0x28
> 
>   stack backtrace:
>   CPU: 0 PID: 1616 Comm: sh Not tainted 5.2.0-rc1-next-20190524-00018-gd76fa47ee507 #57
>   Hardware name: Renesas Salvator-X 2nd version board based on r8a7795 ES2.0+ (DT)
>   Call trace:
>    dump_backtrace+0x0/0x130
>    show_stack+0x14/0x20
>    dump_stack+0xd4/0x11c
>    __lock_acquire+0x1df8/0x1e58
>    lock_acquire+0xdc/0x258
>    __kernfs_remove+0x290/0x2f8
>    kernfs_remove_by_name_ns+0x4c/0x98
>    remove_files.isra.0+0x38/0x78
>    sysfs_remove_group+0x4c/0xa0
>    sysfs_remove_groups+0x34/0x50
>    device_remove_attrs+0x50/0x70
>    device_del+0x13c/0x350
>    pci_remove_bus_device+0x78/0x100
>    pci_remove_bus_device+0x34/0x100
>    pci_stop_and_remove_bus_device_locked+0x24/0x38
>    remove_store+0x88/0x98
>    dev_attr_store+0x14/0x28
>    sysfs_kf_write+0x48/0x70
>    kernfs_fop_write+0xe4/0x1f0
>    __vfs_write+0x18/0x40
>    vfs_write+0xa4/0x1b0
>    ksys_write+0x64/0xe8
>    __arm64_sys_write+0x18/0x20
>    el0_svc_common.constprop.0+0x90/0x168
>    el0_svc_compat_handler+0x18/0x20
>    el0_svc_compat+0x8/0x10
>   pci_bus 0000:01: busn_res: [bus 01] is released
> 
> The crash is not isolated to NVMe SSDs, but pretty much any other PCIe
> device will trigger it as well ; empty slot will not. The NVMe SSD was
> just available for this particular test, Intel e1000 or IGB ethernet
> triggers the same.
> 
> The lockdep complains about trying to acquire the same lock from the
> same process again, however that is not true. What really happens is
> that every "remove" sysfs attribute of a PCI device has the same
> lockdep key, which then confuses lockdep and triggers this warning
> on two unrelated locks.
> 
> The echo 1 > /sys/class/pci_bus/0000:00/device/0000:00:00.0/remove
> triggers drivers/pci/pci-sysfs.c remove_store(), which first calls
> device_remove_file_self() on /sys/class/pci_bus/0000:00/device/0000:00:00.0/remove
> file. This requires calling kernfs_break_active_protection(), since
> kernfs_fop_open() holds a rwsem lock on the file, using
> rwsem_acquire_read(&kn->dep_map, 0, 1, _RET_IP_); in kernfs_get_active(),
> and the kernfs_break_active_protection() releases the lock, allowing the
> file to be safely removed. The lock is reinstated by calling
> kernfs_unbreak_active_protection() after the removal. This rwsem
> operation has a small side-effect in that it registers a lockdep class
> with the kernfs/sysfs attribute key and this is now in lockdep cache.
> 
> The remove_store() continues by calling pci_stop_and_remove_bus_device_locked(),
> which calls pci_stop_and_remove_bus_device(), pci_remove_bus_device(),
> device_del() on the subdevices. The interesting one is PCI device 00:01.0
> and specifically it's "remove" attribute again, on which the code calls
> kernfs_remove_by_name_ns(), which calls __kernfs_remove() and then
> kernfs_drain(), which finally requests a rwsem lock using
> rwsem_acquire(&kn->dep_map, 0, 0, _RET_IP_); . This is where the
> lockdep generates the backtrace as seen at the beginning.
> 
> The kernfs_node "kn" in each of the previous paragraphs is different
> kernfs node, however the lockdep key for kn->dep_map is the same.
> This is because when the "remove" sysfs attibute is created in
> __kernfs_create_file(), the "key" passed in is the same.
> 
> The "key" is assigned to the attribute via drivers/pci/probe.c:pci_device_add(),
> which calls device_add(&dev->dev) defined in drivers/base/core.c. The device_add()
> calls device_add_attrs(), device_add_groups(), sysfs_create_groups(),
> fs/sysfs/group.c:sysfs_create_group(), internal_create_group() and
> create_files(). The create_files() iterates over all attribute tables
> associted with "dev" device and calls sysfs_add_file_mode_ns() from
> fs/sysfs/file.c, which ends up calling __kernfs_create_file() with
> key = attr->key ?: (struct lock_class_key *)&attr->skey; .
> 
> The attribute list gets assigned to the "dev" device in pci_alloc_dev()
> and points to const struct device_type pci_dev_type in
> drivers/pci/pci-sysfs.c , which contains the attribute groups and then
> arrays of sysfs attributes. Since these arrays are static and constant,
> each and every newly allocated PCI device triggers creation of kernfs
> objects with the same attribute pointer and thus the same attribute key
> pointer, and thus the same lockdep key.
> 
> This patch marks the "remove" sysfs attribute with __ATTR_IGNORE_LOCKDEP()
> as it is safe to ignore the lockdep check between different "remove"
> kernfs instances. However, the better solution might be to allocate
> new attribute key for every newly allocated PCI device.
> 
> Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
> From: Marek Vasut <marek.vasut+renesas@gmail.com>
> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: Phil Edworthy <phil.edworthy@renesas.com>
> Cc: Simon Horman <horms+renesas@verge.net.au>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Wolfram Sang <wsa@the-dreams.de>
> Cc: linux-renesas-soc@vger.kernel.org
> To: linux-pci@vger.kernel.org
> ---
> NOTE: The "rescan" attribute has similar issues
> NOTE: This is a different take on https://patchwork.kernel.org/patch/10669333/

I tried to reproduce this "rescan" problem with the above qemu
platform:

  root@ubuntu:~# echo 1 > /sys/class/pci_bus/0000:00/device/0000:00:00.0/remove
  root@ubuntu:~# echo 1 > /sys/class/pci_bus/0000:00/rescan

  root@ubuntu:~# echo 1 > /sys/devices/pci0000:00/0000:00:00.0/remove
  root@ubuntu:~# echo 1 > /sys/devices/pci0000:00/pci_bus/0000:00/rescan

These all worked fine.  I didn't see any recent changes that should
have fixed this, so I don't know whether it was fixed a different
way, or if I'm just not doing the right thing to see it.

> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> index 6d27475e39b2..4e83c347de5d 100644
> --- a/drivers/pci/pci-sysfs.c
> +++ b/drivers/pci/pci-sysfs.c
> @@ -477,7 +477,7 @@ static ssize_t remove_store(struct device *dev, struct device_attribute *attr,
>  		pci_stop_and_remove_bus_device_locked(to_pci_dev(dev));
>  	return count;
>  }
> -static struct device_attribute dev_remove_attr = __ATTR(remove,
> +static struct device_attribute dev_remove_attr = __ATTR_IGNORE_LOCKDEP(remove,
>  							(S_IWUSR|S_IWGRP),
>  							NULL, remove_store);

I think this is the same problem solved for USB by 356c05d58af0
("sysfs: get rid of some lockdep false positives") which used
DEVICE_ATTR_IGNORE_LOCKDEP for the USB "remove" files.

e9b526fe7048 ("i2c: suppress lockdep warning on delete_device") does
the same for the i2c "delete_device" files.

Here's the original discussion about USB that led to the addition of
DEVICE_ATTR_IGNORE_LOCKDEP:
https://lore.kernel.org/r/Pine.LNX.4.44L0.1204251436140.1206-100000@iolanthe.rowland.org

Bottom line, I think this patch is the right fix, and I'll apply it
unless somebody has a better idea.

Bjorn
