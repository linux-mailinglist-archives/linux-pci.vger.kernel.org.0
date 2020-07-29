Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AADBA231D5E
	for <lists+linux-pci@lfdr.de>; Wed, 29 Jul 2020 13:31:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726476AbgG2LbU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 29 Jul 2020 07:31:20 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:8851 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726341AbgG2LbU (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 29 Jul 2020 07:31:20 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 44B26FCF2A7506186F00;
        Wed, 29 Jul 2020 19:31:17 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.487.0; Wed, 29 Jul 2020 19:31:08 +0800
From:   Yicong Yang <yangyicong@hisilicon.com>
To:     <bhelgaas@google.com>, <linux-pci@vger.kernel.org>
CC:     <linuxarm@huawei.com>, <yangyicong@hisilicon.com>
Subject: [PATCH] PCI: Make sure the bus bridge powered on when scanning bus
Date:   Wed, 29 Jul 2020 19:30:23 +0800
Message-ID: <1596022223-4765-1-git-send-email-yangyicong@hisilicon.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
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

Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
---
 drivers/pci/probe.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 2f66988..5bb502b 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2795,6 +2795,14 @@ static unsigned int pci_scan_child_bus_extend(struct pci_bus *bus,
 
 	dev_dbg(&bus->dev, "scanning bus\n");
 
+	/*
+	 * Make sure the bus bridge is powered on, otherwise we may not be
+	 * able to scan the devices as we may fail to access the configuration
+	 * space of subordinates.
+	 */
+	if (bus->self)
+		pm_runtime_get_sync(&bus->self->dev);
+
 	/* Go find them, Rover! */
 	for (devfn = 0; devfn < 256; devfn += 8) {
 		nr_devs = pci_scan_slot(bus, devfn);
@@ -2907,6 +2915,9 @@ static unsigned int pci_scan_child_bus_extend(struct pci_bus *bus,
 		}
 	}
 
+	if (bus->self)
+		pm_runtime_put(&bus->self->dev);
+
 	/*
 	 * We've scanned the bus and so we know all about what's on
 	 * the other side of any bridges that may be on this bus plus
-- 
2.8.1

