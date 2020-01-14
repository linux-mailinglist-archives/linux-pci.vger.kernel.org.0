Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D49E513A2A6
	for <lists+linux-pci@lfdr.de>; Tue, 14 Jan 2020 09:15:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725860AbgANIPc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Jan 2020 03:15:32 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:38462 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725820AbgANIPc (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 14 Jan 2020 03:15:32 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id A5990DF56008EED06CC3;
        Tue, 14 Jan 2020 16:15:29 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.439.0; Tue, 14 Jan 2020 16:15:19 +0800
From:   Yicong Yang <yangyicong@hisilicon.com>
To:     <helgaas@kernel.org>, <linux-pci@vger.kernel.org>
CC:     <f.fangjian@huawei.com>
Subject: [PATCH] PCI: Improve link speed presentation process
Date:   Tue, 14 Jan 2020 16:11:34 +0800
Message-ID: <1578989494-20583-1-git-send-email-yangyicong@hisilicon.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Currently We use switch-case statements to acquire the speed
string according to the pci bus speed in current_link_speed_show()
and pcie_get_speed_cap(). It leads to redundant and when new
standard comes, we have to add cases in the related functions,
which is easy to omit at somewhere.

Abstract the judge statements out. Use macros and pci speed
arrays instead. Then only the macros and arrays need to be
extended when next generation comes.

Link: https://lore.kernel.org/linux-pci/20200113211728.GA113776@google.com/
Suggested-by: Bjorn Helgaas <helgaas@kernel.org>
Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
---
Previously we get speed from sysfs likes "16.0 GT/s", etc. In this PATCH,
we get the speed string from pci_bus_speed_strings[], and it'll look like
"16.0 GT/s PCIe", etc. It makes no more affects and maybe make the information
more detailed.

 drivers/pci/pci-sysfs.c | 24 +++---------------------
 drivers/pci/pci.c       | 12 +-----------
 drivers/pci/pci.h       | 20 ++++++++++++++------
 drivers/pci/slot.c      |  2 +-
 4 files changed, 19 insertions(+), 39 deletions(-)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 7934129..8bcb136 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -175,33 +175,15 @@ static ssize_t current_link_speed_show(struct device *dev,
 	struct pci_dev *pci_dev = to_pci_dev(dev);
 	u16 linkstat;
 	int err;
-	const char *speed;
+	enum pci_bus_speed link_speed;
 
 	err = pcie_capability_read_word(pci_dev, PCI_EXP_LNKSTA, &linkstat);
 	if (err)
 		return -EINVAL;
 
-	switch (linkstat & PCI_EXP_LNKSTA_CLS) {
-	case PCI_EXP_LNKSTA_CLS_32_0GB:
-		speed = "32 GT/s";
-		break;
-	case PCI_EXP_LNKSTA_CLS_16_0GB:
-		speed = "16 GT/s";
-		break;
-	case PCI_EXP_LNKSTA_CLS_8_0GB:
-		speed = "8 GT/s";
-		break;
-	case PCI_EXP_LNKSTA_CLS_5_0GB:
-		speed = "5 GT/s";
-		break;
-	case PCI_EXP_LNKSTA_CLS_2_5GB:
-		speed = "2.5 GT/s";
-		break;
-	default:
-		speed = "Unknown speed";
-	}
+	link_speed = pcie_link_speed[linkstat & PCI_EXP_LNKSTA_CLS];
 
-	return sprintf(buf, "%s\n", speed);
+	return sprintf(buf, "%s\n", PCIE_SPEED2STR(link_speed));
 }
 static DEVICE_ATTR_RO(current_link_speed);
 
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index a97e257..ea72e6d8 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5658,17 +5658,7 @@ enum pci_bus_speed pcie_get_speed_cap(struct pci_dev *dev)
 	 */
 	pcie_capability_read_dword(dev, PCI_EXP_LNKCAP2, &lnkcap2);
 	if (lnkcap2) { /* PCIe r3.0-compliant */
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
+		return PCIE_LNKCAP2_SLS2SPEED(lnkcap2);
 	}
 
 	pcie_capability_read_dword(dev, PCI_EXP_LNKCAP, &lnkcap);
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 3f6947e..90cacf6 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -9,6 +9,7 @@
 #define PCI_VSEC_ID_INTEL_TBT	0x1234	/* Thunderbolt */
 
 extern const unsigned char pcie_link_speed[];
+extern const char *pci_bus_speed_strings[];
 extern bool pci_early_dump;
 
 bool pcie_cap_has_lnkctl(const struct pci_dev *dev);
@@ -286,17 +287,24 @@ void pci_disable_bridge_window(struct pci_dev *dev);
 struct pci_bus *pci_bus_get(struct pci_bus *bus);
 void pci_bus_put(struct pci_bus *bus);
 
+/* PCIe link information from Link Capabilities 2 */
+#define PCIE_LNKCAP2_SLS2SPEED(mask) \
+	((mask) & PCI_EXP_LNKCAP2_SLS_32_0GB ? PCIE_SPEED_32_0GT : \
+	 (mask) & PCI_EXP_LNKCAP2_SLS_16_0GB ? PCIE_SPEED_16_0GT : \
+	 (mask) & PCI_EXP_LNKCAP2_SLS_8_0GB ? PCIE_SPEED_8_0GT : \
+	 (mask) & PCI_EXP_LNKCAP2_SLS_5_0GB ? PCIE_SPEED_5_0GT : \
+	 (mask) & PCI_EXP_LNKCAP2_SLS_2_5GB ? PCIE_SPEED_2_5GT : \
+	 PCI_SPEED_UNKNOWN)
+
 /* PCIe link information */
 #define PCIE_SPEED2STR(speed) \
-	((speed) == PCIE_SPEED_16_0GT ? "16 GT/s" : \
-	 (speed) == PCIE_SPEED_8_0GT ? "8 GT/s" : \
-	 (speed) == PCIE_SPEED_5_0GT ? "5 GT/s" : \
-	 (speed) == PCIE_SPEED_2_5GT ? "2.5 GT/s" : \
-	 "Unknown speed")
+	((speed) == PCI_SPEED_UNKNOWN ? "Unknown speed" : \
+	 pci_bus_speed_strings[speed])
 
 /* PCIe speed to Mb/s reduced by encoding overhead */
 #define PCIE_SPEED2MBS_ENC(speed) \
-	((speed) == PCIE_SPEED_16_0GT ? 16000*128/130 : \
+	((speed) == PCIE_SPEED_32_0GT ? 32000*128/130 : \
+	 (speed) == PCIE_SPEED_16_0GT ? 16000*128/130 : \
 	 (speed) == PCIE_SPEED_8_0GT  ?  8000*128/130 : \
 	 (speed) == PCIE_SPEED_5_0GT  ?  5000*8/10 : \
 	 (speed) == PCIE_SPEED_2_5GT  ?  2500*8/10 : \
diff --git a/drivers/pci/slot.c b/drivers/pci/slot.c
index ae4aa0e..08a59ed 100644
--- a/drivers/pci/slot.c
+++ b/drivers/pci/slot.c
@@ -50,7 +50,7 @@ static ssize_t address_read_file(struct pci_slot *slot, char *buf)
 }
 
 /* these strings match up with the values in pci_bus_speed */
-static const char *pci_bus_speed_strings[] = {
+const char *pci_bus_speed_strings[] = {
 	"33 MHz PCI",		/* 0x00 */
 	"66 MHz PCI",		/* 0x01 */
 	"66 MHz PCI-X",		/* 0x02 */
-- 
2.8.1

