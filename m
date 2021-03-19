Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3D963418BE
	for <lists+linux-pci@lfdr.de>; Fri, 19 Mar 2021 10:49:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229512AbhCSJtK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 19 Mar 2021 05:49:10 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:13644 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbhCSJtH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 19 Mar 2021 05:49:07 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4F1zYq3nFYzmZb5;
        Fri, 19 Mar 2021 17:46:39 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.498.0; Fri, 19 Mar 2021 17:48:56 +0800
From:   Yicong Yang <yangyicong@hisilicon.com>
To:     <helgaas@kernel.org>, <linux-pci@vger.kernel.org>
CC:     <mika.westerberg@linux.intel.com>, <rafael.j.wysocki@intel.com>,
        <peter@lekensteyn.nl>, <kw@linux.com>, <prime.zeng@huawei.com>,
        <linuxarm@huawei.com>, <yangyicong@hisilicon.com>
Subject: [PATCH v3] PCI: Make sure the bus bridge powered on when scanning bus
Date:   Fri, 19 Mar 2021 17:46:33 +0800
Message-ID: <1616147193-13186-1-git-send-email-yangyicong@hisilicon.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

When the bus bridge is runtime suspended, we'll fail to rescan
the devices through sysfs as we cannot access the configuration
space correctly when the bridge is in D3hot.
It can be reproduced like:

$ echo 1 > /sys/bus/pci/devices/0000:80:00.0/0000:81:00.1/remove
$ echo 1 > /sys/bus/pci/devices/0000:80:00.0/pci_bus/0000:81/rescan

0000:80:00.0 is root port and is runtime suspended and we cannot
get 0000:81:00.1 after rescan.

Make bridge powered on when scanning the child bus, by adding
pm_runtime_get_sync()/pm_runtime_put() in pci_scan_child_bus_extend().

A similar issue is met and solved by
d963f6512e15 ("PCI: Power on bridges before scanning new devices")
which rescan the devices through /sys/bus/pci/devices/0000:80:00.0/rescan.
The callstack is like:

dev_rescan_restore()
  pci_rescan_bus()
    pci_scan_bridge_extend()
      pci_scan_child_bus_extend() /* will wake up the bridge with this patch */

With this patch the issue is also resolved, so let's remove the calls of
pm_runtime_*() in pci_scan_bridge_extend().

Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
---
Change since v2:
- rebase on v5.12-rc3
Link: https://lore.kernel.org/linux-pci/1601029386-4928-1-git-send-email-yangyicong@hisilicon.com/

Change since v1:
address the comments from Bjorn:
- use an intermediate variable *bridge as suggested
- remove the pm_runtime_*() calls in pci_scan_bridge_extend()
Link: https://lore.kernel.org/linux-pci/1596022223-4765-1-git-send-email-yangyicong@hisilicon.com/

 drivers/pci/probe.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 953f15a..6ad3c48 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1224,12 +1224,6 @@ static int pci_scan_bridge_extend(struct pci_bus *bus, struct pci_dev *dev,
 	u8 fixed_sec, fixed_sub;
 	int next_busnr;
 
-	/*
-	 * Make sure the bridge is powered on to be able to access config
-	 * space of devices below it.
-	 */
-	pm_runtime_get_sync(&dev->dev);
-
 	pci_read_config_dword(dev, PCI_PRIMARY_BUS, &buses);
 	primary = buses & 0xFF;
 	secondary = (buses >> 8) & 0xFF;
@@ -1431,8 +1425,6 @@ static int pci_scan_bridge_extend(struct pci_bus *bus, struct pci_dev *dev,
 out:
 	pci_write_config_word(dev, PCI_BRIDGE_CONTROL, bctl);
 
-	pm_runtime_put(&dev->dev);
-
 	return max;
 }
 
@@ -2797,11 +2789,19 @@ static unsigned int pci_scan_child_bus_extend(struct pci_bus *bus,
 	unsigned int used_buses, normal_bridges = 0, hotplug_bridges = 0;
 	unsigned int start = bus->busn_res.start;
 	unsigned int devfn, fn, cmax, max = start;
-	struct pci_dev *dev;
+	struct pci_dev *dev, *bridge = bus->self;
 	int nr_devs;
 
 	dev_dbg(&bus->dev, "scanning bus\n");
 
+	/*
+	 * Make sure the bus bridge is powered on, otherwise we may not be
+	 * able to scan the devices as we may fail to access the configuration
+	 * space of subordinates.
+	 */
+	if (bridge)
+		pm_runtime_get_sync(&bridge->dev);
+
 	/* Go find them, Rover! */
 	for (devfn = 0; devfn < 256; devfn += 8) {
 		nr_devs = pci_scan_slot(bus, devfn);
@@ -2914,6 +2914,9 @@ static unsigned int pci_scan_child_bus_extend(struct pci_bus *bus,
 		}
 	}
 
+	if (bridge)
+		pm_runtime_put(&bridge->dev);
+
 	/*
 	 * We've scanned the bus and so we know all about what's on
 	 * the other side of any bridges that may be on this bus plus
-- 
2.8.1

