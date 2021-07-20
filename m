Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 789333CF9F0
	for <lists+linux-pci@lfdr.de>; Tue, 20 Jul 2021 14:57:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229944AbhGTMQw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 20 Jul 2021 08:16:52 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:12230 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbhGTMQt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 20 Jul 2021 08:16:49 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4GTdrV452mz1CLPX;
        Tue, 20 Jul 2021 20:51:38 +0800 (CST)
Received: from dggpemm500002.china.huawei.com (7.185.36.229) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 20 Jul 2021 20:57:24 +0800
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm500002.china.huawei.com (7.185.36.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 20 Jul 2021 20:57:23 +0800
From:   Xiongfeng Wang <wangxiongfeng2@huawei.com>
To:     <bhelgaas@google.com>, <keith.busch@intel.com>, <lukas@wunner.de>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <wangxiongfeng2@huawei.com>
Subject: [PATCH] PCI/sysfs: Take reference on device to be removed
Date:   Tue, 20 Jul 2021 21:04:00 +0800
Message-ID: <20210720130400.49153-1-wangxiongfeng2@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500002.china.huawei.com (7.185.36.229)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

When I do some aer-inject and sysfs remove stress tests, I got the
following use-after-free Calltrace:

 ==================================================================
 BUG: KASAN: use-after-free in pci_stop_bus_device+0x174/0x178
 Read of size 8 at addr fffffc3e2e402218 by task bash/26311

 CPU: 38 PID: 26311 Comm: bash Tainted: G        W         4.19.105+ #82
 Hardware name: Huawei TaiShan 2280 V2/BC82AMDC, BIOS 2280-V2 CS V5.B161.01 06/10/2021
 Call trace:
  dump_backtrace+0x0/0x360
  show_stack+0x24/0x30
  dump_stack+0x130/0x164
  print_address_description+0x68/0x278
  kasan_report+0x204/0x330
  __asan_report_load8_noabort+0x30/0x40
  pci_stop_bus_device+0x174/0x178
  pci_stop_and_remove_bus_device_locked+0x24/0x40
  remove_store+0x1c8/0x1e0
  dev_attr_store+0x60/0x80
  sysfs_kf_write+0x104/0x170
  kernfs_fop_write+0x23c/0x430
  __vfs_write+0xec/0x4e0
  vfs_write+0x12c/0x3d0
  ksys_write+0xe8/0x208
  __arm64_sys_write+0x70/0xa0
  el0_svc_common+0x10c/0x450
  el0_svc_handler+0x50/0xc0
  el0_svc+0x10/0x14

 Allocated by task 684:
  kasan_kmalloc+0xe0/0x190
  kmem_cache_alloc_trace+0x110/0x240
  pci_alloc_dev+0x4c/0x110
  pci_scan_single_device+0x100/0x218
  pci_scan_slot+0x8c/0x2d8
  pci_scan_child_bus_extend+0x90/0x628
  pci_scan_child_bus+0x24/0x30
  pci_scan_bridge_extend+0x3b8/0xb28
  pci_scan_child_bus_extend+0x350/0x628
  pci_rescan_bus+0x24/0x48
  pcie_do_fatal_recovery+0x390/0x4b0
  handle_error_source+0x124/0x158
  aer_isr+0x5a0/0x800
  process_one_work+0x598/0x1250
  worker_thread+0x384/0xf08
  kthread+0x2a4/0x320
  ret_from_fork+0x10/0x18

 Freed by task 685:
  __kasan_slab_free+0x120/0x228
  kasan_slab_free+0x10/0x18
  kfree+0x88/0x218
  pci_release_dev+0xb4/0xd8
  device_release+0x6c/0x1c0
  kobject_put+0x12c/0x400
  put_device+0x24/0x30
  pci_dev_put+0x24/0x30
  handle_error_source+0x12c/0x158
  aer_isr+0x5a0/0x800
  process_one_work+0x598/0x1250
  worker_thread+0x384/0xf08
  kthread+0x2a4/0x320
  ret_from_fork+0x10/0x18

 The buggy address belongs to the object at fffffc3e2e402200
  which belongs to the cache kmalloc-4096 of size 4096
 The buggy address is located 24 bytes inside of
  4096-byte region [fffffc3e2e402200, fffffc3e2e403200)
 The buggy address belongs to the page:
 page:ffff7ff0f8b90000 count:1 mapcount:0 mapping:ffffdc365f016e00 index:0x0 compound_mapcount: 0
 flags: 0x6ffffe0000008100(slab|head)
 raw: 6ffffe0000008100 ffff7f70d83aae00 0000000300000003 ffffdc365f016e00
 raw: 0000000000000000 0000000080070007 00000001ffffffff 0000000000000000
 page dumped because: kasan: bad access detected

 Memory state around the buggy address:
  fffffc3e2e402100: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
  fffffc3e2e402180: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 >fffffc3e2e402200: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                             ^
  fffffc3e2e402280: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  fffffc3e2e402300: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ==================================================================

It is caused by the following race condition:

	CPU0					CPU1
remove_store()				aer_isr()
 device_remove_file_self()		 handle_error_source()
 pci_stop_and_remove_bus_device_locked	  pcie_do_fatal_recovery()
  (blocked)				   pci_lock_rescan_remove()	#CPU1 acquire the lock
					   pci_stop_and_remove_bus_device()
					   pci_unlock_rescan_remove()   #CPU1 release the lock
  pci_lock_rescan_remove()						#CPU0 acquire the lock
					  pci_dev_put()			#free pci_dev
  pci_stop_and_remove_bus_device()
   pci_stop_bus_device()						#use-after-free
  pci_unlock_rescan_remove()

An AER interrupt is triggered on CPU1. CPU1 starts to process it. A work
'aer_isr()' is scheduled on CPU1. It calling into
pcie_do_fatal_recovery(), and aquire lock 'pci_rescan_remove_lock'.
Before it removes the sysfs corresponding to the error pci device, a
sysfs remove operation is executed on CPU0. CPU0 use
device_remove_file_self() to remove the sysfs directory and wait for the
lock to be released. After CPU1 finish pci_stop_and_remove_bus_device(),
it release the lock and free the 'pci_dev' in pci_dev_put(). CPU0 acquire
the lock and access the 'pci_dev'. Then a use-after-free is triggered.

To fix this issue, we increase the reference count in remove_store()
before remove the device and decrease the reference count in the end.

Signed-off-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
---
 drivers/pci/pci-sysfs.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 5d63df7c1820..2188e0c637fc 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -462,13 +462,17 @@ static struct device_attribute dev_attr_dev_rescan = __ATTR(rescan, 0200, NULL,
 static ssize_t remove_store(struct device *dev, struct device_attribute *attr,
 			    const char *buf, size_t count)
 {
+	struct pci_dev *pdev = to_pci_dev(dev);
 	unsigned long val;
 
 	if (kstrtoul(buf, 0, &val) < 0)
 		return -EINVAL;
 
+	pci_dev_get(pdev);
 	if (val && device_remove_file_self(dev, attr))
-		pci_stop_and_remove_bus_device_locked(to_pci_dev(dev));
+		pci_stop_and_remove_bus_device_locked(pdev);
+	pci_dev_put(pdev);
+
 	return count;
 }
 static DEVICE_ATTR_IGNORE_LOCKDEP(remove, 0220, NULL,
-- 
2.20.1

