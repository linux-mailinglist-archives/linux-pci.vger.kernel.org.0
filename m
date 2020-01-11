Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D0DE1380F0
	for <lists+linux-pci@lfdr.de>; Sat, 11 Jan 2020 11:39:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728996AbgAKKjw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 11 Jan 2020 05:39:52 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:33940 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728861AbgAKKjw (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 11 Jan 2020 05:39:52 -0500
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id C400EEAAEB4F45AE65C4;
        Sat, 11 Jan 2020 18:39:49 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.439.0; Sat, 11 Jan 2020 18:39:41 +0800
From:   Xiongfeng Wang <wangxiongfeng2@huawei.com>
To:     <bhelgaas@google.com>, <lukas@wunner.de>, <keith.busch@intel.com>,
        <andy.shevchenko@gmail.com>, <rafael.j.wysocki@intel.com>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <guohanjun@huawei.com>, <huawei.libin@huawei.com>,
        <lvying6@huawei.com>, <wangxiongfeng2@huawei.com>
Subject: [PATCH] PCI/AER: increments pci bus reference count in aer-inject process
Date:   Sat, 11 Jan 2020 18:34:59 +0800
Message-ID: <1578738899-11408-1-git-send-email-wangxiongfeng2@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

When I test 'aer-inject' with the following procedures:
1. inject a fatal error into a PCI device
2. remove the parent device by sysfs
3. execute command 'rmmod aer-inject'

I came across the following use-after-free.

[  297.581524] ==================================================================
[  297.581543] BUG: KASAN: use-after-free in pci_bus_set_ops+0xb4/0xb8
[  297.581545] Read of size 8 at addr ffff802edbde80e0 by task rmmod/21839

[  297.581552] CPU: 119 PID: 21839 Comm: rmmod Kdump: loaded Not tainted 4.19.36 #1
[  297.581554] Hardware name: Huawei TaiShan 2280 V2/BC82AMDD, BIOS 1.05 09/18/2019
[  297.581556] Call trace:
[  297.581561]  dump_backtrace+0x0/0x360
[  297.581563]  show_stack+0x24/0x30
[  297.581569]  dump_stack+0xd8/0x104
[  297.581576]  print_address_description+0x68/0x278
[  297.581578]  kasan_report+0x204/0x330
[  297.581580]  __asan_report_load8_noabort+0x30/0x40
[  297.581582]  pci_bus_set_ops+0xb4/0xb8
[  297.581591]  aer_inject_exit+0x198/0x334 [aer_inject]
[  297.581595]  __arm64_sys_delete_module+0x310/0x490
[  297.581601]  el0_svc_common+0xfc/0x278
[  297.581603]  el0_svc_handler+0x50/0xc0
[  297.581605]  el0_svc+0x8/0xc

[  297.581608] Allocated by task 1:
[  297.581611]  kasan_kmalloc+0xe0/0x190
[  297.581614]  kmem_cache_alloc_trace+0x104/0x218
[  297.581616]  pci_alloc_bus+0x50/0x2e0
[  297.581618]  pci_add_new_bus+0xa8/0xe08
[  297.581620]  pci_scan_bridge_extend+0x884/0xb28
[  297.581623]  pci_scan_child_bus_extend+0x350/0x628
[  297.581625]  pci_scan_child_bus+0x24/0x30
[  297.581627]  pci_scan_bridge_extend+0x3b8/0xb28
[  297.581629]  pci_scan_child_bus_extend+0x350/0x628
[  297.581631]  pci_scan_child_bus+0x24/0x30
[  297.581635]  acpi_pci_root_create+0x558/0x888
[  297.581640]  pci_acpi_scan_root+0x198/0x330
[  297.581641]  acpi_pci_root_add+0x7bc/0xbb0
[  297.581646]  acpi_bus_attach+0x2f4/0x728
[  297.581647]  acpi_bus_attach+0x1b0/0x728
[  297.581649]  acpi_bus_attach+0x1b0/0x728
[  297.581651]  acpi_bus_scan+0xa0/0x110
[  297.581657]  acpi_scan_init+0x20c/0x500
[  297.581659]  acpi_init+0x54c/0x5d4
[  297.581661]  do_one_initcall+0xbc/0x480
[  297.581665]  kernel_init_freeable+0x5fc/0x6ac
[  297.581670]  kernel_init+0x18/0x128
[  297.581671]  ret_from_fork+0x10/0x18

[  297.581673] Freed by task 19270:
[  297.581675]  __kasan_slab_free+0x120/0x228
[  297.581677]  kasan_slab_free+0x10/0x18
[  297.581678]  kfree+0x80/0x1f8
[  297.581680]  release_pcibus_dev+0x54/0x68
[  297.581686]  device_release+0xd4/0x1c0
[  297.581689]  kobject_put+0x12c/0x400
[  297.581691]  device_unregister+0x30/0xc0
[  297.581693]  pci_remove_bus+0xe8/0x1c0
[  297.581695]  pci_remove_bus_device+0xd0/0x2f0
[  297.581697]  pci_stop_and_remove_bus_device_locked+0x2c/0x40
[  297.581701]  remove_store+0x1b8/0x1d0
[  297.581703]  dev_attr_store+0x60/0x80
[  297.581708]  sysfs_kf_write+0x104/0x170
[  297.581710]  kernfs_fop_write+0x23c/0x430
[  297.581713]  __vfs_write+0xec/0x4e0
[  297.581714]  vfs_write+0x12c/0x3d0
[  297.581715]  ksys_write+0xd0/0x190
[  297.581716]  __arm64_sys_write+0x70/0xa0
[  297.581718]  el0_svc_common+0xfc/0x278
[  297.581720]  el0_svc_handler+0x50/0xc0
[  297.581721]  el0_svc+0x8/0xc

[  297.581724] The buggy address belongs to the object at ffff802edbde8000
                which belongs to the cache kmalloc-2048 of size 2048
[  297.581726] The buggy address is located 224 bytes inside of
                2048-byte region [ffff802edbde8000, ffff802edbde8800)
[  297.581727] The buggy address belongs to the page:
[  297.581730] page:ffff7e00bb6f7a00 count:1 mapcount:0 mapping:ffff8026de810780 index:0x0 compound_mapcount: 0
[  297.591520] flags: 0x2ffffe0000008100(slab|head)
[  297.596121] raw: 2ffffe0000008100 ffff7e00bb6f5008 ffff7e00bb6ff608 ffff8026de810780
[  297.596123] raw: 0000000000000000 00000000000f000f 00000001ffffffff 0000000000000000
[  297.596124] page dumped because: kasan: bad access detected

[  297.596126] Memory state around the buggy address:
[  297.596128]  ffff802edbde7f80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
[  297.596129]  ffff802edbde8000: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[  297.596131] >ffff802edbde8080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[  297.596132]                                                        ^
[  297.596133]  ffff802edbde8100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[  297.596135]  ffff802edbde8180: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[  297.596135] ==================================================================

It is because when we unload the module and restore the member 'pci_ops'
of 'pci_bus', the 'pci_bus' has been freed. This patch increments the
reference count of 'pci_bus' when we modify its member 'pci_ops' and
decrements the reference count after we have restored its member.

This patch export pci_bus_get() and pci_bus_put() again and reverts the
following two commits.
fae6b93b19b4 ("PCI: Unexport pci_bus_get() and pci_bus_put()")
ecd29c1a38af ("PCI: Make pci_bus_get(), pci_bus_put() private")

Signed-off-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
---
 drivers/pci/bus.c             | 2 ++
 drivers/pci/pci.h             | 2 --
 drivers/pci/pcie/aer_inject.c | 8 ++++++++
 include/linux/pci.h           | 2 ++
 4 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
index 8e40b3e..495059d 100644
--- a/drivers/pci/bus.c
+++ b/drivers/pci/bus.c
@@ -417,9 +417,11 @@ struct pci_bus *pci_bus_get(struct pci_bus *bus)
 		get_device(&bus->dev);
 	return bus;
 }
+EXPORT_SYMBOL(pci_bus_get);
 
 void pci_bus_put(struct pci_bus *bus)
 {
 	if (bus)
 		put_device(&bus->dev);
 }
+EXPORT_SYMBOL(pci_bus_put);
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index a0a53bd..cf849b7 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -286,8 +286,6 @@ void __pci_bus_assign_resources(const struct pci_bus *bus,
 
 void pci_reassigndev_resource_alignment(struct pci_dev *dev);
 void pci_disable_bridge_window(struct pci_dev *dev);
-struct pci_bus *pci_bus_get(struct pci_bus *bus);
-void pci_bus_put(struct pci_bus *bus);
 
 /* PCIe link information */
 #define PCIE_SPEED2STR(speed) \
diff --git a/drivers/pci/pcie/aer_inject.c b/drivers/pci/pcie/aer_inject.c
index 6988fe7..0b6b3d0 100644
--- a/drivers/pci/pcie/aer_inject.c
+++ b/drivers/pci/pcie/aer_inject.c
@@ -307,6 +307,13 @@ static int pci_bus_set_aer_ops(struct pci_bus *bus)
 	spin_lock_irqsave(&inject_lock, flags);
 	if (ops == &aer_inj_pci_ops)
 		goto out;
+	/*
+	 * increments the reference count of the pci bus. Otherwise, when we
+	 * restore the 'pci_ops' in 'aer_inject_exit', the 'pci_bus' may have
+	 * been freed.
+	 */
+	pci_bus_get(bus);
+
 	pci_bus_ops_init(bus_ops, bus, ops);
 	list_add(&bus_ops->list, &pci_bus_ops_list);
 	bus_ops = NULL;
@@ -529,6 +536,7 @@ static void __exit aer_inject_exit(void)
 
 	while ((bus_ops = pci_bus_ops_pop())) {
 		pci_bus_set_ops(bus_ops->bus, bus_ops->ops);
+		pci_bus_put(bus_ops->bus);
 		kfree(bus_ops);
 	}
 
diff --git a/include/linux/pci.h b/include/linux/pci.h
index c393dff..adef0da 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1288,6 +1288,8 @@ int pci_add_ext_cap_save_buffer(struct pci_dev *dev,
 void pci_release_selected_regions(struct pci_dev *, int);
 
 /* drivers/pci/bus.c */
+struct pci_bus *pci_bus_get(struct pci_bus *bus);
+void pci_bus_put(struct pci_bus *bus);
 void pci_add_resource(struct list_head *resources, struct resource *res);
 void pci_add_resource_offset(struct list_head *resources, struct resource *res,
 			     resource_size_t offset);
-- 
1.7.12.4

