Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 08F4013BC03
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2020 10:08:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729369AbgAOJI1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 15 Jan 2020 04:08:27 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:9617 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729347AbgAOJI1 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 15 Jan 2020 04:08:27 -0500
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 61D85A9A36A0BB6245FE;
        Wed, 15 Jan 2020 17:08:19 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.439.0; Wed, 15 Jan 2020 17:08:10 +0800
From:   Yicong Yang <yangyicong@hisilicon.com>
To:     <helgaas@kernel.org>, <linux-pci@vger.kernel.org>
CC:     <f.fangjian@huawei.com>
Subject: [PATCH 5/6] PCI: Add PCIE_LNKCAP2_SLS2SPEED macro
Date:   Wed, 15 Jan 2020 17:04:22 +0800
Message-ID: <1579079063-5668-6-git-send-email-yangyicong@hisilicon.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1579079063-5668-1-git-send-email-yangyicong@hisilicon.com>
References: <1579079063-5668-1-git-send-email-yangyicong@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add PCIE_LNKCAP2_SLS2SPEED macro for transforming raw link cap 2
value to link speed. Use it in pcie_get_speed_cap() to reduce
redundancy. We'll not touch the functions when new link
speed comes.

Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
---
 drivers/pci/pci.c | 17 ++++-------------
 drivers/pci/pci.h |  9 +++++++++
 2 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index dce32ce..2ef4030 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5780,19 +5780,10 @@ enum pci_bus_speed pcie_get_speed_cap(struct pci_dev *dev)
 	 * where only 2.5 GT/s and 5.0 GT/s speeds were defined.
 	 */
 	pcie_capability_read_dword(dev, PCI_EXP_LNKCAP2, &lnkcap2);
-	if (lnkcap2) { /* PCIe r3.0-compliant */
-		if (lnkcap2 & PCI_EXP_LNKCAP2_SLS_32_0GB)
-			return PCIE_SPEED_32_0GT;
-		else if (lnkcap2 & PCI_EXP_LNKCAP2_SLS_16_0GB)
-			return PCIE_SPEED_16_0GT;
-		else if (lnkcap2 & PCI_EXP_LNKCAP2_SLS_8_0GB)
-			return PCIE_SPEED_8_0GT;
-		else if (lnkcap2 & PCI_EXP_LNKCAP2_SLS_5_0GB)
-			return PCIE_SPEED_5_0GT;
-		else if (lnkcap2 & PCI_EXP_LNKCAP2_SLS_2_5GB)
-			return PCIE_SPEED_2_5GT;
-		return PCI_SPEED_UNKNOWN;
-	}
+
+	/* PCIe r3.0-compliant */
+	if (lnkcap2)
+		return PCIE_LNKCAP2_SLS2SPEED(lnkcap2);
 
 	pcie_capability_read_dword(dev, PCI_EXP_LNKCAP, &lnkcap);
 	if ((lnkcap & PCI_EXP_LNKCAP_SLS) == PCI_EXP_LNKCAP_SLS_5_0GB)
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 5e1f810..3d988e9 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -290,6 +290,15 @@ void pci_disable_bridge_window(struct pci_dev *dev);
 struct pci_bus *pci_bus_get(struct pci_bus *bus);
 void pci_bus_put(struct pci_bus *bus);
 
+/* PCIe link information from Link Capabilities 2 */
+#define PCIE_LNKCAP2_SLS2SPEED(lnkcap2) \
+	((lnkcap2) & PCI_EXP_LNKCAP2_SLS_32_0GB ? PCIE_SPEED_32_0GT : \
+	 (lnkcap2) & PCI_EXP_LNKCAP2_SLS_16_0GB ? PCIE_SPEED_16_0GT : \
+	 (lnkcap2) & PCI_EXP_LNKCAP2_SLS_8_0GB ? PCIE_SPEED_8_0GT : \
+	 (lnkcap2) & PCI_EXP_LNKCAP2_SLS_5_0GB ? PCIE_SPEED_5_0GT : \
+	 (lnkcap2) & PCI_EXP_LNKCAP2_SLS_2_5GB ? PCIE_SPEED_2_5GT : \
+	 PCI_SPEED_UNKNOWN)
+
 /* PCIe link information */
 #define PCI_SPEED2STR(speed) \
 	((speed) == PCI_SPEED_UNKNOWN ? "Unknown speed" : \
-- 
2.8.1

