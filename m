Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE51E48712F
	for <lists+linux-pci@lfdr.de>; Fri,  7 Jan 2022 04:23:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345012AbiAGDXB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 6 Jan 2022 22:23:01 -0500
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:36987 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344897AbiAGDW6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 6 Jan 2022 22:22:58 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R371e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=yaohongbo@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0V18NGIH_1641525769;
Received: from localhost(mailfrom:yaohongbo@linux.alibaba.com fp:SMTPD_---0V18NGIH_1641525769)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 07 Jan 2022 11:22:56 +0800
From:   Yao Hongbo <yaohongbo@linux.alibaba.com>
To:     bhelgaas@google.com, lukas@wunner.de
Cc:     yaohongbo@linux.alibaba.com, zhangliguang@linux.alibaba.com,
        alikernel-developer@linux.alibaba.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2] PCI: Waiting command completed in get_port_device_capability()
Date:   Fri,  7 Jan 2022 11:22:49 +0800
Message-Id: <1641525769-113099-1-git-send-email-yaohongbo@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

According to the PCIe specification Revision 5.0, section
7.5.3.11 (slot Status Register), if Command Complete notification
is supported,  a write to the slot control register needs to set
the command completed bit, which can indicate the controller is
ready to receive the next command.

However, before probing the pcie hotplug service, there needs to set
HPIE bit in the slot ctrl register to disable hotplug interrupts,
and there is no wait currently.

The interval between the two functions get_port_device_capability() and
pcie_disable_notification() is not long, which may cause the latter to
be interfered by the former.

The command complete event received by pcie_disable_notification() may
belong to the operation of get_port_device_capability().

Signed-off-by: Liguang Zhang <zhangliguang@linux.alibaba.com>
Signed-off-by: Yao Hongbo <yaohongbo@linux.alibaba.com>
---
 drivers/pci/pcie/portdrv_core.c | 40 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 38 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pcie/portdrv_core.c b/drivers/pci/pcie/portdrv_core.c
index bda6308..ec2088b6e 100644
--- a/drivers/pci/pcie/portdrv_core.c
+++ b/drivers/pci/pcie/portdrv_core.c
@@ -15,6 +15,7 @@
 #include <linux/string.h>
 #include <linux/slab.h>
 #include <linux/aer.h>
+#include <linux/delay.h>
 
 #include "../pci.h"
 #include "portdrv.h"
@@ -190,6 +191,42 @@ static int pcie_init_service_irqs(struct pci_dev *dev, int *irqs, int mask)
 	return 0;
 }
 
+static void pcie_port_disable_hp_interrupt(struct pci_dev *dev)
+{
+	u16 slot_status;
+	u32 slot_cap;
+	int timeout = 1000;
+
+	pcie_capability_clear_word(dev, PCI_EXP_SLTCTL,
+			PCI_EXP_SLTCTL_CCIE | PCI_EXP_SLTCTL_HPIE);
+
+	/*
+	 * If the command completed notification is not supported,
+	 * we don't need to wait after writing to the slot ctrl register.
+	 */
+	pcie_capability_read_dword(dev, PCI_EXP_SLTCAP, &slot_cap);
+	if (slot_cap & PCI_EXP_SLTCAP_NCCS)
+		return;
+
+	do {
+		pcie_capability_read_word(dev, PCI_EXP_SLTSTA, &slot_status);
+		if (slot_status == (u16) ~0) {
+			pci_info(dev, "%s: no response from device\n",  __func__);
+			return;
+		}
+
+		if (slot_status & PCI_EXP_SLTSTA_CC) {
+			pcie_capability_write_word(dev, PCI_EXP_SLTSTA, PCI_EXP_SLTSTA_CC);
+			return;
+		}
+
+		msleep(10);
+		timeout -= 10;
+	} while (timeout >= 0);
+
+	pci_info(dev, "Timeout on hotplug disable interrupt!\n");
+}
+
 /**
  * get_port_device_capability - discover capabilities of a PCI Express port
  * @dev: PCI Express port to examine
@@ -213,8 +250,7 @@ static int get_port_device_capability(struct pci_dev *dev)
 		 * Disable hot-plug interrupts in case they have been enabled
 		 * by the BIOS and the hot-plug service driver is not loaded.
 		 */
-		pcie_capability_clear_word(dev, PCI_EXP_SLTCTL,
-			  PCI_EXP_SLTCTL_CCIE | PCI_EXP_SLTCTL_HPIE);
+		pcie_port_disable_hp_interrupt(dev);
 	}
 
 #ifdef CONFIG_PCIEAER
-- 
1.8.3.1

