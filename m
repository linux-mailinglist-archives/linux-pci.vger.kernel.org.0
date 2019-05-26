Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4001F2AC9A
	for <lists+linux-pci@lfdr.de>; Mon, 27 May 2019 00:52:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725853AbfEZWwX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 26 May 2019 18:52:23 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38124 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725838AbfEZWwX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 26 May 2019 18:52:23 -0400
Received: by mail-wr1-f65.google.com with SMTP id d18so15014855wrs.5;
        Sun, 26 May 2019 15:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FgpxSisbxXxq+zjeyetBVH9NN8egoJEs0LHOfRBeBEs=;
        b=cJX72w/c1Kd59lFIQ/R4fdKCMM045WXcSeHgA0iRhOHNXpnk1qz7gfeTYpmQ2Oywwb
         Tpcow0pmnkG+eJ7i2xkaI7xinpdIJwzktpdlK9A8AnjKH1eIzbVBlVOlbPGRJfHcmg/k
         dOEPVBnRx4aZC5K+okRnJb7D04vYQ1CQ1VQp786zvq0pAkEtOMk3nGW6Wp6H5m2OflQ2
         8ULYx2fZrwoHMn3gaZJycZVdJX0WIVky2rF2OeSNAHycl3Vaz8p+tF3vCH8a61H1iPIf
         Pq1BBcSaE5Ttri/R5T3CxjG77FraYMyjdgmrT0nh4nBoSKJ0Mtae35baxe7Zx20UePKr
         AzHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FgpxSisbxXxq+zjeyetBVH9NN8egoJEs0LHOfRBeBEs=;
        b=cA5Tpb3zIq0pqDmc/Bf0ANumQXqUKmQoqH8Y8tivyZvfw/whGSFGBDpWKgm9AvBy6T
         GAEcWA1HHC1ll05cDqfWdWt5Ta3HlTmycgi0HvByNP1Fjt0eIn6/X7kVFcCj9PI3IRrB
         Q6FeVIEH6cEw9IymqD8sUwEIocyBe83Sp9Lx9AdGGYcU6H3l8tN8PcisrmNkINlRwD5E
         BZl7gCbvf6qACjW7a23K+Zi2Wowc238+Y9UuUyE+sGPyLHb0vHv21uCmVlalFkqPFYkm
         NZyfnykoMcxDeKJjKJX6qsev/yiPAOHsqZNfNXT+i2dIkIOwbC84qagyGoQyfmzp/YDB
         w/TA==
X-Gm-Message-State: APjAAAUBmuSbtfSwNAp62G9rS/bKREvNPPUqptaW+NV/xCjau9Lt16m+
        zrnTvPUj/iXdS2q108WtpiEoNrBT
X-Google-Smtp-Source: APXvYqxK2PuM4JMsilWOPnGkYX6fV+u3B2AWn8E6y3gvNDIzwKjHVNRS+F38iV6logqc4YQ8rdNFcg==
X-Received: by 2002:adf:fb47:: with SMTP id c7mr21673146wrs.116.1558911140412;
        Sun, 26 May 2019 15:52:20 -0700 (PDT)
Received: from kurokawa.lan (ip-86-49-110-70.net.upcbroadband.cz. [86.49.110.70])
        by smtp.gmail.com with ESMTPSA id f197sm9150931wme.39.2019.05.26.15.52.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 26 May 2019 15:52:19 -0700 (PDT)
From:   marek.vasut@gmail.com
To:     linux-pci@vger.kernel.org
Cc:     Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Simon Horman <horms+renesas@verge.net.au>,
        Tejun Heo <tj@kernel.org>, Wolfram Sang <wsa@the-dreams.de>,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH] [RFC] PCI: sysfs: Ignore lockdep for remove attribute
Date:   Mon, 27 May 2019 00:51:51 +0200
Message-Id: <20190526225151.3865-1-marek.vasut@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Marek Vasut <marek.vasut+renesas@gmail.com>

On ARM64 R-Car Gen3 R8A7795 system with Intel NVMe SSD inserted into the
PCIe slot, with CONFIG_PROVE_LOCKING=y enabled in the kernel config, the
following lockdep warning can be triggered:

  $ lspci
  01:00.0 Class 0108: 8086:f1a5	# This is the NVMe SSD
  00:00.0 Class 0604: 1912:0025	# This is the PCIe root port

  $ echo 1 > /sys/class/pci_bus/0000\:00/device/0000\:00\:00.0/remove
  nvme nvme0: failed to set APST feature (-19)

  ============================================
  WARNING: possible recursive locking detected
  5.2.0-rc1-next-20190524-00018-gd76fa47ee507 #57 Not tainted
  --------------------------------------------
  sh/1616 is trying to acquire lock:
  (____ptrval____) (kn->count#21){++++}, at: kernfs_remove_by_name_ns+0x4c/0x98

  but task is already holding lock:
  (____ptrval____) (kn->count#21){++++}, at: kernfs_remove_self+0xec/0x150

  other info that might help us debug this:
   Possible unsafe locking scenario:

         CPU0
         ----
    lock(kn->count#21);
    lock(kn->count#21);

   *** DEADLOCK ***

   May be due to missing lock nesting notation

  4 locks held by sh/1616:
   #0: (____ptrval____) (sb_writers#4){.+.+}, at: vfs_write+0x190/0x1b0
   #1: (____ptrval____) (&of->mutex){+.+.}, at: kernfs_fop_write+0xb4/0x1f0
   #2: (____ptrval____) (kn->count#21){++++}, at: kernfs_remove_self+0xec/0x150
   #3: (____ptrval____) (pci_rescan_remove_lock){+.+.}, at: pci_lock_rescan_remove+0x1c/0x28

  stack backtrace:
  CPU: 0 PID: 1616 Comm: sh Not tainted 5.2.0-rc1-next-20190524-00018-gd76fa47ee507 #57
  Hardware name: Renesas Salvator-X 2nd version board based on r8a7795 ES2.0+ (DT)
  Call trace:
   dump_backtrace+0x0/0x130
   show_stack+0x14/0x20
   dump_stack+0xd4/0x11c
   __lock_acquire+0x1df8/0x1e58
   lock_acquire+0xdc/0x258
   __kernfs_remove+0x290/0x2f8
   kernfs_remove_by_name_ns+0x4c/0x98
   remove_files.isra.0+0x38/0x78
   sysfs_remove_group+0x4c/0xa0
   sysfs_remove_groups+0x34/0x50
   device_remove_attrs+0x50/0x70
   device_del+0x13c/0x350
   pci_remove_bus_device+0x78/0x100
   pci_remove_bus_device+0x34/0x100
   pci_stop_and_remove_bus_device_locked+0x24/0x38
   remove_store+0x88/0x98
   dev_attr_store+0x14/0x28
   sysfs_kf_write+0x48/0x70
   kernfs_fop_write+0xe4/0x1f0
   __vfs_write+0x18/0x40
   vfs_write+0xa4/0x1b0
   ksys_write+0x64/0xe8
   __arm64_sys_write+0x18/0x20
   el0_svc_common.constprop.0+0x90/0x168
   el0_svc_compat_handler+0x18/0x20
   el0_svc_compat+0x8/0x10
  pci_bus 0000:01: busn_res: [bus 01] is released

The crash is not isolated to NVMe SSDs, but pretty much any other PCIe
device will trigger it as well ; empty slot will not. The NVMe SSD was
just available for this particular test, Intel e1000 or IGB ethernet
triggers the same.

The lockdep complains about trying to acquire the same lock from the
same process again, however that is not true. What really happens is
that every "remove" sysfs attribute of a PCI device has the same
lockdep key, which then confuses lockdep and triggers this warning
on two unrelated locks.

The echo 1 > /sys/class/pci_bus/0000:00/device/0000:00:00.0/remove
triggers drivers/pci/pci-sysfs.c remove_store(), which first calls
device_remove_file_self() on /sys/class/pci_bus/0000:00/device/0000:00:00.0/remove
file. This requires calling kernfs_break_active_protection(), since
kernfs_fop_open() holds a rwsem lock on the file, using
rwsem_acquire_read(&kn->dep_map, 0, 1, _RET_IP_); in kernfs_get_active(),
and the kernfs_break_active_protection() releases the lock, allowing the
file to be safely removed. The lock is reinstated by calling
kernfs_unbreak_active_protection() after the removal. This rwsem
operation has a small side-effect in that it registers a lockdep class
with the kernfs/sysfs attribute key and this is now in lockdep cache.

The remove_store() continues by calling pci_stop_and_remove_bus_device_locked(),
which calls pci_stop_and_remove_bus_device(), pci_remove_bus_device(),
device_del() on the subdevices. The interesting one is PCI device 00:01.0
and specifically it's "remove" attribute again, on which the code calls
kernfs_remove_by_name_ns(), which calls __kernfs_remove() and then
kernfs_drain(), which finally requests a rwsem lock using
rwsem_acquire(&kn->dep_map, 0, 0, _RET_IP_); . This is where the
lockdep generates the backtrace as seen at the beginning.

The kernfs_node "kn" in each of the previous paragraphs is different
kernfs node, however the lockdep key for kn->dep_map is the same.
This is because when the "remove" sysfs attibute is created in
__kernfs_create_file(), the "key" passed in is the same.

The "key" is assigned to the attribute via drivers/pci/probe.c:pci_device_add(),
which calls device_add(&dev->dev) defined in drivers/base/core.c. The device_add()
calls device_add_attrs(), device_add_groups(), sysfs_create_groups(),
fs/sysfs/group.c:sysfs_create_group(), internal_create_group() and
create_files(). The create_files() iterates over all attribute tables
associted with "dev" device and calls sysfs_add_file_mode_ns() from
fs/sysfs/file.c, which ends up calling __kernfs_create_file() with
key = attr->key ?: (struct lock_class_key *)&attr->skey; .

The attribute list gets assigned to the "dev" device in pci_alloc_dev()
and points to const struct device_type pci_dev_type in
drivers/pci/pci-sysfs.c , which contains the attribute groups and then
arrays of sysfs attributes. Since these arrays are static and constant,
each and every newly allocated PCI device triggers creation of kernfs
objects with the same attribute pointer and thus the same attribute key
pointer, and thus the same lockdep key.

This patch marks the "remove" sysfs attribute with __ATTR_IGNORE_LOCKDEP()
as it is safe to ignore the lockdep check between different "remove"
kernfs instances. However, the better solution might be to allocate
new attribute key for every newly allocated PCI device.

Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
From: Marek Vasut <marek.vasut+renesas@gmail.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Phil Edworthy <phil.edworthy@renesas.com>
Cc: Simon Horman <horms+renesas@verge.net.au>
Cc: Tejun Heo <tj@kernel.org>
Cc: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-renesas-soc@vger.kernel.org
To: linux-pci@vger.kernel.org
---
NOTE: The "rescan" attribute has similar issues
NOTE: This is a different take on https://patchwork.kernel.org/patch/10669333/
---
 drivers/pci/pci-sysfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 6d27475e39b2..4e83c347de5d 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -477,7 +477,7 @@ static ssize_t remove_store(struct device *dev, struct device_attribute *attr,
 		pci_stop_and_remove_bus_device_locked(to_pci_dev(dev));
 	return count;
 }
-static struct device_attribute dev_remove_attr = __ATTR(remove,
+static struct device_attribute dev_remove_attr = __ATTR_IGNORE_LOCKDEP(remove,
 							(S_IWUSR|S_IWGRP),
 							NULL, remove_store);
 
-- 
2.20.1

