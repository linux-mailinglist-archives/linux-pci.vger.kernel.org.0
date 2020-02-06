Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E73F15428E
	for <lists+linux-pci@lfdr.de>; Thu,  6 Feb 2020 12:03:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727379AbgBFLDd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 6 Feb 2020 06:03:33 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:48936 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726744AbgBFLDd (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 6 Feb 2020 06:03:33 -0500
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id BA1F29588DD0F2DB51E9;
        Thu,  6 Feb 2020 19:03:22 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.439.0; Thu, 6 Feb 2020 19:03:16 +0800
From:   Yicong Yang <yangyicong@hisilicon.com>
To:     <helgaas@kernel.org>, <linux-pci@vger.kernel.org>
CC:     <f.fangjian@huawei.com>, <huangdaode@huawei.com>
Subject: [PATCH v2 5/6] PCI: Add PCIE_LNKCAP2_SLS2SPEED macro
Date:   Thu, 6 Feb 2020 18:59:19 +0800
Message-ID: <1580986760-10182-6-git-send-email-yangyicong@hisilicon.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1580986760-10182-1-git-send-email-yangyicong@hisilicon.com>
References: <1580986760-10182-1-git-send-email-yangyicong@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add PCIE_LNKCAP2_SLS2SPEED macro for transforming raw link cap 2
value to link speed. Use it in pcie_get_speed_cap() to replace
judgement statements. Then we don't need to touch the functions
when new link speed comes.

Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
---
 drivers/pci/pci.c | 17 ++++-------------
 drivers/pci/pci.h |  9 +++++++++
 2 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 7285fe0..99f34d5 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5783,19 +5783,10 @@ enum pci_bus_speed pcie_get_speed_cap(struct pci_dev *dev)
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
index ba6b2cb..7651749 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -299,6 +299,15 @@ void pci_bus_put(struct pci_bus *bus);
 	((speed) < pci_bus_speed_strings_size ? \
 	 pci_bus_speed_strings[speed] : "Unknown speed")
 
+/* PCIe link information from Link Capabilities 2 */
+#define PCIE_LNKCAP2_SLS2SPEED(lnkcap2) \
+	((lnkcap2) & PCI_EXP_LNKCAP2_SLS_32_0GB ? PCIE_SPEED_32_0GT : \
+	 (lnkcap2) & PCI_EXP_LNKCAP2_SLS_16_0GB ? PCIE_SPEED_16_0GT : \
+	 (lnkcap2) & PCI_EXP_LNKCAP2_SLS_8_0GB ? PCIE_SPEED_8_0GT : \
+	 (lnkcap2) & PCI_EXP_LNKCAP2_SLS_5_0GB ? PCIE_SPEED_5_0GT : \
+	 (lnkcap2) & PCI_EXP_LNKCAP2_SLS_2_5GB ? PCIE_SPEED_2_5GT : \
+	 PCI_SPEED_UNKNOWN)
+
 /* PCIe speed to Mb/s reduced by encoding overhead */
 #define PCIE_SPEED2MBS_ENC(speed) \
 	((speed) == PCIE_SPEED_32_0GT ? 32000*128/130 : \
-- 
2.8.1

