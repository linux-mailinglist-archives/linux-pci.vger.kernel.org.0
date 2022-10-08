Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C5715F8281
	for <lists+linux-pci@lfdr.de>; Sat,  8 Oct 2022 04:43:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbiJHCnp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 7 Oct 2022 22:43:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbiJHCnl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 7 Oct 2022 22:43:41 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 753669082D;
        Fri,  7 Oct 2022 19:43:33 -0700 (PDT)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MkqCs1Z0RzpVXp;
        Sat,  8 Oct 2022 10:40:25 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 8 Oct 2022 10:43:31 +0800
Received: from huawei.com (10.175.104.170) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Sat, 8 Oct
 2022 10:43:31 +0800
From:   Zhuang Shengen <zhuangshengen@huawei.com>
To:     <bhelgaas@google.com>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <arei.gonglei@huawei.com>, <jianjay.zhou@huawei.com>
Subject: [PATCH] iov: support enable pci sriov concurrently
Date:   Sat, 8 Oct 2022 10:42:11 +0800
Message-ID: <20221008024211.1582521-1-zhuangshengen@huawei.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.175.104.170]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Enable SRIOV concurrently with many different PFs in userspace
will get warnings below:
Warning 1:
sysfs: cannot create duplicate filename
'/devices/pci0000:30/0000:30:02.0/pci_bus/0000:32'
Call Trace:
 dump_stack+0x6f/0xab
 sysfs_warn_dup+0x56/0x70
 sysfs_create_dir_ns+0x80/0x90
 kobject_add_internal+0xa0/0x2b0
 kobject_add+0x71/0xd0
 device_add+0x126/0x630
 pci_add_new_bus+0x17c/0x4b0
 pci_iov_add_virtfn+0x336/0x390
 sriov_enable+0x26e/0x450
 virtio_pci_sriov_configure+0x61/0xc0 [virtio_pci]
Warning 2:
proc_dir_entry 'pci/33' already registered
WARNING: CPU: 71 PID: 893 at fs/proc/generic.c:360
proc_register+0xf8/0x130
Call Trace:
 proc_mkdir_data+0x5d/0x80
 pci_proc_attach_device+0xe9/0x120
 pci_bus_add_device+0x33/0x90
 pci_iov_add_virtfn+0x375/0x390
 sriov_enable+0x26e/0x450
 virtio_pci_sriov_configure+0x61/0xc0 [virtio_pci]

The reason is:
1）different VFs may create the same pci bus number and try to add new bus
concurrently in virtfn_add_bus.
2）different VFs may create '/proc/bus/pci/bus_number' directory using the
same bus number in pci_proc_attach_device concurrently.

Add new lock when creating new bus, hold device_lock when creating
'/proc/bus/pci/bus_number' directory in pci_proc_attach_device to fix them

Signed-off-by: Zhuang Shengen <zhuangshengen@huawei.com>
Signed-off-by: Jay Zhou <jianjay.zhou@huawei.com>
---
 drivers/pci/iov.c   |  7 ++++++-
 drivers/pci/probe.c | 26 ++++++++++++++++++++++++++
 drivers/pci/proc.c  |  6 +++++-
 include/linux/pci.h |  2 ++
 4 files changed, 39 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
index 952217572113..6d113ea64ba8 100644
--- a/drivers/pci/iov.c
+++ b/drivers/pci/iov.c
@@ -127,11 +127,16 @@ static struct pci_bus *virtfn_add_bus(struct pci_bus *bus, int busnr)
 	if (bus->number == busnr)
 		return bus;
 
+	/*
+	 * vf will find existing bus at most case; if not existing, it should
+	 * go through slow path to create new bus with locked to support enable SRIOV
+	 * concurrently with different PFs in userspace.
+	 */
 	child = pci_find_bus(pci_domain_nr(bus), busnr);
 	if (child)
 		return child;
 
-	child = pci_add_new_bus(bus, NULL, busnr);
+	child = pci_add_new_bus_locked(bus, NULL, busnr);
 	if (!child)
 		return NULL;
 
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index c5286b027f00..bfbd47a3ba73 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -25,6 +25,8 @@
 #define CARDBUS_LATENCY_TIMER	176	/* secondary latency timer */
 #define CARDBUS_RESERVE_BUSNR	3
 
+DEFINE_MUTEX(add_bus_mutex);
+
 static struct resource busn_resource = {
 	.name	= "PCI busn",
 	.start	= 0,
@@ -1170,6 +1172,30 @@ struct pci_bus *pci_add_new_bus(struct pci_bus *parent, struct pci_dev *dev,
 }
 EXPORT_SYMBOL(pci_add_new_bus);
 
+struct pci_bus *pci_add_new_bus_locked(struct pci_bus *parent, struct pci_dev *dev,
+				       int busnr)
+{
+	struct pci_bus *child;
+
+	mutex_lock(&add_bus_mutex);
+	child = pci_find_bus(pci_domain_nr(parent), busnr);
+	if (child) {
+		mutex_unlock(&add_bus_mutex);
+		return child;
+	}
+
+	child = pci_alloc_child_bus(parent, dev, busnr);
+	if (child) {
+		down_write(&pci_bus_sem);
+		list_add_tail(&child->node, &parent->children);
+		up_write(&pci_bus_sem);
+	}
+	mutex_unlock(&add_bus_mutex);
+
+	return child;
+}
+EXPORT_SYMBOL(pci_add_new_bus_locked);
+
 static void pci_enable_crs(struct pci_dev *pdev)
 {
 	u16 root_cap = 0;
diff --git a/drivers/pci/proc.c b/drivers/pci/proc.c
index f967709082d6..f927263c2fe0 100644
--- a/drivers/pci/proc.c
+++ b/drivers/pci/proc.c
@@ -421,6 +421,7 @@ int pci_proc_attach_device(struct pci_dev *dev)
 	if (!proc_initialized)
 		return -EACCES;
 
+	device_lock(&bus->dev);
 	if (!bus->procdir) {
 		if (pci_proc_domain(bus)) {
 			sprintf(name, "%04x:%02x", pci_domain_nr(bus),
@@ -429,9 +430,12 @@ int pci_proc_attach_device(struct pci_dev *dev)
 			sprintf(name, "%02x", bus->number);
 		}
 		bus->procdir = proc_mkdir(name, proc_bus_pci_dir);
-		if (!bus->procdir)
+		if (!bus->procdir) {
+			device_unlock(&bus->dev);
 			return -ENOMEM;
+		}
 	}
+	device_unlock(&bus->dev);
 
 	sprintf(name, "%02x.%x", PCI_SLOT(dev->devfn), PCI_FUNC(dev->devfn));
 	e = proc_create_data(name, S_IFREG | S_IRUGO | S_IWUSR, bus->procdir,
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 5da0846aa3c1..bfe2a2e74af6 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1112,6 +1112,8 @@ struct pci_bus *pci_scan_root_bus(struct device *parent, int bus,
 int pci_scan_root_bus_bridge(struct pci_host_bridge *bridge);
 struct pci_bus *pci_add_new_bus(struct pci_bus *parent, struct pci_dev *dev,
 				int busnr);
+struct pci_bus *pci_add_new_bus_locked(struct pci_bus *parent, struct pci_dev *dev,
+				       int busnr);
 struct pci_slot *pci_create_slot(struct pci_bus *parent, int slot_nr,
 				 const char *name,
 				 struct hotplug_slot *hotplug);
-- 
2.27.0

