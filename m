Return-Path: <linux-pci+bounces-20680-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEA1DA26BE2
	for <lists+linux-pci@lfdr.de>; Tue,  4 Feb 2025 07:09:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7AE8F165BED
	for <lists+linux-pci@lfdr.de>; Tue,  4 Feb 2025 06:09:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED96D13AA38;
	Tue,  4 Feb 2025 06:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="KcjTDZB1"
X-Original-To: linux-pci@vger.kernel.org
Received: from out199-2.us.a.mail.aliyun.com (out199-2.us.a.mail.aliyun.com [47.90.199.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7AAD25A626;
	Tue,  4 Feb 2025 06:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.199.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738649353; cv=none; b=NYuchFqgvBXnjanIiYLJe6N6gpJclmnJiu6iyWr1eFw4cCSqoh84yAqqXBZ7HMU05RIEkEGsnGdl7lQGQ4PZAwq7Z4g2KwPhW1aWIOmX/edP8aNngTqdi+ajo3XtctBtNCRTDOltnQrVEmReCAQ3dM/BaMWXDrTR8MNxVoAORxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738649353; c=relaxed/simple;
	bh=V7odFs4tcKIWLBm/ALEmvYBCpIMoMGf+iuY56dgvY2E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nvlke+U8PlrJIELuX8HOKZjCw2vtJ5jEnWRcwJ23F7VI9/f1XYCySVyO5fPRcxuFx0OXRNmO57H7hX6dHL4PPQJC/hupYBB7LplREaEnoWBYSio054NmXRFjT41PLeBrmjvtL7sZKOc0SQBO8/nzB58CAgK8SgNxwJIreniLH+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=KcjTDZB1; arc=none smtp.client-ip=47.90.199.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1738649337; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=bSrmfWIDiCB2JPQM4jHmdym0boCxfT1KwmWYr/hPKro=;
	b=KcjTDZB1zFv39Qa/WRGqMPaF72mgaFN5GcElWQD9IDfq9NZuXROlHjqFj7h49DgicLCTX2Ez2ivuXXLUgOrtqywTfbIOaOhGK9labSpfxzvDndOtTlXioHdo7q/OKE/lU/pN2PB/rLvfBLVqd+t/bVGJHdNrz8giFcFi0kiHtdE=
Received: from localhost(mailfrom:feng.tang@linux.alibaba.com fp:SMTPD_---0WOjUGtb_1738647478 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 04 Feb 2025 13:37:59 +0800
From: Feng Tang <feng.tang@linux.alibaba.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Jonathan Cameron <Jonthan.Cameron@huawei.com>,
	ilpo.jarvinen@linux.intel.com,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Feng Tang <feng.tang@linux.alibaba.com>
Subject: [PATCH 1/2] PCI/portdrv: Add necessary delay for disabling hotplug events
Date: Tue,  4 Feb 2025 13:37:57 +0800
Message-Id: <20250204053758.6025-1-feng.tang@linux.alibaba.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

According to PCIe 6.1 spec, section 6.7.3.2, software need to wait at
least 1 second for the command-complete event, before resending the cmd
or sending a new cmd.

Currently get_port_device_capability() sends slot control cmd to disable
PCIe hotplug interrupts without waiting for its completion and there was
real problem reported for the lack of waiting.

Add the necessary wait to comply with PCIe spec. The waiting logic refers
existing pcie_poll_cmd().

Signed-off-by: Feng Tang <feng.tang@linux.alibaba.com>
---
 drivers/pci/pci.h          |  2 ++
 drivers/pci/pcie/portdrv.c | 33 +++++++++++++++++++++++++++++++--
 2 files changed, 33 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 01e51db8d285..c1e234d1b81d 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -759,12 +759,14 @@ static inline void pcie_ecrc_get_policy(char *str) { }
 #ifdef CONFIG_PCIEPORTBUS
 void pcie_reset_lbms_count(struct pci_dev *port);
 int pcie_lbms_count(struct pci_dev *port, unsigned long *val);
+void pcie_disable_hp_interrupts_early(struct pci_dev *dev);
 #else
 static inline void pcie_reset_lbms_count(struct pci_dev *port) {}
 static inline int pcie_lbms_count(struct pci_dev *port, unsigned long *val)
 {
 	return -EOPNOTSUPP;
 }
+static inline void pcie_disable_hp_interrupts_early(struct pci_dev *dev) {}
 #endif
 
 struct pci_dev_reset_methods {
diff --git a/drivers/pci/pcie/portdrv.c b/drivers/pci/pcie/portdrv.c
index 02e73099bad0..16010973bfe2 100644
--- a/drivers/pci/pcie/portdrv.c
+++ b/drivers/pci/pcie/portdrv.c
@@ -18,6 +18,7 @@
 #include <linux/string.h>
 #include <linux/slab.h>
 #include <linux/aer.h>
+#include <linux/delay.h>
 
 #include "../pci.h"
 #include "portdrv.h"
@@ -205,6 +206,35 @@ static int pcie_init_service_irqs(struct pci_dev *dev, int *irqs, int mask)
 	return 0;
 }
 
+static int pcie_wait_sltctl_cmd_raw(struct pci_dev *pdev)
+{
+	u16 slot_status;
+	/* 1000 ms, according toPCIe spec 6.1, section 6.7.3.2 */
+	int timeout = 1000;
+
+	do {
+		pcie_capability_read_word(pdev, PCI_EXP_SLTSTA, &slot_status);
+		if (slot_status & PCI_EXP_SLTSTA_CC) {
+			pcie_capability_write_word(pdev, PCI_EXP_SLTSTA,
+						   PCI_EXP_SLTSTA_CC);
+			return 0;
+		}
+		msleep(10);
+		timeout -= 10;
+	} while (timeout);
+
+	/* Timeout */
+	return  -1;
+}
+
+void pcie_disable_hp_interrupts_early(struct pci_dev *dev)
+{
+	pcie_capability_clear_word(dev, PCI_EXP_SLTCTL,
+		  PCI_EXP_SLTCTL_CCIE | PCI_EXP_SLTCTL_HPIE);
+	if (pcie_wait_sltctl_cmd_raw(dev))
+		pci_info(dev, "Timeout on disabling hot-plug interrupts\n");
+}
+
 /**
  * get_port_device_capability - discover capabilities of a PCI Express port
  * @dev: PCI Express port to examine
@@ -230,8 +260,7 @@ static int get_port_device_capability(struct pci_dev *dev)
 		 * Disable hot-plug interrupts in case they have been enabled
 		 * by the BIOS and the hot-plug service driver is not loaded.
 		 */
-		pcie_capability_clear_word(dev, PCI_EXP_SLTCTL,
-			  PCI_EXP_SLTCTL_CCIE | PCI_EXP_SLTCTL_HPIE);
+		pcie_disable_hp_interrupts_early(dev);
 	}
 
 #ifdef CONFIG_PCIEAER
-- 
2.43.5


